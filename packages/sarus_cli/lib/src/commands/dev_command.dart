import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:yaml/yaml.dart';

/// A command for running the Sarus server locally in development mode.
///
/// This command handles the complete development workflow including:
/// - Configuration loading from config.yaml
/// - Environment variable management with flavor support
/// - Server startup and monitoring
/// - Analytics tracking for development metrics
///
/// ## Usage:
/// ```bash
/// # Run with default flavor
/// sarus dev
///
/// # Run with specific flavor
/// sarus dev --flavor production
/// sarus dev -f staging
/// ```
///
/// ## Configuration:
/// The command expects a `config.yaml` file in the root directory with optional
/// environment configuration:
///
/// ```yaml
/// env:
///   default: development
///   flavors:
///     development: .env.dev
///     staging: .env.staging
///     production: .env.prod
/// ```
///
/// ## Environment Files:
/// Environment files should follow the standard .env format:
/// ```
/// API_URL=https://api.example.com
/// DATABASE_URL=postgresql://localhost/mydb
/// DEBUG=true
/// ```
///
/// ## Generated Files:
/// The command generates `.dart_tool/sarus/env.json` containing:
/// - Current flavor configuration
/// - Loaded environment variables
/// - Timestamp of last generation
///
/// {@template dev_command}
/// `sarus_cli dev`
/// A [Command] to run the Sarus server locally for development.
/// {@endtemplate}
class DevCommand extends Command<int> {
  /// Creates a new DevCommand instance.
  ///
  /// [logger] The logger instance for output messaging
  /// [mixpanelService] Optional analytics service for tracking development metrics
  DevCommand({required Logger logger, MixpanelService? mixpanelService})
    : _logger = logger,
      _mixpanelService = mixpanelService {
    argParser.addOption(
      'flavor',
      abbr: 'f',
      help: 'Specify the flavor/environment to use (optional)',
    );
  }

  /// Logger instance for command output
  final Logger _logger;

  /// Optional analytics service for tracking command usage and performance
  final MixpanelService? _mixpanelService;

  @override
  String get description => 'Run the Sarus server locally in development mode.';

  @override
  String get name => 'dev';

  /// Executes the development server command.
  ///
  /// This method orchestrates the complete development workflow:
  /// 1. Tracks command start for analytics
  /// 2. Loads and processes configuration
  /// 3. Starts the Dart server process
  /// 4. Monitors server execution
  /// 5. Tracks completion metrics
  ///
  /// Returns the exit code from the server process, or [ExitCode.osError]
  /// if the command fails to execute.
  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();

