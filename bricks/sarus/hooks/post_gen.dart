import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) {
  context.logger.info('Running dart fix --apply...');

  final result = Process.runSync('dart', ['fix', '--apply']);

  if (result.exitCode == 0) {
    context.logger.info('dart fix --apply executed successfully.');
  } else {
    context.logger.err('Failed to run dart fix --apply: ${result.stderr}');
  }
}
