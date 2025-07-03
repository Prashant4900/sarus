// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

/// Environment variable manager for Sarus applications.
///
/// This class provides access to environment variables with the following priority:
/// 1. Variables from .dart_tool/sarus/env.json (development)
/// 2. System environment variables
/// 3. Default values (if provided)
///
/// Usage:
/// ```dart
/// // Initialize once at app startup
/// await SarusEnv.load();
///
/// // Get variables
/// final apiKey = SarusEnv.get('API_KEY', throwIfMissing: true);
/// final port = SarusEnv.get('PORT', defaultValue: '3000');
/// final dbUrl = SarusEnv.get('DATABASE_URL');
/// ```
class SarusEnv {
  static final Map<String, String> _envVars = {};
  static String? _currentFlavor;
  static bool _isLoaded = false;
  static DateTime? _lastLoaded;

  /// Loads environment variables from .dart_tool/sarus/env.json if available.
  ///
  /// This method should be called once at application startup.
  /// It's safe to call multiple times - subsequent calls will reload the configuration.
  ///
  /// [forceReload] - If true, forces reloading even if already loaded
  static Future<void> load({bool forceReload = false}) async {
    if (_isLoaded && !forceReload) return;

    _envVars.clear();
    _currentFlavor = null;

    final envJsonFile = File('.dart_tool/sarus/env.json');

    if (envJsonFile.existsSync()) {
      try {
        final jsonContent = await envJsonFile.readAsString();
        final jsonData = jsonDecode(jsonContent) as Map<String, dynamic>;

        // Extract flavor information
        _currentFlavor = jsonData['flavor'] as String?;

        // Load environment variables
        final envVarsData = jsonData['envVars'] as Map<String, dynamic>?;
        if (envVarsData != null) {
          _envVars.addAll(envVarsData.cast<String, String>());
        }

        _lastLoaded = DateTime.now();
        _isLoaded = true;

        print(
          '🌍 Sarus Environment loaded: ${_envVars.length} variables from $_currentFlavor flavor',
        );
      } catch (e) {
        print('⚠️  Warning: Failed to load .dart_tool/sarus/env.json: $e');
        print('   Falling back to system environment variables only');
      }
    } else {
      print(
        '📝 No .dart_tool/sarus/env.json found, using system environment variables only',
      );
    }

    _isLoaded = true;
  }

  /// Gets an environment variable with flexible fallback options.
  ///
  /// Priority order:
  /// 1. Value from .dart_tool/sarus/env.json (if loaded)
  /// 2. System environment variable
  /// 3. Default value (if provided)
  ///
  /// [key] - The environment variable name
  /// [defaultValue] - Default value to use if variable is not found
  /// [throwIfMissing] - If true, throws exception when variable is missing and no default provided
  ///
  /// Returns the environment variable value or null if not found and no default provided
  static String? get(
    String key, {
    String? defaultValue,
    bool throwIfMissing = false,
  }) {
    // Ensure load() has been called
    if (!_isLoaded) {
      throw StateError(
          'SarusEnv.load() must be called before accessing environment variables. '
          "Call await SarusEnv.load() in your app's main() function.");
    }

    // Priority 1: Check loaded env.json variables
    var value = _envVars[key];

    // Priority 2: Check system environment variables
    value ??= Platform.environment[key];

    // Priority 3: Use default value
    value ??= defaultValue;

    // Handle missing required variables
    if (value == null && throwIfMissing) {
      throw EnvironmentVariableException(
        'Missing required environment variable: $key',
      );
    }

    return value;
  }

  /// Gets an environment variable and throws if missing (convenience method).
  ///
  /// This is equivalent to calling get(key, throwIfMissing: true).
  ///
  /// [key] - The environment variable name
  ///
  /// Returns the environment variable value, never null
  /// Throws [EnvironmentVariableException] if variable is not found
  static String getOrThrow(String key) {
    final value = get(key, throwIfMissing: true);
    return value!; // Safe to use ! here since throwIfMissing: true
  }

  /// Gets an environment variable with a default value (convenience method).
  ///
  /// This is equivalent to calling get(key, defaultValue: defaultValue).
  ///
  /// [key] - The environment variable name
  /// [defaultValue] - Default value to return if variable is not found
  ///
  /// Returns the environment variable value or the default value, never null
  static String getOrDefault(String key, String defaultValue) {
    final value = get(key, defaultValue: defaultValue);
    return value!; // Safe to use ! here since defaultValue is provided
  }

