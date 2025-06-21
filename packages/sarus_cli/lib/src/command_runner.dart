import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:cli_completion/cli_completion.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:pub_updater/pub_updater.dart';
import 'package:sarus_cli/analytics/analytics_wrapper.dart';
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
  })  : _logger = logger ?? Logger(),
        _pubUpdater = pubUpdater ?? PubUpdater(),
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
      );

    // Add sub commands
    addCommand(CreateCommand(logger: _logger));
    addCommand(CreateModuleCommand(logger: _logger));
    addCommand(DevCommand(logger: _logger));
    addCommand(UpdateCommand(logger: _logger, pubUpdater: _pubUpdater));
  }

  @override
  void printUsage() => _logger.info(usage);

  final Logger _logger;
  final PubUpdater _pubUpdater;

  @override
  Future<int> run(Iterable<String> args) async {
    try {
      await SarusAnalytics.init();

      // Request consent on first run (only if not analytics command)
      if (args.isNotEmpty && args.first != 'analytics') {
        await SarusAnalytics.requestConsentIfNeeded();
      }

      final topLevelResults = parse(args);
      if (topLevelResults['verbose'] == true) {
        _logger.level = Level.verbose;
      }

      final exitCode =
          await runCommand(topLevelResults) ?? ExitCode.success.code;

      // Track successful command execution
      if (exitCode == ExitCode.success.code &&
          topLevelResults.command != null) {
        await SarusAnalytics.trackCommand(
          topLevelResults.command!.name ?? 'error',
        );
      }

      return exitCode;
    } on FormatException catch (e, stackTrace) {
      // Track error
      await SarusAnalytics.trackError(
        'FormatException: ${e.message}',
        context: 'command_parsing',
      );

      // On format errors, show the commands error message, root usage and
      // exit with an error code
      _logger
        ..err(e.message)
        ..err('$stackTrace')
        ..info('')
        ..info(usage);
      return ExitCode.usage.code;
    } on UsageException catch (e) {
      // Track error
      await SarusAnalytics.trackError(
        'UsageException: ${e.message}',
        context: 'command_usage',
      );

      // On usage errors, show the commands usage message and
      // exit with an error code
      _logger
        ..err(e.message)
        ..info('')
        ..info(e.usage);
      return ExitCode.usage.code;
    } catch (e, stackTrace) {
      // Track unexpected errors
      await SarusAnalytics.trackError(
        'UnexpectedException: $e',
        context: 'command_execution',
      );

      // On unexpected errors, show the error message and stack trace
      _logger
        ..err('An unexpected error occurred: $e')
        ..err('$stackTrace');
      return ExitCode.software.code;
    }
  }

  @override
  Future<int?> runCommand(ArgResults topLevelResults) async {
    // Fast track completion command
    if (topLevelResults.command?.name == 'completion') {
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
      _logger.info(packageVersion);
      exitCode = ExitCode.success.code;
    } else {
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
}
