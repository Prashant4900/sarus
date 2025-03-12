import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/utils/env.dart';

/// {@template check_node_command}
/// A [Command] that generates a module schema.
/// {@endtemplate}
class GenerateSchemaCommand extends Command<int> {
  /// {@macro check_node_command}
  GenerateSchemaCommand({
    required Logger logger,
  }) : _logger = logger;

  @override
  String get description => 'Generate module schema.';

  @override
  String get name => 'generate-schema';

  final Logger _logger;

  @override
  Future<int> run() async {
    await generateSchema();
    await generateSQL();

    return ExitCode.success.code;
  }

  Future<void> generateSchema() async {
    try {
      final currentDir = Directory.current;
      _logger.info('Generating schema...');

      final result = await Process.run(
        'dart',
        ['run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        workingDirectory: currentDir.path,
      );

      if (result.exitCode != 0) {
        _logger.warn('Error generating schema: ${result.stderr}');
      } else {
        _logger.info('Schema generated successfully.');
      }
    } catch (e) {
      _logger.err('Error generating schema: $e');
    }
  }

  Future<void> generateSQL() async {
    try {
      final currentDir = Directory.current;
      _logger.info('Generating SQL...');

      final result = await Process.run(
        'dart',
        [
          'run',
          'stormberry',
          'migrate',
          '--db',
          '${Env().get(EnvKey.DB_NAME)}',
          '--host',
          '${Env().get(EnvKey.DB_HOST)}',
          '--port',
          '${Env().get(EnvKey.DB_PORT)}',
          '--username',
          '${Env().get(EnvKey.DB_USER)}',
          '--password',
          '${Env().get(EnvKey.DB_PASSWORD)}',
          '-o',
          'migration',
          '--apply-changes',
          'no',
        ],
        workingDirectory: currentDir.path,
      );

      if (result.exitCode != 0) {
        _logger.warn('Error generating SQL: ${result.stderr}');
      } else {
        _logger.info('SQL generated successfully.');
      }
    } catch (e) {
      _logger.err('Error generating SQL: $e');
    }
  }
}
