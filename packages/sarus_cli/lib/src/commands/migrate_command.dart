import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/utils/env.dart';

/// {@template check_node_command}
/// A [Command] that generates a module schema.
/// {@endtemplate}
class MigrateCommand extends Command<int> {
  /// {@macro check_node_command}
  MigrateCommand({
    required Logger logger,
  }) : _logger = logger;

  @override
  String get description => 'Migrate database.';

  @override
  String get name => 'migrate';

  final Logger _logger;

  @override
  Future<int> run() async {
    await generateSQL();

    return ExitCode.success.code;
  }

  Future<void> generateSQL() async {
    try {
      final currentDir = Directory.current;
      _logger.info('Migrating database...');

      final env = Env()..init();

      final result = await Process.run(
        'dart',
        [
          'run',
          'stormberry',
          'migrate',
          '--db',
          '${env.get(EnvKey.DB_NAME)}',
          '--host',
          '${env.get(EnvKey.DB_HOST)}',
          '--port',
          '${env.get(EnvKey.DB_PORT)}',
          '--username',
          '${env.get(EnvKey.DB_USER)}',
          '--password',
          '${env.get(EnvKey.DB_PASSWORD)}',
          '--apply-changes',
          'yes',
        ],
        workingDirectory: currentDir.path,
      );

      if (result.exitCode != 0) {
        _logger.warn('Error migrating database: ${result.stderr}');
      } else {
        _logger.info('Database migrated successfully.');
      }
    } catch (e) {
      _logger.err('Error migrating database: $e');
    }
  }
}
