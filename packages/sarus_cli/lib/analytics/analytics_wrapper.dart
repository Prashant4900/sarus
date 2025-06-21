import 'package:sarus_cli/analytics/analytics_manager.dart';

class SarusAnalytics {
  static bool _initialized = false;

  // Initialize analytics system
  static Future<void> init() async {
    if (_initialized) return;

    await AnalyticsManager.initialize();
    await AnalyticsManager.trackAppStart();
    _initialized = true;
  }

  // Request consent if needed (first run)
  static Future<void> requestConsentIfNeeded() async {
    await AnalyticsManager.requestConsent();
  }

  // Track command execution
  static Future<void> trackCommand(
    String command, {
    Map<String, dynamic>? parameters,
    Duration? executionTime,
    bool success = true,
  }) async {
    await AnalyticsManager.trackCommand(
      command,
      parameters: parameters,
      executionTime: executionTime,
      success: success,
    );
  }

  // Track errors
  static Future<void> trackError(
    String error, {
    String? command,
    String? context,
  }) async {
    await AnalyticsManager.trackError(
      error,
      command: command,
      context: context,
    );
  }

  // Track project creation
  static Future<void> trackProjectCreation(
    String projectName, {
    Duration? totalTime,
    bool success = true,
    String? errorStep,
  }) async {
    await AnalyticsManager.trackProjectCreation(
      projectName,
      totalTime: totalTime,
      success: success,
      errorStep: errorStep,
    );
  }

  // Track module creation
  static Future<void> trackModuleCreation(
    String moduleName, {
    Duration? executionTime,
    bool success = true,
  }) async {
    await AnalyticsManager.trackModuleCreation(
      moduleName,
      executionTime: executionTime,
      success: success,
    );
  }

  // Track updates
  static Future<void> trackUpdate(
    bool success, {
    String? fromVersion,
    String? toVersion,
    Duration? updateTime,
  }) async {
    await AnalyticsManager.trackUpdate(
      success,
      fromVersion: fromVersion,
      toVersion: toVersion,
      updateTime: updateTime,
    );
  }

  // Analytics management
  static Future<void> enable() => AnalyticsManager.enableAnalytics();
  static Future<void> disable() => AnalyticsManager.disableAnalytics();
  static Future<void> status() => AnalyticsManager.showStatus();
}
