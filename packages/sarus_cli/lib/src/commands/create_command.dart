import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';
import 'package:sarus_cli/templates/project_bundle.dart';

/// RegExp for validating Dart project identifiers
///
/// This regular expression validates that a project name:
/// - Starts with a lowercase letter or underscore
/// - Contains only lowercase letters, numbers, and underscores
/// - Follows Dart package naming conventions
final RegExp _identifierRegExp = RegExp('[a-z_][a-z0-9_]*');

/// {@template create_command}
/// Command to create a new Sarus project from a template.
///
/// This command creates a complete Sarus project structure with:
/// - Generated project files from Mason templates
/// - Proper directory structure and configuration
/// - Dependency resolution via `dart pub get`
/// - Code generation using `build_runner`
/// - Code quality improvements with `dart fix`
/// - Comprehensive analytics tracking for each step
///
/// The project creation process includes:
/// 1. Dart SDK verification
/// 2. Project structure generation from templates
/// 3. Route generation using build_runner
/// 4. Dependency installation
/// 5. Code quality fixes and formatting
/// 6. Performance and error tracking
///
/// Usage: `sarus_cli create <project_name>`
///
/// Example:
/// ```bash
/// sarus_cli create my_sarus_app
/// ```
///
/// The project name must follow Dart identifier conventions (lowercase
/// letters, numbers, and underscores only).
/// {@endtemplate}
class CreateCommand extends Command<int> {
  /// Creates a new [CreateCommand] instance.
  ///
  /// Parameters:
  /// - [logger]: Required logger instance for progress reporting and error messages
  /// - [generator]: Optional generator builder function, defaults to [MasonGenerator.fromBundle]
  /// - [mixpanelService]: Optional analytics service for tracking project creation metrics
  CreateCommand({
    required Logger logger,
    GeneratorBuilder? generator,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle,
        _mixpanelService = mixpanelService;

  @override
  String get description => 'Create a new sarus project.';

  @override
  String get name => 'create';

  /// Logger instance for progress reporting, success messages, and error handling
  final Logger _logger;

  /// Generator builder function for creating Mason generators from bundles
  final GeneratorBuilder _generator;

  /// Optional analytics service for tracking project creation performance and success rates
  final MixpanelService? _mixpanelService;

  /// Executes the create command.
  ///
  /// This method orchestrates the entire project creation process:
  /// 1. Validates the project name
  /// 2. Tracks creation start analytics
  /// 3. Verifies Dart SDK installation
  /// 4. Generates the project structure
  /// 5. Tracks completion or failure analytics
  /// 6. Returns appropriate exit codes
  ///
  /// Returns:
  /// - [ExitCode.success] if project creation succeeds
  /// - [ExitCode.tempFail] if project creation fails
  ///
  /// The entire process is timed for performance monitoring and all
  /// steps are tracked individually for detailed analytics.
  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();

    try {
      // Track command initiation with project details
      await _mixpanelService?.trackEvent(
        'create_command_started',
        properties: {
          'project_name': projectName,
          'timestamp': startTime.toIso8601String(),
        },
      );

      // Verify Dart SDK is available
      await checkDart();

      // Generate the complete project structure
      await generateBrick();

      // Track successful completion with performance metrics
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_command_completed',
        properties: {
          'project_name': projectName,
          'duration_seconds': duration.inSeconds,
          'success': true,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      // Track failure with error details and performance metrics
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'create_command_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': duration.inSeconds,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      rethrow;
    }
  }

  /// Retrieves and validates the project name from command arguments.
  ///
  /// The project name must:
  /// - Be the first positional argument
  /// - Follow Dart identifier conventions
  /// - Contain only lowercase letters, numbers, and underscores
  /// - Start with a lowercase letter or underscore
  ///
  /// Returns the validated project name as a [String].
  ///
  /// Throws:
  /// - [ArgumentError] if the project name doesn't match the required pattern
  String get projectName {
    final name = argResults!.rest.first;
    if (!_identifierRegExp.hasMatch(name)) {
      throw ArgumentError('Invalid project name: $name');
    }
    return name;
  }

  /// Generates a new Sarus project using Mason templates.
  ///
  /// This method handles the complete project generation process:
  /// 1. Initializes the Mason generator from the project bundle
  /// 2. Creates the project directory structure
  /// 3. Generates routes using build_runner
  /// 4. Installs dependencies with dart pub get
  /// 5. Applies code quality fixes with dart fix
  /// 6. Tracks each step for performance monitoring
  ///
  /// The generation process is broken into 6 distinct steps, each with
  /// progress reporting and individual analytics tracking. If any step
  /// fails, detailed error information is logged and tracked.
  ///
  /// Variables passed to the template:
  /// - `name`: The validated project name for use in generated files
  ///
  /// Throws:
  /// - [Exception] if project directory creation fails
  /// - Various exceptions from subprocess execution (dart commands)
  Future<void> generateBrick() async {
    try {
      _logger
        ..info('Starting Sarus project generation process...')
        ..progress('Step 1/6: Initializing project generator...');

      // Initialize Mason generator from project bundle
      final generator = await _generator(projectBundle);

      _logger
        ..detail('Project generator initialized successfully.')
        ..progress('Step 2/6: Creating project structure...');

      // Generate project files in current directory
      final target = DirectoryGeneratorTarget(Directory.current);
      await generator.generate(
        target,
        logger: _logger,
        fileConflictResolution: FileConflictResolution.overwrite,
        vars: {'name': projectName},
      );

      _logger.success('Project "$projectName" structure created successfully.');

      // Track successful project structure creation
      await _mixpanelService?.trackEvent(
        'project_structure_created',
        properties: {
          'project_name': projectName,
        },
      );

      // Set up project working directory for subsequent operations
      final workingDir = Directory('${Directory.current.path}/$projectName');

      _logger
        ..detail('Project working directory: ${workingDir.path}')
        ..progress('Step 3/6: Verifying project directory...');

      // Verify project directory was created successfully
      if (!workingDir.existsSync()) {
        _logger.err('Project directory not found at: ${workingDir.path}');
        throw Exception('Project directory creation failed');
      }

      _logger
        ..detail('Project directory verified successfully.')
        ..progress('Step 4/6: Generate routes...');

      // Run build_runner to generate routes and other generated code
      await _runBuildRunner(workingDir);

      _logger
        ..detail('Routes generation completed.')
        ..progress('Step 5/6: Running dart pub get...');

      // Install project dependencies
      await _runPubGet(workingDir);

      _logger
        ..detail('Dependencies installed successfully.')
        ..progress('Step 6/6: Applying Dart fixes...');

      // Apply code quality fixes and formatting
      await _runDartFix(workingDir);

      _logger
        ..info('Project generation completed successfully!')
        ..detail('Your new Sarus project is ready at: ${workingDir.path}');
    } catch (e) {
      _logger
        ..err('Error generating project: $e')
        ..detail(
          'Project generation failed. Please check the error message above.',
        );

      // Track generation failure with detailed error information
      await _mixpanelService?.trackEvent(
        'project_generation_failed',
        properties: {
          'project_name': projectName,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      rethrow;
    }
  }

  /// Runs build_runner to generate routes and other generated code.
  ///
  /// This method executes `dart run build_runner build --delete-conflicting-outputs`
  /// in the project directory to generate route definitions and other
  /// code-generated files required by the Sarus framework.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where build_runner should execute
  ///
  /// The build process is timed and tracked for performance monitoring.
  /// Both success and failure scenarios are logged with detailed information.
  Future<void> _runBuildRunner(Directory workingDir) async {
    final buildStartTime = DateTime.now();
    final resultBuilder = Process.runSync(
      'dart',
      [
        'run',
        'build_runner',
        'build',
        '--delete-conflicting-outputs',
      ],
      workingDirectory: workingDir.path,
    );

    final buildDuration = DateTime.now().difference(buildStartTime);

    if (resultBuilder.exitCode == 0) {
      _logger.detail('Routes generated successfully.');
      await _mixpanelService?.trackEvent(
        'build_runner_success',
        properties: {
          'project_name': projectName,
          'duration_seconds': buildDuration.inSeconds,
        },
      );
    } else {
      _logger.err('Failed to generate routes: ${resultBuilder.stderr}');
      await _mixpanelService?.trackEvent(
        'build_runner_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': buildDuration.inSeconds,
          'error': resultBuilder.stderr.toString(),
        },
      );
    }
  }

  /// Runs dart pub get to install project dependencies.
  ///
  /// This method executes `dart pub get` in the project directory to
  /// download and install all dependencies specified in pubspec.yaml.
  /// This is essential for the project to compile and run properly.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where pub get should execute
  ///
  /// The installation process is timed and tracked for performance monitoring.
  /// Both success and failure scenarios are logged with detailed information.
  Future<void> _runPubGet(Directory workingDir) async {
    final pubGetStartTime = DateTime.now();
    final result = Process.runSync(
      'dart',
      ['pub', 'get'],
      workingDirectory: workingDir.path,
    );

    final pubGetDuration = DateTime.now().difference(pubGetStartTime);

    if (result.exitCode == 0) {
      _logger.detail('dart pub get executed successfully.');
      await _mixpanelService?.trackEvent(
        'pub_get_success',
        properties: {
          'project_name': projectName,
          'duration_seconds': pubGetDuration.inSeconds,
        },
      );
    } else {
      _logger.err('Failed to run dart pub get: ${result.stderr}');
      await _mixpanelService?.trackEvent(
        'pub_get_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': pubGetDuration.inSeconds,
          'error': result.stderr.toString(),
        },
      );
    }
  }

  /// Runs dart fix to apply code quality improvements.
  ///
  /// This method executes `dart fix --apply` in the project directory to
  /// automatically apply code quality improvements, formatting fixes, and
  /// lint rule corrections. This ensures the generated project follows
  /// best practices and coding standards.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where dart fix should execute
  ///
  /// The fix process is timed and tracked for performance monitoring.
  /// Both success and failure scenarios are logged with detailed information.
  /// Failures in this step are logged but don't prevent project creation.
  Future<void> _runDartFix(Directory workingDir) async {
    _logger.detail('Running dart fix to improve code quality...');

    final fixStartTime = DateTime.now();
    final resultFix = Process.runSync(
      'dart',
      ['fix', '--apply'],
      workingDirectory: workingDir.path,
    );

    final fixDuration = DateTime.now().difference(fixStartTime);

    if (resultFix.exitCode == 0) {
      _logger
        ..success('Dart fixes applied successfully.')
        ..detail('Code linting and formatting completed.');
      await _mixpanelService?.trackEvent(
        'dart_fix_success',
        properties: {
          'project_name': projectName,
          'duration_seconds': fixDuration.inSeconds,
        },
      );
    } else {
      _logger
        ..err('Failed to run dart fix --apply: ${resultFix.stderr}')
        ..detail('Error code: ${resultFix.exitCode}');
      await _mixpanelService?.trackEvent(
        'dart_fix_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': fixDuration.inSeconds,
          'error': resultFix.stderr.toString(),
          'exit_code': resultFix.exitCode,
        },
      );
    }
  }

  /// Verifies that the Dart SDK is installed and accessible.
  ///
  /// This method runs `dart --version` to check if the Dart SDK is properly
  /// installed and available in the system PATH. This is a prerequisite for
  /// project creation since all subsequent operations depend on Dart tools.
  ///
  /// The verification process:
  /// 1. Attempts to run `dart --version`
  /// 2. Checks the exit code for success
  /// 3. Logs warnings for missing SDK
  /// 4. Tracks the verification result for analytics
  /// 5. Exits with code 1 if critical errors occur
  ///
  /// This check helps prevent project creation failures due to missing
  /// prerequisites and provides clear feedback to users.
  Future<void> checkDart() async {
    try {
      // Check for Dart SDK availability by running version command
      final result = await Process.run('dart', ['--version']);

      // Verify Dart SDK is properly installed
      if (result.exitCode != 0) {
        _logger.warn('Dart SDK is not installed.');
        await _mixpanelService?.trackEvent(
          'dart_sdk_check_failed',
          properties: {
            'exit_code': result.exitCode,
          },
        );
      } else {
        // Track successful SDK verification
        await _mixpanelService?.trackEvent('dart_sdk_check_success');
      }
    } catch (e) {
      // Handle critical errors like missing dart command
      _logger.err('Error checking Dart SDK installation: $e');
      await _mixpanelService?.trackEvent(
        'dart_sdk_check_error',
        properties: {
          'error': e.toString(),
        },
      );
      exit(1);
    }
  }
}
