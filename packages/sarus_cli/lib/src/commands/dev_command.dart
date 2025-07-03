import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:yaml/yaml.dart';

/// {@template dev_command}
/// `sarus_cli dev`
/// A [Command] to run the Sarus server locally for development.
/// {@endtemplate}
class DevCommand extends Command<int> {
  DevCommand({
    required Logger logger,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _mixpanelService = mixpanelService {
    argParser.addOption(
      'flavor',
      abbr: 'f',
      help: 'Specify the flavor/environment to use (optional)',
    );
  }

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

      // Step 1: Check and load configuration
      await _loadConfiguration();

      _logger.info('🚀 Starting Sarus server locally...');
      final process = await Process.start(
        'dart',
        ['run', 'bin/server.dart'],
        mode: ProcessStartMode.inheritStdio,
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

  /// Loads configuration from config.yaml and processes environment files
  Future<void> _loadConfiguration() async {
    final configFile = File('config.yaml');

    // Check if config.yaml exists
    if (!configFile.existsSync()) {
      throw Exception('config.yaml file not found in the root directory');
    }

    _logger.info('📋 Loading configuration from config.yaml...');

    // Parse config.yaml
    final configContent = await configFile.readAsString();
    final config = loadYaml(configContent) as Map;

    // Check if env section exists
    if (!config.containsKey('env')) {
      // No env section means user doesn't want flavors/env management
      // Just check for default .env file in root
      _logger.info(
        '📋 No env section found in config.yaml, checking for default .env file',
      );
      await _loadEnvironmentVariables('.env', 'default');
      return;
    }

    final envConfig = config['env'] as Map;
    final defaultFlavor = envConfig['default'] as String? ?? 'development';
    final flavors = envConfig['flavors'] as Map?;

    // Determine which flavor to use - always use default if no flavor specified
    var selectedFlavor = defaultFlavor;

    // Only override if user explicitly provided a flavor via command line
    final userProvidedFlavor = argResults?['flavor'] as String?;
    if (userProvidedFlavor != null && userProvidedFlavor.isNotEmpty) {
      selectedFlavor = userProvidedFlavor;
    }

    _logger.info('🎯 Selected flavor: $selectedFlavor');

    String? envFilePath;

    // Check if flavors are defined and find the env file
    if (flavors != null) {
      if (!flavors.containsKey(selectedFlavor)) {
        throw Exception(
          'Flavor "$selectedFlavor" not found in config.yaml flavors',
        );
      }
      envFilePath = flavors[selectedFlavor] as String?;
    }

    // If no specific env file defined, try default .env
    envFilePath ??= '.env';

    // Load environment variables
    await _loadEnvironmentVariables(envFilePath, selectedFlavor);
  }

  /// Loads environment variables from the specified file and creates dart_tool config
  Future<void> _loadEnvironmentVariables(
    String envFilePath,
    String selectedFlavor,
  ) async {
    final envFile = File(envFilePath);
    var envVars = <String, String>{};

    if (envFile.existsSync()) {
      _logger.info('📄 Loading environment variables from $envFilePath');

      final envContent = await envFile.readAsString();
      envVars = _parseEnvFile(envContent);

      _logger.info('✅ Loaded ${envVars.length} environment variables');
    } else {
      // Only throw error if this is a flavor-specific file that was explicitly defined
      if (selectedFlavor != 'default' && envFilePath != '.env') {
        // Check if this env file was explicitly defined in config.yaml
        final configFile = File('config.yaml');
        final configContent = await configFile.readAsString();
        final config = loadYaml(configContent) as Map;

        if (config.containsKey('env')) {
          final envConfig = config['env'] as Map;
          final flavors = envConfig['flavors'] as Map?;

          if (flavors != null && flavors.containsKey(selectedFlavor)) {
            // If flavor is explicitly defined but file doesn't exist, throw error
            throw Exception(
              'Environment file "$envFilePath" specified for flavor "$selectedFlavor" not found',
            );
          }
        }
      }

      // For default .env or when no explicit config, just continue silently
      _logger.info(
        '⚠️  No environment file found at $envFilePath, proceeding without explicit environment variables',
      );
    }

    // Create .dart_tool/sarus directory if it doesn't exist
    final sarusDir = Directory(path.join('.dart_tool', 'sarus'));
    if (!sarusDir.existsSync()) {
      await sarusDir.create(recursive: true);
    }

    // Create environment configuration file in .dart_tool/sarus
    await _createDartToolEnvConfig(envVars, selectedFlavor);
  }

  /// Parses a .env file and returns a map of environment variables
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

  /// Removes surrounding quotes from a string value
  String _removeQuotes(String value) {
    if ((value.startsWith('"') && value.endsWith('"')) ||
        (value.startsWith("'") && value.endsWith("'"))) {
      return value.substring(1, value.length - 1);
    }
    return value;
  }

  /// Creates a JSON configuration file in .dart_tool/sarus for accessing environment variables
  Future<void> _createDartToolEnvConfig(
    Map<String, String> envVars,
    String flavor,
  ) async {
    // Create .dart_tool/sarus directory if it doesn't exist
    final sarusDir = Directory(path.join('.dart_tool', 'sarus'));
    if (!sarusDir.existsSync()) {
      await sarusDir.create(recursive: true);
    }

    final configPath = path.join('.dart_tool', 'sarus', 'env.json');
    final configFile = File(configPath);

    // Create the JSON structure
    final jsonData = {
      'flavor': flavor,
      'timestamp': DateTime.now().toIso8601String(),
      'envVars': envVars,
    };

    // Write JSON file with pretty formatting
    final jsonString = const JsonEncoder.withIndent('  ').convert(jsonData);
    await configFile.writeAsString(jsonString);

    _logger.info('📝 Created environment configuration at ${configFile.path}');
    _logger.info('💡 Environment variables are now available in JSON format');
    _logger
        .info('🔄 File will be rebuilt every time you run "sarus dev" command');
  }
}
