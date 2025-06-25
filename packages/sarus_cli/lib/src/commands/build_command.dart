import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:sarus_cli/analytics/analytics_manager.dart';
import 'package:sarus_cli/src/commands/commands.dart';

/// {@template build_command}
/// `sarus_cli build`
/// A [Command] to create a production build of the Sarus project.
/// {@endtemplate}
class BuildCommand extends Command<int> {
  BuildCommand({
    required Logger logger,
    GeneratorBuilder? generator,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _generator = generator ?? MasonGenerator.fromBundle,
        _mixpanelService = mixpanelService;

  final Logger _logger;
  final GeneratorBuilder _generator;
  final MixpanelService? _mixpanelService;

  @override
  String get description => 'Create a production build.';

  @override
  String get name => 'build';

  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();

    try {
      await _mixpanelService?.trackEvent(
        'build_started',
        properties: {
          'command': name,
          'timestamp': startTime.toIso8601String(),
        },
      );

      await _generateBuild();

      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'build_completed',
        properties: {
          'command': name,
          'duration_seconds': duration.inSeconds,
          'success': true,
        },
      );

      return ExitCode.success.code;
    } catch (e) {
      final duration = DateTime.now().difference(startTime);
      await _mixpanelService?.trackEvent(
        'build_failed',
        properties: {
          'command': name,
          'duration_seconds': duration.inSeconds,
          'error_type': e.runtimeType.toString(),
          'error_message': e.toString(),
        },
      );

      _logger.err('Build failed: $e');
      return ExitCode.tempFail.code;
    }
  }

  Future<void> _generateBuild() async {
    _logger.info('Starting build process...');

    // Check if build directory already exists
    final buildDir = Directory('build');
    if (buildDir.existsSync()) {
      _logger.info('Cleaning existing build directory...');
      await buildDir.delete(recursive: true);
    }

    // Create build directory
    _logger.info('Creating build directory...');
    await buildDir.create();

    await _mixpanelService?.trackEvent(
      'build_directory_created',
      properties: {'command': name},
    );

    // Example build steps - customize based on your project needs
    await _buildProject();
    await _copyAssets();
    await _optimizeBuild();

    _logger.success('Build completed successfully!');
  }

  Future<void> _buildProject() async {
    _logger.info('Building project...');

    // Example: Run dart compile or flutter build
    // Adjust based on your project type
    final result = await Process.run(
      'dart',
      ['compile', 'exe', 'bin/main.dart', '-o', 'build/sarus_cli'],
      workingDirectory: Directory.current.path,
    );

    if (result.exitCode != 0) {
      throw Exception('Build compilation failed: ${result.stderr}');
    }

    _logger.success('Project compiled successfully');
  }

  Future<void> _copyAssets() async {
    _logger.info('Copying assets...');

    // Copy any necessary assets to build directory
    final assetsDir = Directory('assets');
    if (assetsDir.existsSync()) {
      final buildAssetsDir = Directory('build/assets');
      await buildAssetsDir.create(recursive: true);

      // Copy assets recursively
      await for (final entity in assetsDir.list(recursive: true)) {
        if (entity is File) {
          final relativePath = entity.path.substring(assetsDir.path.length + 1);
          final targetFile = File('build/assets/$relativePath');
          await targetFile.parent.create(recursive: true);
          await entity.copy(targetFile.path);
        }
      }

      _logger.success('Assets copied successfully');
    }
  }

  Future<void> _optimizeBuild() async {
    _logger.info('Optimizing build...');

    // Add any optimization steps here
    // For example: minification, compression, etc.

    // Create a build info file
    final buildInfo = {
      'version': '1.0.0', // Get from pubspec.yaml
      'buildTime': DateTime.now().toIso8601String(),
      'buildType': 'production',
    };

    final buildInfoFile = File('build/build_info.json');
    await buildInfoFile.writeAsString(buildInfo.toString());

    _logger.success('Build optimized successfully');
  }
}
