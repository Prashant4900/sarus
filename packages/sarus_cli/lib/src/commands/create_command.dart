import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/sarus_bundle.dart';

// A valid Dart identifier that can be used for a package, i.e. no
// capital letters.
// https://dart.dev/guides/language/language-tour#important-concepts
final RegExp _identifierRegExp = RegExp('[a-z_][a-z0-9_]*');

/// {@template check_node_command}
///
/// `sarus_cli check-node`
/// A [Command] to check if Node.js is installed on the system
/// {@endtemplate}
class CreateCommand extends Command<int> {
  /// {@macro check_node_command}
  CreateCommand({
    required Logger logger,
    GeneratorBuilder? generator,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle;

  @override
  String get description => 'Create a new sarus project.';

  @override
  String get name => 'create';

  final Logger _logger;

  final GeneratorBuilder _generator;

  @override
  Future<int> run() async {
    /// Check if Node.js is installed
    await checkNode();

    /// Generate a new sarus project
    await generateBrick();

    return ExitCode.success.code;
  }

  String get projectName {
    final name = argResults!.rest.first;
    if (!_identifierRegExp.hasMatch(name)) {
      throw ArgumentError('Invalid project name: $name');
    }
    return name;
  }

  /// Generates a new sarus project.
  ///
  /// This uses the [Mason] CLI to generate a new project from the
  /// [Brick] located at [bricks].
  ///
  /// The generated project is placed in the current working directory.
  ///
  /// The following variables are used:
  ///
  /// * `name`: the name of the project. This is used to generate the project
  ///   name in the `pubspec.yaml` file.
  ///
  /// If there is an error during generation, an error message is printed to
  /// stderr.
  Future<void> generateBrick() async {
    try {
      _logger.info('Generating new project...');

      final generator = await _generator(sarusBundle);
      final target = DirectoryGeneratorTarget(Directory.current);
      await generator.generate(
        target,
        logger: _logger,
        fileConflictResolution: FileConflictResolution.overwrite,
        vars: {'name': projectName},
      );

      await generator.hooks.postGen(
        logger: _logger,
        workingDirectory: '${Directory.current.path}/$projectName',
        vars: {'name': projectName},
      );
    } catch (e) {
      _logger.err('Error generating brick: $e');
    }
  }

  /// Checks if Node.js is installed on the system by running the `node -v` command.
  ///
  /// If Node.js is not installed, logs a warning message. If there is an error
  /// running the command, logs an error message and exits with code 1.
  Future<void> checkNode() async {
    try {
      // Check for Node.js by running the `node -v` command
      final result = await Process.run('node', ['-v']);

      // If the result exits with 0, Node.js is installed
      if (result.exitCode != 0) {
        _logger.warn('Node.js is not installed.');
      }
    } catch (e) {
      // Catch any errors (e.g., Process not found)
      _logger.err('Error checking Node.js installation: $e');
      exit(1);
    }
  }
}
