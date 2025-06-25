import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';

/// {@template dev_command}
/// `sarus_cli dev`
/// A [Command] to run the Sarus server locally for development.
/// {@endtemplate}
class DevCommand extends Command<int> {
  DevCommand({
    required Logger logger,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _mixpanelService = mixpanelService;

  final Logger _logger;
  final MixpanelService? _mixpanelService;

  @override
  String get description => 'Run the Sarus server locally in development mode.';

  @override
  String get name => 'dev';

  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();
    try {
      await _mixpanelService?.trackEvent(
        'dev_started',
        properties: {
          'command': name,
          'timestamp': startTime.toIso8601String(),
        },
      );

      _logger.info('🚀 Starting Sarus server locally...');
      final process = await Process.start(
        'dart',
        ['run', 'bin/server.dart'],
        mode: ProcessStartMode.inheritStdio, // directly connects stdout/stderr
      );

      // Handle process exit
      final exitCode = await process.exitCode;
      _logger.info('Sarus server exited with code $exitCode');

      await _mixpanelService?.trackEvent(
        'dev_stopped',
        properties: {
          'command': name,
          'duration_seconds': DateTime.now().difference(startTime).inSeconds,
          'exit_code': exitCode,
        },
      );

      return exitCode;
    } catch (e) {
      _logger.err('Failed to start server: $e');
      await _mixpanelService?.trackEvent(
        'dev_failed',
        properties: {
          'command': name,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );
      return ExitCode.osError.code;
    }
  }
}
