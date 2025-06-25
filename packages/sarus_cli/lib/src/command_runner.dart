import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/src/version.dart';

const executableName = 'sarus';
const packageName = 'sarus_cli';
const description = 'A fast, minimalistic backend framework for Dart.';

/// {@template sarus_cli_command_runner}
/// A [CommandRunner] for the CLI.
///
/// ```bash
/// $ sarus_cli --version
/// ```
/// {@endtemplate}
class SarusCliCommandRunner extends CompletionCommandRunner<int> {
  /// {@macro sarus_cli_command_runner}
  SarusCliCommandRunner({
    Logger? logger,
    PubUpdater? pubUpdater,
    MixpanelService? mixpanelService,
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
        _mixpanelService = mixpanelService ?? MixpanelService(),
        super(executableName, description) {
    // Add root options and flags
    argParser
      ..addFlag(
        'version',
        abbr: 'v',
        negatable: false,
        help: 'Print the current version.',
      )
      ..addFlag(
        'verbose',
        help: 'Noisy logging, including all shell commands executed.',
      )
      ..addFlag(
        'no-analytics',
        negatable: false,
        help: 'Disable analytics tracking.',
        hide: true, // Hide from help but allow users to opt out
      );

    // Add sub commands - pass mixpanel service to commands that need it
    addCommand(
      CreateCommand(
        logger: _logger,
        mixpanelService: _mixpanelService,
      ),
    );
    addCommand(
      CreateModuleCommand(
        logger: _logger,
        mixpanelService: _mixpanelService,
      ),
    );
    addCommand(
      BuildCommand(
        logger: _logger,
        mixpanelService: _mixpanelService,
      ),
    );
    addCommand(
      DevCommand(
        logger: _logger,
        mixpanelService: _mixpanelService,
      ),
    );
    addCommand(
      UpdateCommand(
        logger: _logger,
        pubUpdater: _pubUpdater,
        mixpanelService: _mixpanelService,
      ),
    );
  }

  @override
  void printUsage() => _logger.info(usage);

  final Logger _logger;
  final PubUpdater _pubUpdater;
  final MixpanelService _mixpanelService;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      final topLevelResults = parse(args);

      // Track CLI startup (if analytics not disabled)
      // if (topLevelResults['no-analytics'] != true) {
      await _mixpanelService.trackCliStartup(
        version: packageVersion,
        args: args.toList(),
      );
      // }

      if (topLevelResults['verbose'] == true) {
        _logger.level = Level.verbose;
      }

      return await runCommand(topLevelResults) ?? ExitCode.success.code;
    } on FormatException catch (e, stackTrace) {
      // Track error (if analytics enabled)
      // final topLevelResults = parse(args);

      // if (topLevelResults['no-analytics'] != true) {
      await _mixpanelService.trackEvent(
        'cli_error',
        properties: {
          'error_type': 'format_exception',
          'error_message': e.message,
        },
      );
      // }

      // On format errors, show the commands error message, root usage and
      // exit with an error code
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      // Track error (if analytics enabled)
      // final topLevelResults = parse(args);

      // if (topLevelResults['no-analytics'] != true) {
      await _mixpanelService.trackEvent(
        'cli_error',
        properties: {
          'error_type': 'usage_exception',
          'error_message': e.message,
        },
      );
      // }

      // On usage errors, show the commands usage message and
      // exit with an error code
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    final analyticsEnabled = topLevelResults['no-analytics'] != true;

    // Fast track completion command
    if (topLevelResults.command?.name == 'completion') {
      if (analyticsEnabled) {
        await _mixpanelService.trackCommandUsage('completion');
      }
      await super.runCommand(topLevelResults);
      return ExitCode.success.code;
    }

    // Verbose logs
    _logger
      ..detail('Argument information:')
      ..detail('  Top level options:');
    for (final option in topLevelResults.options) {
      if (topLevelResults.wasParsed(option)) {
        _logger.detail('  - $option: ${topLevelResults[option]}');
      }
    }
    if (topLevelResults.command != null) {
      final commandResult = topLevelResults.command!;
      _logger
        ..detail('  Command: ${commandResult.name}')
        ..detail('    Command options:');
      for (final option in commandResult.options) {
        if (commandResult.wasParsed(option)) {
          _logger.detail('    - $option: ${commandResult[option]}');
        }
      }
    }

    // Run the command or show version
    final int? exitCode;
    if (topLevelResults['version'] == true) {
      if (analyticsEnabled) {
        await _mixpanelService.trackCommandUsage('version');
      }
      _logger.info(packageVersion);
      exitCode = ExitCode.success.code;
    } else {
      // Track command execution
      if (analyticsEnabled && topLevelResults.command?.name != null) {
        await _mixpanelService.trackCommandUsage(
          topLevelResults.command!.name!,
          additionalProperties: {
            'args_count': topLevelResults.arguments.length,
            'has_options': topLevelResults.command!.options.isNotEmpty,
          },
        );
      }

      exitCode = await super.runCommand(topLevelResults);
    }

    // Check for updates
    if (topLevelResults.command?.name != UpdateCommand.commandName) {
      await _checkForUpdates();
    }

    return exitCode;
  }

  /// Checks if the current version (set by the build runner on the
  /// version.dart file) is the most recent one. If not, show a prompt to the
  /// user.
  Future<void> _checkForUpdates() async {
    try {
      final latestVersion = await _pubUpdater.getLatestVersion(packageName);
      final isUpToDate = packageVersion == latestVersion;
      if (!isUpToDate) {
        // Track update availability
        await _mixpanelService.trackEvent(
          'update_available',
          properties: {
            'current_version': packageVersion,
            'latest_version': latestVersion,
          },
        );

        _logger
          ..info('')
          ..info(
            '''
${lightYellow.wrap('Update available!')} ${lightCyan.wrap(packageVersion)} \u2192 ${lightCyan.wrap(latestVersion)}
Run ${lightCyan.wrap('$executableName update')} to update''',
          );
      }
    } catch (_) {}
  }

  /// Clean up resources
  void dispose() {
    _mixpanelService.dispose();
  }
}
