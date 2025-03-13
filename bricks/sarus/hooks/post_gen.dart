import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.info('Generate model schema...');

  final projectDir = path.join(Directory.current.path, '{{name}}');

  final result = Process.runSync(
    'dart',
    [
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ],
    workingDirectory: projectDir,
  );

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
    workingDirectory: projectDir,
  );

  if (resultFix.exitCode == 0) {
    context.logger.info('dart fix --apply executed successfully.');
  } else {
    context.logger.err('Failed to run dart fix --apply: ${resultFix.stderr}');
  }
}
