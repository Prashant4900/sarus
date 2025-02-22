import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';

/// {@template check_node_command}
///
/// `sarus_cli check-node`
/// A [Command] to check if Node.js is installed on the system
/// {@endtemplate}
class CreateCommand extends Command<int> {
  /// {@macro check_node_command}
  CreateCommand({
    required Logger logger,
  }) : _logger = logger;

  @override
  String get description => 'Create a new sarus project.';

  @override
  String get name => 'create';

  final Logger _logger;

  @override
  Future<int> run() async {
    // Check if Node.js is installed
    await checkNode();

    return ExitCode.success.code;
  }

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
