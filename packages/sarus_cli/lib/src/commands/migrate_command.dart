// ignore_for_file: cascade_invocations

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:yaml/yaml.dart';

/// {@template migrate_command}
///
/// `sarus_cli migrate`
/// A [Command] to handle Prisma migrations for root and module schemas
/// {@endtemplate}
class MigrateCommand extends Command<int> {
  /// {@macro migrate_command}
  MigrateCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'name',
        abbr: 'n',
        help: 'Name the migration',
      )
      ..addFlag(
        'create-only',
        help: 'Create a new migration but do not apply it',
        negatable: false,
      )
      ..addFlag(
        'skip-generate',
        help: 'Skip triggering generators (e.g. Prisma Client)',
        negatable: false,
      )
      ..addFlag(
        'skip-seed',
        help: 'Skip triggering seed',
        negatable: false,
      )
      ..addOption(
        'module',
        help: 'Specify a module name to migrate only that module',
      );
  }

  @override
  String get description =>
      'Run Prisma migrations for root and module schemas.';

  @override
  String get name => 'migrate';

  final Logger _logger;

  @override
  Future<int> run() async {
    if (!await _checkProjectRoot()) {
      _logger
          .err('Error: Must run this command from the project root directory.');
      return ExitCode.usage.code;
    }

    final moduleName = argResults?['module'] as String?;

    if (moduleName != null) {
      // Migrate specific module
      return _migrateModule(moduleName);
    } else {
      // Migrate root and all modules
      await _migrateRoot();
      await _migrateAllModules();
      return ExitCode.success.code;
    }
  }

  /// Checks if the command is being run from the project root
  Future<bool> _checkProjectRoot() async {
    final file = File('sarus.yml');
    return file.existsSync();
  }

  /// Builds the command arguments based on provided flags
  List<String> _buildCommandArgs() {
    final args = ['prisma', 'migrate', 'dev'];

    final migrationName = argResults?['name'] as String?;
    if (migrationName != null) {
      args.addAll(['--name', migrationName]);
    }

    if (argResults?['create-only'] as bool? ?? false) {
      args.add('--create-only');
    }

    if (argResults?['skip-generate'] as bool? ?? false) {
      args.add('--skip-generate');
    }

    if (argResults?['skip-seed'] as bool? ?? false) {
      args.add('--skip-seed');
    }

    return args;
  }

  /// Executes migration for root schema
  Future<void> _migrateRoot() async {
    final rootSchema = File('prisma/schema.prisma');

    if (rootSchema.existsSync()) {
      _logger.info('Running migration for root schema...');

      try {
        final args = _buildCommandArgs();
        args.addAll(['--schema', 'prisma/schema.prisma']);

        final result = await Process.run(
          'npx',
          args,
          runInShell: true,
        );

        if (result.exitCode != 0) {
          _logger.err('Error in root schema migration:');
          _logger.err(result.stderr as String);
        } else {
          _logger.success('Root schema migration completed successfully.');
        }
      } catch (e) {
        _logger.err('Error executing migration for root schema: $e');
      }
    }
  }

  /// Executes migration for a specific module
  Future<int> _migrateModule(String moduleName) async {
    try {
      final file = File('sarus.yml');
      final content = file.readAsStringSync();
      final yaml = loadYaml(content) as Map;

      final modules = (yaml['modules'] as List<dynamic>? ?? []).cast<String>();

      if (!modules.contains(moduleName)) {
        _logger.err('Error: Module "$moduleName" not found in sarus.yml');
        return ExitCode.usage.code;
      }

      final schemaPath = 'lib/$moduleName/schema/schema.prisma';
      final schemaFile = File(schemaPath);

      if (!schemaFile.existsSync()) {
        _logger.err('Error: Schema not found at $schemaPath');
        return ExitCode.usage.code;
      }

      _logger.info('Running migration for module "$moduleName"...');

      try {
        final args = _buildCommandArgs();
        args.addAll(['--schema', schemaPath]);

        final result = await Process.run(
          'npx',
          args,
          runInShell: true,
        );

        if (result.exitCode != 0) {
          _logger.err('Error in module migration:');
          _logger.err(result.stderr as String);
          return ExitCode.software.code;
        } else {
          _logger.success(
            'Module "$moduleName" migration completed successfully.',
          );
          return ExitCode.success.code;
        }
      } catch (e) {
        _logger.err('Error executing migration for module "$moduleName": $e');
        return ExitCode.software.code;
      }
    } catch (e) {
      _logger.err('Error reading or parsing sarus.yml: $e');
      return ExitCode.software.code;
    }
  }

  /// Executes migration for all modules
  Future<void> _migrateAllModules() async {
    try {
      final file = File('sarus.yml');
      final content = file.readAsStringSync();
      final yaml = loadYaml(content) as Map;

      final modules = (yaml['modules'] as List<dynamic>? ?? []).cast<String>();

      for (final module in modules) {
        final schemaPath = 'lib/$module/schema/schema.prisma';
        final schemaFile = File(schemaPath);

        if (schemaFile.existsSync()) {
          _logger.info('Running migration for module "$module"...');

          try {
            final args = _buildCommandArgs();
            args.addAll(['--schema', schemaPath]);

            final result = await Process.run(
              'npx',
              args,
              runInShell: true,
            );

            if (result.exitCode != 0) {
              _logger.err('Error in module migration:');
              _logger.err(result.stderr as String);
            } else {
              _logger.success(
                'Module "$module" migration completed successfully.',
              );
            }
          } catch (e) {
            _logger.err('Error executing migration for module "$module": $e');
          }
        }
      }
    } catch (e) {
      _logger.err('Error reading or parsing sarus.yml: $e');
    }
  }
}
