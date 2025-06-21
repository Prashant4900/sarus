import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// Service for tracking events with Mixpanel
class MixpanelService {
  MixpanelService({
    required String projectToken,
    http.Client? httpClient,
  })  : _projectToken = projectToken,
        _httpClient = httpClient ?? http.Client();
  static const String _mixpanelUrl = 'https://api.mixpanel.com/track';
  final String _projectToken;
  final http.Client _httpClient;

  /// Generate a unique user ID based on system info
  String _generateUserId() {
    try {
      // Use a combination of username and hostname for anonymized tracking
      final username = Platform.environment['USER'] ??
          Platform.environment['USERNAME'] ??
          'unknown';
      final hostname = Platform.localHostname;
      final combined = '$username@$hostname';

      // Hash it for privacy
      final bytes = utf8.encode(combined);
      final digest = sha256.convert(bytes);
      return digest.toString().substring(0, 16);
    } catch (e) {
      // Fallback to a random identifier
      return DateTime.now().millisecondsSinceEpoch.toString();
    }
  }

  /// Track an event with Mixpanel
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? properties,
    Duration timeout = const Duration(seconds: 3),
  }) async {
    try {
      final userId = _generateUserId();

      final eventData = {
        'event': eventName,
        'properties': {
          'token': _projectToken,
          'distinct_id': userId,
          'time': DateTime.now().millisecondsSinceEpoch,
          r'$insert_id':
              '${userId}_${eventName}_${DateTime.now().millisecondsSinceEpoch}',
          // Add CLI-specific properties
          'cli_version': Platform.version,
          'platform': Platform.operatingSystem,
          'platform_version': Platform.operatingSystemVersion,
          // Add custom properties
          if (properties != null) ...properties,
        },
      };

      final encodedData = base64Encode(utf8.encode(json.encode(eventData)));

      final response = await _httpClient
          .post(
            Uri.parse(_mixpanelUrl),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
            body: 'data=$encodedData',
          )
          .timeout(timeout);

      // Mixpanel returns "1" for success
      if (response.statusCode == 200 && response.body == '1') {
        // Success - event tracked
        return;
      } else {
        // Log error but don't fail the command
        print(
            'Mixpanel tracking failed: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      // Silently fail - don't let analytics break the CLI
      // You could add debug logging here if needed
      print('Analytics error (non-critical): $e');
    }
  }

  /// Track command usage
  Future<void> trackCommandUsage(
    String commandName, {
    Map<String, dynamic>? additionalProperties,
  }) async {
    await trackEvent(
      'command_executed',
      properties: {
        'command_name': commandName,
        'timestamp': DateTime.now().toIso8601String(),
        if (additionalProperties != null) ...additionalProperties,
      },
    );
  }

  /// Track CLI startup
  Future<void> trackCliStartup({
    String? version,
    List<String>? args,
  }) async {
    await trackEvent(
      'cli_startup',
      properties: {
        'version': version,
        'args_count': args?.length ?? 0,
        'has_command': args != null && args.isNotEmpty,
      },
    );
  }

  /// Dispose of resources
  void dispose() {
    _httpClient.close();
  }
}
