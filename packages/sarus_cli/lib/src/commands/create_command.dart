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
  /// This method handles the complete project generation process with clean,
  /// user-friendly output similar to other popular CLI tools.
  ///
  /// The generation process shows:
  /// 1. Creating project spinner
  /// 2. Installing dependencies spinner
  /// 3. Success message with next steps
  ///
  /// Variables passed to the template:
  /// - `name`: The validated project name for use in generated files
  ///
  /// Throws:
  /// - [Exception] if project directory creation fails
  /// - Various exceptions from subprocess execution (dart commands)
  Future<void> generateBrick() async {
    try {
      // Show creating project progress
      final createProgress = _logger.progress('Creating $projectName');

      // Initialize Mason generator from project bundle
      final generator = await _generator(projectBundle);

      // Generate project files in current directory
      final target = DirectoryGeneratorTarget(Directory.current);
      await generator.generate(
        target,
        logger: _logger,
        fileConflictResolution: FileConflictResolution.overwrite,
        vars: {'name': projectName},
      );

      // Set up project working directory for subsequent operations
      final workingDir = Directory('${Directory.current.path}/$projectName');

      // Verify project directory was created successfully
      if (!workingDir.existsSync()) {
        createProgress.fail('Project directory creation failed');
        throw Exception('Project directory creation failed');
      }

      // Run build_runner to generate routes and other generated code
      await _runBuildRunner(workingDir);

      // Complete the creation step
      createProgress.complete('Creating $projectName');

      // Track successful project structure creation
      await _mixpanelService?.trackEvent(
        'project_structure_created',
        properties: {
          'project_name': projectName,
        },
      );

      // Show installing dependencies progress
      final installProgress = _logger.progress('Installing dependencies');

      // Install project dependencies
      await _runPubGet(workingDir);

      // Apply code quality fixes and formatting
      await _runDartFix(workingDir);

      // Complete the installation step
      installProgress.complete('Installing dependencies');

      // Show success message and next steps
      _logger
        ..info('')
        ..success('Created $projectName at ./$projectName.')
        ..info('')
        ..info('Get started by typing:')
        ..info('')
        ..info('cd ./$projectName')
        ..info('sarus dev');
    } catch (e) {
      _logger.err('Error creating project: $e');

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
  /// in the project directory silently, only logging errors if they occur.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where build_runner should execute
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
      throw Exception('Route generation failed');
    }
  }

  /// Runs dart pub get to install project dependencies.
  ///
  /// This method executes `dart pub get` in the project directory silently,
  /// only logging errors if they occur.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where pub get should execute
  Future<void> _runPubGet(Directory workingDir) async {
    final pubGetStartTime = DateTime.now();
    final result = Process.runSync(
      'dart',
      ['pub', 'get'],
      workingDirectory: workingDir.path,
    );

    final pubGetDuration = DateTime.now().difference(pubGetStartTime);

    if (result.exitCode == 0) {
      await _mixpanelService?.trackEvent(
        'pub_get_success',
        properties: {
          'project_name': projectName,
          'duration_seconds': pubGetDuration.inSeconds,
        },
      );
    } else {
      _logger.err('Failed to install dependencies: ${result.stderr}');
      await _mixpanelService?.trackEvent(
        'pub_get_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': pubGetDuration.inSeconds,
          'error': result.stderr.toString(),
        },
      );
      throw Exception('Dependency installation failed');
    }
  }

  /// Runs dart fix to apply code quality improvements.
  ///
  /// This method executes `dart fix --apply` in the project directory silently,
  /// only logging errors if they occur.
  ///
  /// Parameters:
  /// - [workingDir]: The project directory where dart fix should execute
  Future<void> _runDartFix(Directory workingDir) async {
    final fixStartTime = DateTime.now();
    final resultFix = Process.runSync(
      'dart',
      ['fix', '--apply'],
      workingDirectory: workingDir.path,
    );

    final fixDuration = DateTime.now().difference(fixStartTime);

    if (resultFix.exitCode == 0) {
      await _mixpanelService?.trackEvent(
        'dart_fix_success',
        properties: {
          'project_name': projectName,
          'duration_seconds': fixDuration.inSeconds,
        },
      );
    } else {
      _logger.err('Failed to apply code fixes: ${resultFix.stderr}');
      await _mixpanelService?.trackEvent(
        'dart_fix_failed',
        properties: {
          'project_name': projectName,
          'duration_seconds': fixDuration.inSeconds,
          'error': resultFix.stderr.toString(),
          'exit_code': resultFix.exitCode,
        },
      );
      // Don't throw here - code fixes are not critical for project creation
    }
  }

  /// Verifies that the Dart SDK is installed and accessible.
  ///
  /// This method runs `dart --version` silently to check if the Dart SDK is
  /// properly installed. Only critical errors are shown to the user.
  Future<void> checkDart() async {
    try {
      // Check for Dart SDK availability by running version command
      final result = await Process.run('dart', ['--version']);

      // Verify Dart SDK is properly installed
      if (result.exitCode != 0) {
        _logger.err(
            'Dart SDK is not installed. Please install Dart from https://dart.dev/get-dart');
        await _mixpanelService?.trackEvent(
          'dart_sdk_check_failed',
          properties: {
            'exit_code': result.exitCode,
          },
        );
        exit(1);
      } else {
        // Track successful SDK verification
        await _mixpanelService?.trackEvent('dart_sdk_check_success');
      }
    } catch (e) {
      // Handle critical errors like missing dart command
      _logger.err(
          'Dart SDK is not installed. Please install Dart from https://dart.dev/get-dart');
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
