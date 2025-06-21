import 'dart:async';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';

/// {@template debug_command}
/// `sarus debug`
/// A [Command] to test geolocation and analytics
/// {@endtemplate}
class DebugCommand extends Command<int> {
  DebugCommand({
    required Logger logger,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _mixpanelService = mixpanelService;

  @override
  String get description =>
      'Debug geolocation and analytics (development only).';

  @override
  String get name => 'debug';

  @override
  bool get hidden => true; // Hide from normal help

  final Logger _logger;
  final MixpanelService? _mixpanelService;

  @override
  FutureOr<int>? run() async {
    if (_mixpanelService == null) {
      _logger.err('Analytics service not available');
      return ExitCode.software.code;
    }

    _logger.info('🔍 Testing geolocation detection...');

    try {
      // Clear cache to get fresh data
      _mixpanelService.clearGeoCache();

      // Get current location
      final locationData = await _mixpanelService.getCurrentLocation();

      if (locationData.isEmpty) {
        _logger.warn('❌ Could not detect location');
      } else {
        _logger.success('✅ Location detected successfully!');
        _logger.info('📍 Location Details:');

        if (locationData['country'] != null) {
          _logger.info(
              '   Country: ${locationData['country']} (${locationData['country_code']})');
        }
        if (locationData['region'] != null) {
          _logger.info('   Region: ${locationData['region']}');
        }
        if (locationData['city'] != null) {
          _logger.info('   City: ${locationData['city']}');
        }
        if (locationData['timezone'] != null) {
          _logger.info('   Timezone: ${locationData['timezone']}');
        }
        if (locationData['service_used'] != null) {
          _logger.info('   Service: ${locationData['service_used']}');
        }
      }

      // Test sending an event
      _logger.info('🚀 Testing event tracking...');
      await _mixpanelService.trackEvent(
        'debug_test',
        properties: {
          'test_type': 'geolocation_debug',
          'location_detected': locationData.isNotEmpty,
        },
      );

      _logger.success('✅ Debug test completed!');
    } catch (e) {
      _logger.err('❌ Debug test failed: $e');
      return ExitCode.software.code;
    }

    return ExitCode.success.code;
  }
}
