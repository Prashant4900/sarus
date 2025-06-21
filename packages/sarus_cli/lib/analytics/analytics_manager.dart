import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

class AnalyticsManager {
  static const String _measurementId = 'G-3ZZYT1CJRV';
  static const String _apiSecret = 'AIzaSyDeLzndzgYiughdN0BvrOb_hQbgSQF2Yioxc';
  static const String _endpoint = 'https://www.google-analytics.com/mp/collect';

  static String? _clientId;
  static String? _sessionId;
  static bool _consentGiven = true;
  static final Logger _logger = Logger();

  // Initialize analytics
  static Future<void> initialize() async {
    try {
      await _loadClientId();
      await _loadConsent();
      _sessionId = _generateSessionId();
    } catch (e) {
      // Silent fail on analytics initialization
    }
  }

  // Load or generate client ID
  static Future<void> _loadClientId() async {
    final configDir = await _getConfigDirectory();
    final clientIdFile = File(path.join(configDir.path, 'client_id'));

    if (clientIdFile.existsSync()) {
      _clientId = await clientIdFile.readAsString();
    } else {
      _clientId = _generateClientId();
      await clientIdFile.writeAsString(_clientId!);
    }
  }

  // Load consent status
  static Future<void> _loadConsent() async {
    final configDir = await _getConfigDirectory();
    final consentFile = File(path.join(configDir.path, 'analytics_consent'));
    _consentGiven = consentFile.existsSync();
  }

  // Get config directory
  static Future<Directory> _getConfigDirectory() async {
    final homeDir = Platform.environment['HOME'] ??
        Platform.environment['USERPROFILE'] ??
        '';
    final configDir = Directory(path.join(homeDir, '.sarus_cli'));

    if (!configDir.existsSync()) {
      await configDir.create(recursive: true);
    }

    return configDir;
  }

  // Generate unique client ID
  static String _generateClientId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final hostname = Platform.localHostname;
    final random = DateTime.now().microsecondsSinceEpoch;
    return sha256
        .convert(utf8.encode('$hostname-$timestamp-$random'))
        .toString()
        .substring(0, 32);
  }

  // Generate session ID
  static String _generateSessionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  // Request user consent
  static Future<void> requestConsent() async {
    if (_consentGiven == true) return;

    try {
      _logger.info('');
      _logger.info('📊 ${lightCyan.wrap('Help improve Sarus CLI!')}');
      _logger.info(
        "We'd like to collect anonymous usage data to improve the tool.",
      );
      _logger.info(
        'This includes command usage, errors, and performance metrics.',
      );
      _logger
          .info('${lightGray.wrap('No personal information is collected.')}');
      _logger.info('');

      stdout.write('${lightYellow.wrap('Allow anonymous analytics?')} (y/n): ');
      final input = stdin.readLineSync()?.trim().toLowerCase();

      if (input == 'y' || input == 'yes') {
        await _saveConsent(true);
        _logger.success(
          'Analytics enabled. Thank you for helping us improve Sarus!',
        );
      } else {
        await _saveConsent(false);
        _logger.info('Analytics disabled.');
      }
    } catch (e) {
      // If consent request fails, disable analytics
      _consentGiven = false;
    }
  }

  // Save consent status
  static Future<void> _saveConsent(bool consent) async {
    try {
      final configDir = await _getConfigDirectory();
      final consentFile = File(path.join(configDir.path, 'analytics_consent'));

      if (consent) {
        await consentFile.writeAsString('granted');
        _consentGiven = true;
      } else {
        if (consentFile.existsSync()) {
          await consentFile.delete();
        }
        _consentGiven = false;
      }
    } catch (e) {
      _consentGiven = false;
    }
  }

  // Check if analytics is enabled
  static bool get isEnabled => _consentGiven == true;

  // Track command usage
  static Future<void> trackCommand(
    String command, {
    Map<String, dynamic>? parameters,
    Duration? executionTime,
    bool success = true,
  }) async {
    if (!isEnabled) return;

    await _sendEvent('command_executed', {
      'command_name': command,
      'success': success,
      'execution_time_ms': executionTime?.inMilliseconds,
      'platform': Platform.operatingSystem,
      ...?parameters,
    });
  }

  // Track CLI start
  static Future<void> trackAppStart() async {
    if (!isEnabled) return;

    await _sendEvent('cli_start', {
      'platform': Platform.operatingSystem,
      'platform_version': Platform.operatingSystemVersion,
      'dart_version': Platform.version,
    });
  }

  // Track errors
  static Future<void> trackError(
    String error, {
    String? command,
    String? context,
  }) async {
    if (!isEnabled) return;

    await _sendEvent('error_occurred', {
      'error_type': error.length > 50 ? error.substring(0, 50) : error,
      'command': command,
      'context': context,
      'platform': Platform.operatingSystem,
    });
  }

  // Track project creation with details
  static Future<void> trackProjectCreation(
    String projectName, {
    Duration? totalTime,
    bool success = true,
    String? errorStep,
  }) async {
    if (!isEnabled) return;

    await _sendEvent('project_created', {
      'success': success,
      'total_time_ms': totalTime?.inMilliseconds,
      'error_step': errorStep,
      'has_custom_name': projectName != 'sarus_project',
    });
  }

  // Track module generation
  static Future<void> trackModuleCreation(
    String moduleName, {
    Duration? executionTime,
    bool success = true,
  }) async {
    if (!isEnabled) return;

    await _sendEvent('module_created', {
      'success': success,
      'execution_time_ms': executionTime?.inMilliseconds,
      'has_custom_name': moduleName != 'default_module',
    });
  }

  // Track update operations
  static Future<void> trackUpdate(
    bool success, {
    String? fromVersion,
    String? toVersion,
    Duration? updateTime,
  }) async {
    if (!isEnabled) return;

    await _sendEvent('cli_updated', {
      'success': success,
      'from_version': fromVersion,
      'to_version': toVersion,
      'update_time_ms': updateTime?.inMilliseconds,
    });
  }

  // Send event to Google Analytics
  static Future<void> _sendEvent(
    String eventName,
    Map<String, dynamic> parameters,
  ) async {
    try {
      if (_clientId == null || _sessionId == null) return;

      final payload = {
        'client_id': _clientId,
        'events': [
          {
            'name': eventName,
            'params': {
              'session_id': _sessionId,
              'engagement_time_msec': '1',
              ...parameters
                  .map((key, value) => MapEntry(key, value?.toString())),
            },
          },
        ],
      };

      await http
          .post(
            Uri.parse(
              '$_endpoint?measurement_id=$_measurementId&api_secret=$_apiSecret',
            ),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 3));
    } catch (e) {
      // Silently fail - don't interrupt user experience
    }
  }

  // Analytics management methods
  static Future<void> enableAnalytics() async {
    await _saveConsent(true);
    _logger.success('Analytics enabled successfully.');
  }

  static Future<void> disableAnalytics() async {
    await _saveConsent(false);
    _logger.info('Analytics disabled successfully.');
  }

  static Future<void> showStatus() async {
    await _loadConsent();
    if (isEnabled) {
      _logger.info('Analytics: ${lightGreen.wrap('Enabled')}');
      _logger.detail('Client ID: ${_clientId?.substring(0, 8)}...');
    } else {
      _logger.info('Analytics: ${lightRed.wrap('Disabled')}');
    }
  }
}
