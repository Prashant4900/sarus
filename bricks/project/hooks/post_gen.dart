import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.info('Generate model schema...');

  final result = Process.runSync(
      'dart',
      [
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
      ],
      workingDirectory: Directory.current.path);

  if (result.exitCode == 0) {
    context.logger.info('Model schema generated successfully.');
  } else {
    context.logger.err('Failed to generate model schema: ${result.stderr}');
  }

  context.logger.info('Running dart fix --apply...');
  final resultFix = Process.runSync(
      'dart',
      [
        'fix',
        '--apply',
      ],
      workingDirectory: Directory.current.path);

  if (resultFix.exitCode == 0) {
    context.logger.info('dart fix --apply executed successfully.');
  } else {
    context.logger.err('Failed to run dart fix --apply: ${resultFix.stderr}');
  }
}
