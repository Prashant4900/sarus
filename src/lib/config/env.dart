import 'dart:io';
import 'package:dotenv/dotenv.dart';

import 'config.dart';

class EnvKey {
  static const String DB_HOST = 'DB_HOST';
  static const String DB_PASSWORD = 'DB_PASSWORD';
  static const String DB_PORT = 'DB_PORT';
  static const String DB_USER = 'DB_USER';
  static const String DB_NAME = 'DB_NAME';
}

class Env {
  static final DotEnv _dotEnv = DotEnv();
  static bool _initialized = false;
  static bool _usingDotEnvFile = false;

  /// Automatically initializes environment variables
  /// - If .env file exists, loads from it
  /// - Otherwise, uses system environment variables
  static void init() {
    if (_initialized) return;

    try {
      print(Config.baseDir.path);
      final envFile = File('${Config.baseDir.path}/.env');

      if (envFile.existsSync()) {
        // .env file exists, use it
        _dotEnv.load([envFile.path]);
        _usingDotEnvFile = true;
      } else {
        // No .env file, use system environment variables
        _usingDotEnvFile = false;
        print('No .env file found, using system environment variables');
      }
    } catch (e) {
      print('Error during environment initialization: $e');
      print('Using system environment variables');
      _usingDotEnvFile = false;
    }

    _initialized = true;
  }

  /// Get environment variable - checks .env file first (if available),
  /// then falls back to system environment variables
  static String? get(String key) {
    // Ensure environment is initialized
    if (!_initialized) init();

    String? value;

    // Try .env file first if we're using it
    if (_usingDotEnvFile) {
      value = _dotEnv[key];
      if (value != null) return value;
    }

    // Fall back to system environment variables
    return Platform.environment[key];
  }

  /// Check if using .env file
  static bool get isUsingDotEnvFile => _usingDotEnvFile;
}
