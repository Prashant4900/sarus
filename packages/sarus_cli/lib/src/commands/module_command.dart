import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/module_bundle.dart';
import 'package:yaml/yaml.dart';
import 'package:yaml_writer/yaml_writer.dart';

// RegExp for a valid Dart identifier
final RegExp _identifierRegExp = RegExp(r'^[a-z_][a-z0-9_]*$');

/// {@template create_module_command}
///
/// `sarus_cli create-module`
/// A [Command] to create a new module inside the Sarus project.
/// {@endtemplate}
class CreateModuleCommand extends Command<int> {
  /// {@macro create_module_command}
  CreateModuleCommand({
    required Logger logger,
    GeneratorBuilder? generator,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle;

  @override
  String get description => 'Create a new module inside the Sarus project.';

  @override
  String get name => 'module';

  final Logger _logger;

  final GeneratorBuilder _generator;

  @override
  Future<int> run() async {
    // Validate module name
    final module = moduleName;

    // Generate the module
    await generateModule(module);

    // Update sarus.yml
    await updateSarusConfig(module);

    return ExitCode.success.code;
  }

  /// Retrieves and validates the module name.
  String get moduleName {
    final name = argResults!.rest.first;
    if (!_identifierRegExp.hasMatch(name)) {
      throw ArgumentError('Invalid module name: $name');
    }
    return name;
  }

  /// Generates a new module using Mason.
  Future<void> generateModule(String module) async {
    try {
      _logger.info('Generating $module module...');

      final generator = await _generator(moduleBundle);
      final target = DirectoryGeneratorTarget(Directory.current);
      await generator.generate(
        target,
        vars: {'name': module},
      );

      await generator.hooks.postGen(
        logger: _logger,
        workingDirectory: Directory.current.path,
        vars: {'name': module},
      );

      _logger.info('Module "$module" created successfully.');
    } catch (e) {
      _logger.err('Error generating module: $e');
    }
  }

  /// Updates the `sarus.yml` file by adding the new module.
  Future<void> updateSarusConfig(String module) async {
    final file = File('sarus.yml');

    if (!file.existsSync()) {
      _logger.err('Error: sarus.yml not found in the project root.');
      exit(1);
    }

    try {
      final content = file.readAsStringSync();
      final yaml = loadYaml(content) as Map;

      // Ensure modules list exists
      final modules = (yaml['modules'] as List<dynamic>? ?? []).toList();

      // Avoid duplicates
      if (!modules.contains(module)) {
        modules.add(module);
      }

      // Write back to YAML file
      final updatedYaml = {'modules': modules};
      final yamlWriter = YamlWriter();
      file.writeAsStringSync(yamlWriter.write(updatedYaml));

      _logger.info('Added module "$module" to sarus.yml.');
    } catch (e) {
      _logger.err('Error updating sarus.yml: $e');
    }
  }
}
