import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/command_runner.dart';
import 'package:sarus_cli/src/version.dart';

/// {@template update_command}
/// A command which updates the CLI.
/// {@endtemplate}
class UpdateCommand extends Command<int> {
  /// {@macro update_command}
  UpdateCommand({
    required Logger logger,
    PubUpdater? pubUpdater,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _pubUpdater = pubUpdater ?? PubUpdater(),
        _mixpanelService = mixpanelService;

  final Logger _logger;
  final PubUpdater _pubUpdater;
  final MixpanelService? _mixpanelService;

  @override
  String get description => 'Update the CLI.';

  static const String commandName = 'update';

  @override
  String get name => commandName;

  @override
  Future<int> run() async {
    final updateCheckProgress = _logger.progress('Checking for updates');
    late final String latestVersion;

    try {
      final startTime = DateTime.now();

      await _mixpanelService?.trackEvent(
        'update_command_started',
        properties: {
          'timestamp': startTime.toIso8601String(),
        },
      );

      latestVersion = await _pubUpdater.getLatestVersion(packageName);

      updateCheckProgress.complete('Checked for updates');

      final isUpToDate = packageVersion == latestVersion;
      if (isUpToDate) {
        _logger.info('CLI is already at the latest version.');
        await _mixpanelService?.trackEvent(
          'update_command_no_update_needed',
          properties: {
            'current_version': packageVersion,
          },
        );

        return ExitCode.success.code;
      }

      final updateProgress = _logger.progress('Updating to $latestVersion');

      late final ProcessResult result;
      result = await _pubUpdater.update(
        packageName: packageName,
        versionConstraint: latestVersion,
      );

      if (result.exitCode != ExitCode.success.code) {
        updateProgress.fail();
        _logger.err('Error updating CLI: ${result.stderr}');
        await _mixpanelService?.trackEvent(
          'update_command_failed',
          properties: {
            'error': result.stderr.toString(),
            'exit_code': result.exitCode,
          },
        );

        return ExitCode.software.code;
      }

      updateProgress.complete('Updated to $latestVersion');

      await _mixpanelService?.trackEvent(
        'update_command_completed',
        properties: {
          'new_version': latestVersion,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      await _mixpanelService?.trackEvent(
        'update_command_error',
        properties: {
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );
      _logger.err('$e');
      return ExitCode.software.code;
    }
  }
}