  /// Checks if an environment variable exists in any source.
  ///
  /// [key] - The environment variable name
  ///
  /// Returns true if the variable exists in env.json or system environment
  static bool has(String key) {
    if (!_isLoaded) {
      throw StateError(
        'SarusEnv.load() must be called before checking environment variables.',
      );
    }

    return _envVars.containsKey(key) || Platform.environment.containsKey(key);
  }

  /// Gets all loaded environment variables as a read-only map.
  ///
  /// This includes both variables from env.json and system environment variables.
  /// Variables from env.json take precedence over system variables.
  ///
  /// Returns a map of all available environment variables
  static Map<String, String> getAll() {
    if (!_isLoaded) {
      throw StateError(
        'SarusEnv.load() must be called before accessing environment variables.',
      );
    }

    final allVars = <String, String>{};

    // Add system environment variables first
    allVars.addAll(Platform.environment);

    // Add/override with env.json variables (higher priority)
    allVars.addAll(_envVars);

    return Map.unmodifiable(allVars);
  }

  /// Gets the current flavor/environment name.
  ///
  /// Returns the flavor name if loaded from env.json, otherwise null
  static String? get currentFlavor => _currentFlavor;

  /// Gets the timestamp when environment variables were last loaded.
  ///
  /// Returns the DateTime when load() was last called successfully, or null if never loaded
  static DateTime? get lastLoaded => _lastLoaded;

  /// Checks if environment variables have been loaded.
  ///
  /// Returns true if load() has been called successfully
  static bool get isLoaded => _isLoaded;

  /// Gets the number of variables loaded from env.json.
  ///
  /// This does not include system environment variables.
  ///
  /// Returns the count of variables loaded from .dart_tool/sarus/env.json
  static int get loadedVariableCount => _envVars.length;

  /// Reloads environment variables from the JSON file.
  ///
  /// This is useful during development when the env.json file might be updated
  /// by running `sarus dev` command again.
  static Future<void> reload() async {
    await load(forceReload: true);
  }

  /// Clears all loaded environment variables and resets state.
  ///
  /// This is primarily useful for testing purposes.
  static void clear() {
    _envVars.clear();
    _currentFlavor = null;
    _isLoaded = false;
    _lastLoaded = null;
  }

  /// Development helper method to print all loaded variables.
  ///
  /// [includeSystemVars] - If true, also prints system environment variables
  /// [maskSensitive] - If true, masks values that might contain sensitive data
  static void debugPrint({
    bool includeSystemVars = false,
    bool maskSensitive = true,
  }) {
    if (!_isLoaded) {
      print('SarusEnv: Not loaded yet. Call await SarusEnv.load() first.');
      return;
    }

    print('🔍 SarusEnv Debug Information:');
    print('   Flavor: ${_currentFlavor ?? 'none'}');
    print('   Last loaded: ${_lastLoaded ?? 'never'}');
    print('   Variables from env.json: ${_envVars.length}');

    if (_envVars.isNotEmpty) {
      print('   📄 Variables from .dart_tool/sarus/env.json:');
      _envVars.forEach((key, value) {
        final displayValue =
            maskSensitive && _isSensitiveKey(key) ? '***masked***' : value;
        print('      $key = $displayValue');
      });
    }

    if (includeSystemVars) {
      print(
        '   🖥️  System environment variables: ${Platform.environment.length}',
      );
      Platform.environment.forEach((key, value) {
        final displayValue =
            maskSensitive && _isSensitiveKey(key) ? '***masked***' : value;
        print('      $key = $displayValue');
      });
    }
  }

  /// Checks if a key might contain sensitive information
  static bool _isSensitiveKey(String key) {
    final sensitivePatterns = [
      'key',
      'secret',
      'token',
      'password',
      'pass',
      'auth',
      'credential',
    ];
    final lowerKey = key.toLowerCase();
    return sensitivePatterns.any(lowerKey.contains);
  }
}

/// Exception thrown when a required environment variable is missing.
class EnvironmentVariableException implements Exception {
  const EnvironmentVariableException(this.message);
  final String message;

  @override
  String toString() => 'EnvironmentVariableException: $message';
}
