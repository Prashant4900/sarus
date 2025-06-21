import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/project_bundle.dart';

final RegExp _identifierRegExp = RegExp('[a-z_][a-z0-9_]*');

/// {@template check_node_command}
///
/// `sarus_cli check-node`
/// A [Command] to check if Node.js is installed on the system
/// {@endtemplate}
class CreateCommand extends Command<int> {
  CreateCommand({
    required Logger logger,
    GeneratorBuilder? generator,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle,
        _mixpanelService = mixpanelService;

  @override
  String get description => 'Create a new sarus project.';

  @override
  String get name => 'create';

  final Logger _logger;
  final GeneratorBuilder _generator;
  final MixpanelService? _mixpanelService;

  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();

    try {
      /// Track command start
      await _mixpanelService?.trackEvent(
        'create_command_started',
        properties: {
          'project_name': projectName,
          'timestamp': startTime.toIso8601String(),
        },
      );

      /// Check if Dart SDK is installed
      await checkDart();

      /// Generate a new sarus project
      await generateBrick();

      final duration = DateTime.now().difference(startTime);

      /// Track successful completion
      await _mixpanelService?.trackEvent(
        'create_command_completed',
        properties: {
          'project_name': projectName,
          'duration_seconds': duration.inSeconds,
          'success': true,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      final duration = DateTime.now().difference(startTime);

      /// Track failure
      await _mixpanelService?.trackEvent(
        'create_command_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': duration.inSeconds,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      rethrow;
    }
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
      _logger
        ..info('Starting Sarus project generation process...')
        ..progress('Step 1/5: Initializing project generator...');

      final generator = await _generator(projectBundle);

      _logger
        ..detail('Project generator initialized successfully.')
        ..progress('Step 2/5: Creating project structure...');
      final target = DirectoryGeneratorTarget(Directory.current);
      await generator.generate(
        target,
        logger: _logger,
        fileConflictResolution: FileConflictResolution.overwrite,
        vars: {'name': projectName},
      );

      _logger.success('Project "$projectName" structure created successfully.');

      // Track project structure creation
      await _mixpanelService?.trackEvent(
        'project_structure_created',
        properties: {
          'project_name': projectName,
        },
      );

      // Create workingDir variable for project path
      final workingDir = Directory('${Directory.current.path}/$projectName');

      _logger
        ..detail('Project working directory: ${workingDir.path}')
        ..progress('Step 3/5: Verifying project directory...');

      if (!workingDir.existsSync()) {
        _logger.err('Project directory not found at: ${workingDir.path}');
        throw Exception('Project directory creation failed');
      }

      _logger
        ..detail('Project directory verified successfully.')
        ..progress('Step 4/5: Generate routes...');

      final buildStartTime = DateTime.now();
      final resultBuilder = Process.runSync(
        'dart',
        [
          'run',
          'build_runner',
          'build',
          '--delete-conflicting-outputs',
        ],
        workingDirectory: workingDir.path,
      );

      final buildDuration = DateTime.now().difference(buildStartTime);

      if (resultBuilder.exitCode == 0) {
        _logger.detail('Routes generated successfully.');
        await _mixpanelService?.trackEvent(
          'build_runner_success',
          properties: {
            'project_name': projectName,
            'duration_seconds': buildDuration.inSeconds,
          },
        );
      } else {
        _logger.err('Failed to generate routes: ${resultBuilder.stderr}');
        await _mixpanelService?.trackEvent(
          'build_runner_failed',
          properties: {
            'project_name': projectName,
            'duration_seconds': buildDuration.inSeconds,
            'error': resultBuilder.stderr.toString(),
          },
        );
      }

      _logger
        ..detail('Project directory verified successfully.')
        ..progress('Step 5/6: Running dart pub get...');

      final pubGetStartTime = DateTime.now();
      final result = Process.runSync(
        'dart',
        [
          'pub',
          'get',
        ],
        workingDirectory: workingDir.path,
      );

      final pubGetDuration = DateTime.now().difference(pubGetStartTime);

      if (result.exitCode == 0) {
        _logger.detail('dart pub get executed successfully.');
        await _mixpanelService?.trackEvent(
          'pub_get_success',
          properties: {
            'project_name': projectName,
            'duration_seconds': pubGetDuration.inSeconds,
          },
        );
      } else {
        _logger.err('Failed to run dart pub get: ${result.stderr}');
        await _mixpanelService?.trackEvent(
          'pub_get_failed',
          properties: {
            'project_name': projectName,
            'duration_seconds': pubGetDuration.inSeconds,
            'error': result.stderr.toString(),
          },
        );
      }

      _logger
        ..detail('Project directory verified successfully.')
        ..progress('Step 6/6: Applying Dart fixes...')
        ..detail('Running dart fix to improve code quality...');

      final fixStartTime = DateTime.now();
      final resultFix = Process.runSync(
        'dart',
        [
          'fix',
          '--apply',
        ],
        workingDirectory: workingDir.path,
      );

      final fixDuration = DateTime.now().difference(fixStartTime);

      if (resultFix.exitCode == 0) {
        _logger
          ..success('Dart fixes applied successfully.')
          ..detail('Code linting and formatting completed.');
        await _mixpanelService?.trackEvent(
          'dart_fix_success',
          properties: {
            'project_name': projectName,
            'duration_seconds': fixDuration.inSeconds,
          },
        );
      } else {
        _logger
          ..err('Failed to run dart fix --apply: ${resultFix.stderr}')
          ..detail('Error code: ${resultFix.exitCode}');
        await _mixpanelService?.trackEvent(
          'dart_fix_failed',
          properties: {
            'project_name': projectName,
            'duration_seconds': fixDuration.inSeconds,
            'error': resultFix.stderr.toString(),
            'exit_code': resultFix.exitCode,
          },
        );
      }

      _logger
        ..info('Project generation completed successfully!')
        ..detail('Your new Sarus project is ready at: ${workingDir.path}');
    } catch (e) {
      _logger
        ..err('Error generating project: $e')
        ..detail(
          'Project generation failed. Please check the error message above.',
        );

      // Track generation failure
      await _mixpanelService?.trackEvent(
        'project_generation_failed',
        properties: {
          'project_name': projectName,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      rethrow;
    }
  }

  /// Checks if Dart SDK is installed on the system by running the
  /// `dart --version` command.
  ///
  /// If Dart SDK is not installed, logs a warning message. If there is an error
  /// running the command, logs an error message and exits with code 1.
  Future<void> checkDart() async {
    try {
      // Check for Dart SDK by running the `dart --version` command
      final result = await Process.run('dart', ['--version']);

      // If the result exits with 0, Dart SDK is installed
      if (result.exitCode != 0) {
        _logger.warn('Dart SDK is not installed.');
        await _mixpanelService?.trackEvent(
          'dart_sdk_check_failed',
          properties: {
            'exit_code': result.exitCode,
          },
        );
      } else {
        await _mixpanelService?.trackEvent('dart_sdk_check_success');
      }
    } catch (e) {
      // Catch any errors (e.g., Process not found)
      _logger.err('Error checking Dart SDK installation: $e');
      await _mixpanelService?.trackEvent(
        'dart_sdk_check_error',
        properties: {
          'error': e.toString(),
        },
      );
      exit(1);
    }
  }
}
