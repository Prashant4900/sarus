import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.progress('Running dart pub get...');
  final result = Process.runSync(
    'dart',
    [
      'pub',
      'get',
    ],
    workingDirectory: Directory.current.path,
  );

  if (result.exitCode == 0) {
    context.logger.info('dart pub get executed successfully.');
  } else {
    context.logger.err('Failed to run dart pub get: ${result.stderr}');
  }

  context.logger.info('Generate routes...');

  final resultBuilder = Process.runSync('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
  ]);

  if (resultBuilder.exitCode == 0) {
    context.logger.info('Routes generated successfully.');
  } else {
    context.logger.err('Failed to generate routes: ${result.stderr}');
  }

  context.logger.progress('Running dart fix --apply...');
  final resultFix = Process.runSync(
    'dart',
    [
      'fix',
      '--apply',
    ],
    workingDirectory: Directory.current.path,
  );

  if (resultFix.exitCode == 0) {
    context.logger.info('dart fix --apply executed successfully.');
  } else {
    context.logger.err('Failed to run dart fix --apply: ${resultFix.stderr}');
  }
}
