import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_cli/src/generator/json_generator.dart';
import 'package:yaml/yaml.dart';

/// {@template make_migrations_command}
///
/// `sarus_orm makemigrations [app_label]`
///
/// Creates new migration files based on model changes in your app.
/// If app_label is provided, only that specific app's models will be checked for changes.
///
/// Examples:
/// ```bash
/// # Create migrations for all apps
/// $ sarus_orm make_migrations
///
/// # Create migrations for specific app
/// $ sarus_orm make_migrations your_app
/// ```
/// {@endtemplate}
class MakeMigrationsCommand extends Command<int> {
  /// {@macro make_migrations_command}
  MakeMigrationsCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addFlag(
        'dry-run',
        abbr: 'n',
        help:
            'Show migrations that would be created without actually writing files',
        negatable: false,
      )
      ..addFlag(
        'empty',
        help: 'Create an empty migration file',
        negatable: false,
      );
  }

  @override
  String get description =>
      'Creates new migration files based on model changes';

  @override
  String get name => 'makemigrations';

  final Logger _logger;

  @override
  Future<int> run() async {
    final appLabel =
        argResults?.rest.isEmpty ?? true ? null : argResults?.rest.first;
    final isDryRun = argResults?['dry-run'] == true;
    final isEmpty = argResults?['empty'] == true;

    if (isEmpty && appLabel == null) {
      _logger.err('You must provide an app label when using --empty');
      return ExitCode.usage.code;
    }

    try {
      final validProject = await validDartProject();
      if (!validProject) {
        _logger.err('This is not a valid Dart project');
        return ExitCode.usage.code;
      }

      if (appLabel != null && !await isAppRegistered(appLabel)) {
        _logger.err('App "$appLabel" is not registered in sarus.yaml');
        return ExitCode.usage.code;
      }

      if (isDryRun) {
        _logger.info('Would create migrations for detected changes (dry run)');
      } else {
        _logger.info('Creating migration files...');
      }

      final schemaFile = File(
        path.join(Directory.current.path, 'lib', appLabel, 'schema.yml'),
      );
      final schemaYaml = loadYaml(await schemaFile.readAsString()) as YamlMap;

      final generator = JsonGenerator(
        appLabel: appLabel!,
        schemaYaml: schemaYaml,
        dryRun: isDryRun,
        logger: _logger,
      );

      await generator.generate();

      return ExitCode.success.code;
    } catch (e) {
      _logger.err('Error creating migrations: $e');
      return ExitCode.software.code;
    }
  }
}

Future<bool> isAppRegistered(String appLabel) async {
  try {
    final basePath = Directory.current.path;
    final sarusFile = File(path.join(basePath, 'application.yaml'));

    if (!sarusFile.existsSync()) {
      throw Exception('application.yaml not found');
    }

    final sarusContent = await sarusFile.readAsString();
    final sarusConfig = loadYaml(sarusContent) as YamlMap;

    // Check if the 'apps' key exists and is a list
    if (!sarusConfig.containsKey('apps')) {
      throw Exception('App "$appLabel" is not registered in application.yaml');
    }

    final apps = sarusConfig['apps'];
    if (apps is! YamlList) {
      throw Exception('Invalid apps structure in application.yaml');
    }

    // Check if the appLabel exists in the apps list
    final isRegistered = apps.any((app) => app == appLabel);

    // If app is registered, also check if the folder and file exist
    if (isRegistered) {
      // Check app folder
      final appFolder = Directory(path.join(basePath, 'lib', appLabel));
      if (!appFolder.existsSync()) {
        throw Exception('App "$appLabel" folder not found');
      }

      // Check models.dart file
      final modelsFile = File(path.join(appFolder.path, 'schema.yml'));
      if (!modelsFile.existsSync()) {
        throw Exception('App "$appLabel" schema.yml file not found');
      }

      // Both registration and structure checks passed
      return true;
    }

    // App is not registered
    return false;
  } catch (e) {
    rethrow;
  }
}

Future<bool> validDartProject() async {
  try {
    // Use current directory
    final basePath = Directory.current.path;

    // Check for pubspec.yaml existence
    final pubspecFile = File(path.join(basePath, 'pubspec.yaml'));
    if (!pubspecFile.existsSync()) {
      throw Exception('pubspec.yaml not found');
    }

    // Read and parse pubspec.yaml
    final pubspecContent = await pubspecFile.readAsString();
    final pubspec = loadYaml(pubspecContent) as YamlMap;

    // Check required pubspec fields
    final requiredFields = ['name', 'environment'];
    for (final field in requiredFields) {
      if (!pubspec.containsKey(field)) {
        throw Exception('Missing required field in pubspec.yaml: $field');
      }
    }

    // Validate SDK constraint
    final environment = pubspec['environment'];
    if (environment is! YamlMap || !environment.containsKey('sdk')) {
      throw Exception('Missing or invalid SDK constraint in pubspec.yaml');
    }

    // Validate dependencies structure
    if (pubspec.containsKey('dependencies') &&
        pubspec['dependencies'] is! YamlMap) {
      throw Exception('Invalid dependencies structure in pubspec.yaml');
    }

    // Validate dev_dependencies structure
    if (pubspec.containsKey('dev_dependencies') &&
        pubspec['dev_dependencies'] is! YamlMap) {
      throw Exception('Invalid dev_dependencies structure in pubspec.yaml');
    }

    // Check for lib directory
    final libDir = Directory(path.join(basePath, 'lib'));
    if (!libDir.existsSync()) {
      throw Exception('lib directory not found');
    }

    // If we got here, all checks passed
    return true;
  } catch (e) {
    rethrow;
  }
}
