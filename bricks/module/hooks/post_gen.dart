import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.info('Generate routes...');

  final result = Process.runSync('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);

  if (result.exitCode == 0) {
    context.logger.info('Routes generated successfully.');
  } else {
    context.logger.err('Failed to generate routes: ${result.stderr}');
  }

  context.logger.info('Running dart fix --apply...');
  final resultFix = Process.runSync('dart', ['fix', '--apply']);

  if (resultFix.exitCode == 0) {
    context.logger.info('dart fix --apply executed successfully.');
  } else {
    context.logger.err('Failed to run dart fix --apply: ${resultFix.stderr}');
  }
}
