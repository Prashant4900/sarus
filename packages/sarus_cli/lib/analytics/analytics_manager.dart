import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

// Replace with your actual Mixpanel project token
const String _mixpanelToken = 'e8f959f7c72641b182c366a4d9616f01';

/// Service for tracking events with Mixpanel including geolocation
class MixpanelService {
  MixpanelService({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();
  static const String _mixpanelUrl = 'https://api.mixpanel.com/track';

  final http.Client _httpClient;

  // Cache for geolocation data to avoid multiple API calls
  Map<String, dynamic>? _cachedGeoData;
  DateTime? _geoDataCacheTime;
  static const Duration _geoCacheDuration = Duration(hours: 24);

  /// Generate a unique user ID based on system info
  String _generateUserId() {
    try {
      // Use a combination of username and hostname for anonymized tracking
      final username =
          Platform.environment['USER'] ??
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

  /// Get geolocation data from multiple services (with fallbacks)
  Future<Map<String, dynamic>> _getGeolocationData() async {
    // Return cached data if still valid
    if (_cachedGeoData != null &&
        _geoDataCacheTime != null &&
        DateTime.now().difference(_geoDataCacheTime!) < _geoCacheDuration) {
      return _cachedGeoData!;
    }

    var geoData = <String, dynamic>{};

    // List of free geolocation services to try
    final services = [
      _tryIpApiService,
      _tryIpInfoService,
      _tryIpGeolocationService,
    ];

    for (final service in services) {
      try {
        geoData = await service();
        if (geoData.isNotEmpty) {
          // Cache successful result
          _cachedGeoData = geoData;
          _geoDataCacheTime = DateTime.now();
          break;
        }
      } catch (e) {
        // Continue to next service
        continue;
      }
    }

    return geoData;
  }

  /// Try ip-api.com service (free, no API key required)
  Future<Map<String, dynamic>> _tryIpApiService() async {
    final response = await _httpClient
        .get(
          Uri.parse(
            'http://ip-api.com/json/?fields=status,country,countryCode,region,regionName,city,timezone,isp',
          ),
        )
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data['status'] == 'success') {
        return {
          'country': data['country'],
          'country_code': data['countryCode'],
          'region': data['regionName'],
          'city': data['city'],
          'timezone': data['timezone'],
          'isp': data['isp'],
          'service_used': 'ip-api',
        };
      }
    }
    return {};
  }

  /// Try ipinfo.io service (free tier available)
  Future<Map<String, dynamic>> _tryIpInfoService() async {
    final response = await _httpClient
        .get(Uri.parse('https://ipinfo.io/json'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data['country'] != null) {
        return {
          'country': data['country'],
          'country_code': data['country'],
          'region': data['region'],
          'city': data['city'],
          'timezone': data['timezone'],
          'org': data['org'],
          'service_used': 'ipinfo',
        };
      }
    }
    return {};
  }

  /// Try ip-geolocation.io service (free tier available)
  Future<Map<String, dynamic>> _tryIpGeolocationService() async {
    final response = await _httpClient
        .get(Uri.parse('https://ipapi.co/json/'))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      if (data['country'] != null) {
        return {
          'country': data['country_name'],
          'country_code': data['country_code'],
          'region': data['region'],
          'city': data['city'],
          'timezone': data['timezone'],
          'org': data['org'],
          'service_used': 'ipapi.co',
        };
      }
    }
    return {};
  }

  /// Track an event with Mixpanel including geolocation
  Future<void> trackEvent(
    String eventName, {
    Map<String, dynamic>? properties,
    Duration timeout = const Duration(seconds: 3),
    bool includeGeo = true,
  }) async {
    try {
      final userId = _generateUserId();

      // Get geolocation data
      var geoData = <String, dynamic>{};
      if (includeGeo) {
        try {
          geoData = await _getGeolocationData();
        } catch (e) {
          // Don't fail the event if geo lookup fails
          log('Geolocation lookup failed (non-critical): $e');
        }
      }

      final eventData = {
        'event': eventName,
        'properties': {
          'token': _mixpanelToken,
          'distinct_id': userId,
          'time': DateTime.now().millisecondsSinceEpoch,
          r'$insert_id':
              '${userId}_${eventName}_${DateTime.now().millisecondsSinceEpoch}',

          // Add CLI-specific properties
          'cli_version': Platform.version,
          'platform': Platform.operatingSystem,
          'platform_version': Platform.operatingSystemVersion,

          // Add geolocation properties with $ prefix for Mixpanel's built-in properties
          if (geoData.isNotEmpty) ...{
            r'$city': geoData['city'],
            r'$region': geoData['region'],
            r'$country_code': geoData['country_code'],
            'country': geoData['country'],
            'timezone': geoData['timezone'],
            'isp': geoData['isp'] ?? geoData['org'],
            'geo_service': geoData['service_used'],
          },

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
        log(
          'Mixpanel tracking failed: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      // Silently fail - don't let analytics break the CLI
      log('Analytics error (non-critical): $e');
    }
  }

  /// Track command usage with geolocation
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

  /// Track CLI startup with geolocation
  Future<void> trackCliStartup({String? version, List<String>? args}) async {
    await trackEvent(
      'cli_startup',
      properties: {
        'version': version,
        'args_count': args?.length ?? 0,
        'has_command': args != null && args.isNotEmpty,
      },
    );
  }

  /// Get current geolocation info (useful for debugging)
  Future<Map<String, dynamic>> getCurrentLocation() async {
    return _getGeolocationData();
  }

  /// Clear geolocation cache (useful for testing)
  void clearGeoCache() {
    _cachedGeoData = null;
    _geoDataCacheTime = null;
  }

  /// Dispose of resources
  void dispose() {
    _httpClient.close();
  }
}
