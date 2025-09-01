import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/module_bundle.dart';

/// RegExp for validating Dart identifiers
///
/// This regular expression validates that a string:
/// - Starts with a lowercase letter or underscore
/// - Contains only lowercase letters, numbers, and underscores
/// - Follows Dart naming conventions for identifiers
final RegExp _identifierRegExp = RegExp(r'^[a-z_][a-z0-9_]*$');

/// {@template create_module_command}
/// Command to create a new module inside the Sarus project.
///
/// This command handles the creation of new modules by:
/// - Validating the module name against Dart identifier rules
/// - Generating module structure using Mason templates
/// - Tracking analytics events for success/failure metrics
/// - Providing appropriate error handling and user feedback
///
/// Usage: `sarus_cli create-module <module_name>`
///
/// Example:
/// ```bash
/// sarus_cli create-module user_authentication
/// ```
/// {@endtemplate}
class CreateModuleCommand extends Command<int> {
  /// Creates a new [CreateModuleCommand] instance.
  ///
  /// Parameters:
  /// - [logger]: Required logger instance for output and error reporting
  /// - [generator]: Optional generator builder function, defaults to [MasonGenerator.fromBundle]
  /// - [mixpanelService]: Optional analytics service for tracking command usage
  CreateModuleCommand({
    required Logger logger,
    GeneratorBuilder? generator,
    MixpanelService? mixpanelService,
  }) : _logger = logger,
       _generator = generator ?? MasonGenerator.fromBundle,
       _mixpanelService = mixpanelService;

  @override
  String get description => 'Create a new module inside the Sarus project.';

  @override
  String get name => 'module';

  /// Logger instance for command output and error reporting
  final Logger _logger;

  /// Generator builder function for creating Mason generators
  final GeneratorBuilder _generator;

  /// Optional analytics service for tracking command usage and performance
  final MixpanelService? _mixpanelService;

  /// Executes the create module command.
  ///
  /// This method:
  /// 1. Validates the provided module name
  /// 2. Tracks analytics for command start
  /// 3. Generates the module using Mason templates
  /// 4. Tracks completion or failure analytics
  /// 5. Returns appropriate exit codes
  ///
  /// Returns:
  /// - [ExitCode.success] if module creation succeeds
  /// - [ExitCode.tempFail] if module creation fails
  ///
  /// Throws:
  /// - [ArgumentError] if module name is invalid
  @override
  FutureOr<int>? run() async {
    // Validate module name against Dart identifier rules
    final module = moduleName;
    final startTime = DateTime.now();

    try {
      // Track analytics for command initiation
      await _mixpanelService?.trackEvent(
        'create_module_started',
        properties: {
          'module_name': module,
          'timestamp': startTime.toIso8601String(),
        },
      );

      // Generate the module structure
      await generateModule(module);

      // Track successful completion with performance metrics
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_module_completed',
        properties: {
          'module_name': module,
          'duration_seconds': duration.inSeconds,
          'success': true,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      // Track failure with error details and performance metrics
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_module_failed',
        properties: {
          'module_name': module,
          'duration_seconds': duration.inSeconds,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      return ExitCode.tempFail.code;
    }
  }

  /// Retrieves and validates the module name from command arguments.
  ///
  /// The module name must:
  /// - Be the first positional argument
  /// - Follow Dart identifier conventions (lowercase letters, numbers, underscores)
  /// - Start with a lowercase letter or underscore
  ///
  /// Returns the validated module name as a [String].
  ///
  /// Throws:
  /// - [ArgumentError] if the module name doesn't match the required pattern
  String get moduleName {
    final name = argResults!.rest.first;
    if (!_identifierRegExp.hasMatch(name)) {
      throw ArgumentError('Invalid module name: $name');
    }
    return name;
  }

  /// Generates a new module using Mason templates.
  ///
  /// This method:
  /// 1. Creates a Mason generator from the module bundle
  /// 2. Sets up the target directory (current working directory)
  /// 3. Generates files with the module name as a template variable
  /// 4. Runs post-generation hooks for additional setup
  /// 5. Provides user feedback on success or failure
  ///
  /// Parameters:
  /// - [module]: The validated module name to generate
  ///
  /// The generation process uses the current working directory as the target
  /// and passes the module name as a template variable for file generation.
  Future<void> generateModule(String module) async {
    try {
      _logger.info('Generating $module module...');

      // Create Mason generator from the module bundle template
      final generator = await _generator(moduleBundle);
      final target = DirectoryGeneratorTarget(Directory.current);

      // Generate module files with the provided name
      await generator.generate(target, vars: {'name': module});

      // Execute post-generation hooks for additional setup
      await generator.hooks.postGen(
        logger: _logger,
        workingDirectory: Directory.current.path,
        vars: {'name': module},
      );

      _logger.info('Module "$module" created successfully.');
    } catch (e) {
      _logger.err('Error generating module: $e');
      rethrow; // Re-throw to be handled by the calling method
    }
  }
}
