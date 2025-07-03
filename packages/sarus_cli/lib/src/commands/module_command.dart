// RegExp for a valid Dart identifier
import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/module_bundle.dart';

final RegExp _identifierRegExp = RegExp(r'^[a-z_][a-z0-9_]*$');

/// {@template create_module_command}
///
/// `sarus_cli create-module`
/// A [Command] to create a new module inside the Sarus project.
/// {@endtemplate}
class CreateModuleCommand extends Command<int> {
  CreateModuleCommand({
    required Logger logger,
    GeneratorBuilder? generator,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle,
        _mixpanelService = mixpanelService;

  @override
  String get description => 'Create a new module inside the Sarus project.';

  @override
  String get name => 'module';

  final Logger _logger;

  final GeneratorBuilder _generator;

  final MixpanelService? _mixpanelService;

  @override
  FutureOr<int>? run() async {
    // Validate module name
    final module = moduleName;
    final startTime = DateTime.now();

    try {
      await _mixpanelService?.trackEvent(
        'create_module_started',
        properties: {
          'module_name': module,
          'timestamp': startTime.toIso8601String(),
        },
      );

      // Generate the module
      await generateModule(module);

      // Update application.yml
      // await updateSarusConfig(module);

      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_module_completed',
        properties: {
          'module_name': module,
          'duration_seconds': duration.inSeconds,
          'success': true,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_module_failed',
        properties: {
          'module_name': module,
          'duration_seconds': duration.inSeconds,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      return ExitCode.tempFail.code;
    }
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

  // /// Updates the `application.yaml` file by adding the new module.
  // Future<void> updateSarusConfig(String module) async {
  //   final file = File('application.yaml');

  //   if (!file.existsSync()) {
  //     _logger.err('Error: application.yaml not found in the project root.');
  //     exit(1);
  //   }

  //   try {
  //     final content = file.readAsStringSync();
  //     final yaml = loadYaml(content) as Map;

  //     // Create a mutable copy of the original YAML content
  //     final mutableYaml = <String, dynamic>{};
  //     yaml.forEach((key, value) {
  //       mutableYaml[key.toString()] = value;
  //     });

  //     // Handle modules list
  //     final modules = (mutableYaml['modules'] as List<dynamic>? ?? []).toList();

  //     // Avoid duplicates
  //     if (!modules.contains(module)) {
  //       modules.add(module);
  //     }

  //     // Update only the modules key
  //     mutableYaml['modules'] = modules;

  //     // Write back to YAML file
  //     final yamlWriter = YamlWriter();
  //     file.writeAsStringSync(yamlWriter.write(mutableYaml));

  //     _logger.info('Added module "$module" to application.yaml.');
  //   } catch (e) {
  //     _logger.err('Error updating application.yaml: $e');
  //   }
  // }
}
