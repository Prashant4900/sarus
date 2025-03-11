import 'dart:io';
import 'package:dotenv/dotenv.dart';
import 'package:mason/mason.dart';

class EnvKey {
  static const String DB_HOST = 'DB_HOST';
  static const String DB_PASSWORD = 'DB_PASSWORD';
  static const String DB_PORT = 'DB_PORT';
  static const String DB_USER = 'DB_USER';
  static const String DB_NAME = 'DB_NAME';
}

class Env {
  final DotEnv _dotEnv = DotEnv();
  final Logger _logger = Logger();

  /// Automatically initializes environment variables
  /// - If .env file exists, loads from it
  /// - Otherwise, uses system environment variables
  void init() {
    try {
      final baseDir = File(Platform.script.toFilePath()).parent.parent;
      _logger.info(baseDir.path);
      final envFile = File('${baseDir.path}/.env');

      if (envFile.existsSync()) {
        // .env file exists, use it
        _dotEnv.load([envFile.path]);
        _logger
            .info('Found .env file, loading environment variables from file');
      } else {
        // No .env file, use system environment variables
        _logger.err('No .env file found');
      }
    } catch (e) {
      _logger.err('Failed to load .env: $e');
    }
  }

  /// Get environment variable - checks .env file first (if available),
  /// then falls back to system environment variables
  String? get(String key) {
    // Ensure environment is initialized
    init();

    String? value;

    value = _dotEnv[key];
    if (value != null) return value;

    // Fall back to system environment variables
    return Platform.environment[key];
  }
}