    try {
      // Track command start for analytics
      await _trackCommandStart(startTime);

      // Load configuration and environment variables
      await _loadConfiguration();

      // Start the server and wait for completion
      final exitCode = await _startServer();

      // Track successful completion
      await _trackCommandSuccess(startTime, exitCode);

      return exitCode;
    } catch (e) {
      _logger.err('Failed to start server: $e');
      await _trackCommandFailure(e);
      return ExitCode.osError.code;
    }
  }

  /// Tracks the start of the dev command for analytics purposes.
  ///
  /// Records the command name and start timestamp for performance
  /// and usage analytics.
  ///
  /// [startTime] The timestamp when the command was initiated
  Future<void> _trackCommandStart(DateTime startTime) async {
    await _mixpanelService?.trackEvent(
      'dev_started',
      properties: {'command': name, 'timestamp': startTime.toIso8601String()},
    );
  }

  /// Tracks successful completion of the dev command.
  ///
  /// Records command duration and exit code for performance monitoring
  /// and success rate analytics.
  ///
  /// [startTime] The timestamp when the command was initiated
  /// [exitCode] The exit code returned by the server process
  Future<void> _trackCommandSuccess(DateTime startTime, int exitCode) async {
    await _mixpanelService?.trackEvent(
      'dev_stopped',
      properties: {
        'command': name,
        'duration_seconds': DateTime.now().difference(startTime).inSeconds,
        'exit_code': exitCode,
      },
    );
  }

  /// Tracks command failure for error monitoring and analytics.
  ///
  /// Records error details for debugging and reliability monitoring.
  ///
  /// [error] The error that caused the command to fail
  Future<void> _trackCommandFailure(Object error) async {
    await _mixpanelService?.trackEvent(
      'dev_failed',
      properties: {
        'command': name,
        'error_type': error.runtimeType.toString(),
        'error_message': error.toString(),
      },
    );
  }

  /// Starts the Dart server process and monitors its execution.
  ///
  /// Creates a new process running `dart run bin/server.dart` with
  /// inherited stdio for real-time output visibility.
  ///
  /// Returns the exit code from the server process.
  Future<int> _startServer() async {
    _logger.info('Starting Sarus server...');

    final process = await Process.start('dart', [
      'run',
      'bin/server.dart',
    ], mode: ProcessStartMode.inheritStdio);

    final exitCode = await process.exitCode;
    _logger.info('Server stopped with exit code $exitCode');

    return exitCode;
  }

  /// Loads and processes configuration from config.yaml and environment files.
  ///
  /// This method handles the complete configuration workflow:
  /// 1. Validates config.yaml existence
  /// 2. Parses configuration structure
  /// 3. Determines active flavor (default or user-specified)
  /// 4. Loads appropriate environment variables
  /// 5. Generates runtime configuration files
  ///
  /// Throws [Exception] if configuration is invalid or required files are missing.
  Future<void> _loadConfiguration() async {
    final configFile = File('config.yaml');

    if (!configFile.existsSync()) {
      throw Exception('config.yaml file not found in the root directory');
    }

    _logger.info('Loading configuration...');

    // Parse the main configuration file
    final configContent = await configFile.readAsString();
    final config = loadYaml(configContent) as Map;

    // Process environment configuration
    if (!config.containsKey('env')) {
      // No env section - use default .env file
      await _loadEnvironmentVariables('.env', 'default');
      return;
    }

    // Extract environment configuration
    final envConfig = config['env'] as Map;
    final defaultFlavor = envConfig['default'] as String? ?? 'development';
    final flavors = envConfig['flavors'] as Map?;

    // Determine active flavor
    final selectedFlavor = _determineActiveFlavor(defaultFlavor);
    final envFilePath = _getEnvFilePath(flavors, selectedFlavor);

    _logger.info('Using flavor: $selectedFlavor');

    // Load environment variables and generate configuration
    await _loadEnvironmentVariables(envFilePath, selectedFlavor);

    _logger.info('Configuration loaded successfully');
  }

  /// Determines which flavor should be active based on user input and defaults.
  ///
  /// Prioritizes user-provided flavor from command line arguments,
  /// falling back to the default flavor if none specified.
  ///
  /// [defaultFlavor] The default flavor from configuration
  ///
  /// Returns the name of the active flavor.
  String _determineActiveFlavor(String defaultFlavor) {
    final userProvidedFlavor = argResults?['flavor'] as String?;

    if (userProvidedFlavor != null && userProvidedFlavor.isNotEmpty) {
      return userProvidedFlavor;
    }

    return defaultFlavor;
  }

  /// Resolves the environment file path for the specified flavor.
  ///
  /// Looks up the flavor in the flavors configuration and returns
  /// the associated environment file path, or defaults to '.env'.
  ///
  /// [flavors] The flavors configuration map from config.yaml
  /// [selectedFlavor] The active flavor name
  ///
  /// Returns the path to the environment file.
  ///
  /// Throws [Exception] if the specified flavor is not found in configuration.
  String _getEnvFilePath(
    Map<dynamic, dynamic>? flavors,
    String selectedFlavor,
  ) {
    if (flavors != null) {
      if (!flavors.containsKey(selectedFlavor)) {
        throw Exception(
          'Flavor "$selectedFlavor" not found in config.yaml flavors',
        );
      }
      return flavors[selectedFlavor] as String? ?? '.env';
    }

    return '.env';
  }

  /// Loads environment variables from the specified file and creates runtime configuration.
  ///
  /// This method handles the complete environment variable workflow:
  /// 1. Reads and parses the environment file
  /// 2. Validates file existence based on flavor configuration
  /// 3. Generates .dart_tool/sarus/env.json for runtime access
  ///
  /// [envFilePath] Path to the environment file to load
  /// [selectedFlavor] The active flavor name for configuration context
  ///
  /// Throws [Exception] if explicitly configured environment files are missing.
  Future<void> _loadEnvironmentVariables(
    String envFilePath,
    String selectedFlavor,
  ) async {
    final envFile = File(envFilePath);
    var envVars = <String, String>{};

    if (envFile.existsSync()) {
      final envContent = await envFile.readAsString();
      envVars = _parseEnvFile(envContent);
    } else {
      // Validate that missing files are acceptable
      await _validateMissingEnvFile(envFilePath, selectedFlavor);
    }

    // Generate runtime configuration
    await _createDartToolEnvConfig(envVars, selectedFlavor);
  }

  /// Validates whether a missing environment file should cause an error.
  ///
  /// Checks if the environment file was explicitly configured for the
  /// current flavor. If so, throws an error. Otherwise, allows the
  /// command to continue without environment variables.
  ///
  /// [envFilePath] Path to the missing environment file
  /// [selectedFlavor] The active flavor name
  ///
  /// Throws [Exception] if the missing file was explicitly configured.
  Future<void> _validateMissingEnvFile(
    String envFilePath,
    String selectedFlavor,
  ) async {
    // Only throw error if this is a flavor-specific file that was explicitly defined
    if (selectedFlavor != 'default' && envFilePath != '.env') {
      final configFile = File('config.yaml');
      final configContent = await configFile.readAsString();
      final config = loadYaml(configContent) as Map;

      if (config.containsKey('env')) {
        final envConfig = config['env'] as Map;
        final flavors = envConfig['flavors'] as Map?;

        if (flavors != null && flavors.containsKey(selectedFlavor)) {
          throw Exception(
            'Environment file "$envFilePath" specified for flavor "$selectedFlavor" not found',
          );
        }
      }
    }
  }

  /// Parses a .env file content and returns a map of environment variables.
  ///
  /// Supports standard .env file format with:
  /// - KEY=VALUE pairs
  /// - Comments starting with #
  /// - Empty lines (ignored)
  /// - Quoted values (quotes are removed)
  ///
  /// [content] The raw content of the .env file
  ///
  /// Returns a map of environment variable names to values.
  ///
  /// ## Example:
  /// ```
  /// # Database configuration
  /// DB_HOST=localhost
  /// DB_PORT=5432
  /// DB_NAME="my_database"
  /// DEBUG=true
  /// ```
  Map<String, String> _parseEnvFile(String content) {
    final envVars = <String, String>{};
    final lines = content.split('\n');

    for (final line in lines) {
      final trimmedLine = line.trim();

      // Skip empty lines and comments
      if (trimmedLine.isEmpty || trimmedLine.startsWith('#')) {
        continue;
      }

      // Parse KEY=VALUE pairs
      final equalsIndex = trimmedLine.indexOf('=');
      if (equalsIndex > 0) {
        final key = trimmedLine.substring(0, equalsIndex).trim();
        final value = trimmedLine.substring(equalsIndex + 1).trim();

        // Remove quotes if present
        final cleanValue = _removeQuotes(value);
        envVars[key] = cleanValue;
      }
    }

    return envVars;
  }

  /// Removes surrounding quotes from a string value.
  ///
  /// Handles both single and double quotes, removing them only
  /// if they surround the entire value.
  ///
  /// [value] The string value that may have surrounding quotes
  ///
  /// Returns the string with quotes removed if they were present.
  ///
  /// ## Examples:
  /// ```dart
  /// _removeQuotes('"hello"') // Returns: hello
  /// _removeQuotes("'world'") // Returns: world
  /// _removeQuotes('no quotes') // Returns: no quotes
  /// ```
  String _removeQuotes(String value) {
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      return value.substring(1, value.length - 1);
    }
    return value;
  }

  /// Creates a JSON configuration file in .dart_tool/sarus for runtime access.
  ///
  /// Generates a structured JSON file containing:
  /// - Active flavor name
  /// - Generation timestamp
  /// - All loaded environment variables
  ///
  /// This file can be read by the server application to access
  /// environment configuration at runtime.
  ///
  /// [envVars] Map of environment variables to include
  /// [flavor] The active flavor name
  ///
  /// The generated file structure:
  /// ```json
  /// {
  ///   "flavor": "development",
  ///   "timestamp": "2023-01-01T00:00:00.000Z",
  ///   "envVars": {
  ///     "API_URL": "https://api.example.com",
  ///     "DEBUG": "true"
  ///   }
  /// }
  /// ```
  Future<void> _createDartToolEnvConfig(
    Map<String, String> envVars,
    String flavor,
  ) async {
    // Ensure the sarus directory exists
    final sarusDir = Directory(path.join('.dart_tool', 'sarus'));
    if (!sarusDir.existsSync()) {
      await sarusDir.create(recursive: true);
    }

    // Create the configuration file
    final configPath = path.join('.dart_tool', 'sarus', 'env.json');
    final configFile = File(configPath);

    // Structure the JSON data
    final jsonData = {
      'flavor': flavor,
      'timestamp': DateTime.now().toIso8601String(),
      'envVars': envVars,
    };

    // Write the formatted JSON file
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);
    await configFile.writeAsString(jsonString);
  }
}
