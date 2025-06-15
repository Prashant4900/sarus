import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
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
