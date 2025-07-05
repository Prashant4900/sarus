import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_cli/analytics/analytics_manager.dart';

/// {@template build_command}
/// Command to create a production build of the Sarus server application.
///
/// This command creates a complete production-ready build that includes:
/// - A clean build directory with all necessary project files
/// - Docker configuration files (Dockerfile, docker-compose.yml, .dockerignore)
/// - Build metadata and deployment scripts
/// - AOT-compiled Dart executable for optimal performance
///
/// The build process:
/// 1. Cleans and creates a fresh build directory
/// 2. Copies all project files (excluding development artifacts)
/// 3. Generates Docker configuration for containerized deployment
/// 4. Creates build metadata and deployment scripts
/// 5. Tracks analytics for build performance monitoring
///
/// Usage: `sarus_cli build`
///
/// The resulting build directory contains everything needed for Docker deployment
/// and can be deployed using the generated docker-compose.yml file.
/// {@endtemplate}
class BuildCommand extends Command<int> {
  /// Creates a new [BuildCommand] instance.
  ///
  /// Parameters:
  /// - [logger]: Required logger instance for build output and progress reporting
  /// - [mixpanelService]: Optional analytics service for tracking build metrics
  BuildCommand({
    required Logger logger,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _mixpanelService = mixpanelService;

  /// Logger instance for build output, progress reporting, and error messages
  final Logger _logger;

  /// Optional analytics service for tracking build performance and success rates
  final MixpanelService? _mixpanelService;

  @override
  String get description =>
      'Create a production build ready for Docker deployment.';

  @override
  String get name => 'build';

  /// Executes the build command.
  ///
  /// This method orchestrates the entire build process:
  /// 1. Tracks build start analytics
  /// 2. Generates the production build
  /// 3. Tracks completion or failure analytics
  /// 4. Returns appropriate exit codes
  ///
  /// Returns:
  /// - [ExitCode.success] if the build completes successfully
  /// - [ExitCode.tempFail] if the build fails
  ///
  /// The build process is timed for performance monitoring and all
  /// errors are logged with detailed information for debugging.
  @override
  FutureOr<int>? run() async {
    final startTime = DateTime.now();

    try {
      // Track analytics for build initiation
      await _mixpanelService?.trackEvent(
        'build_started',
        properties: {
          'command': name,
          'timestamp': startTime.toIso8601String(),
        },
      );

      // Execute the main build process
      await _generateBuild();

      // Track successful completion with performance metrics
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
      // Track failure with error details and performance metrics
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

  /// Generates the complete production build.
  ///
  /// This method coordinates all build steps:
  /// 1. Cleans and creates the build directory
  /// 2. Copies all necessary project files
  /// 3. Creates Docker configuration files
  /// 4. Generates build metadata and deployment scripts
  ///
  /// The build directory will contain a complete, self-contained
  /// production build ready for Docker deployment.
  Future<void> _generateBuild() async {
    _logger.info('Starting production build...');

    // Clean and create build directory
    final buildDir = Directory('build');
    if (buildDir.existsSync()) {
      _logger.info('Cleaning existing build directory...');
      await buildDir.delete(recursive: true);
    }

    _logger.info('Creating build directory...');
    await buildDir.create();

    // Track build directory creation
    await _mixpanelService?.trackEvent(
      'build_directory_created',
      properties: {'command': name},
    );

    // Execute all build steps
    await _copyProjectFiles();
    await _createDockerfile();
    await _createDockerCompose();
    await _createDockerignore();
    await _generateBuildInfo();

    _logger.success('Production build completed successfully!');
    _logger.info('Build directory is ready for Docker deployment.');
  }

  /// Copies all necessary project files to the build directory.
  ///
  /// This method recursively copies the entire project structure while
  /// excluding development artifacts and build outputs. It preserves
  /// the directory structure and file permissions.
  ///
  /// Skipped items include:
  /// - Version control directories (.git, .github)
  /// - IDE configuration (.vscode, .idea)
  /// - Build artifacts (.dart_tool, build, coverage)
  /// - Node.js dependencies (node_modules)
  /// - Environment files and logs
  Future<void> _copyProjectFiles() async {
    _logger.info('Copying all project files...');

    final currentDir = Directory.current;
    final buildDir = Directory('build');

    await for (final entity in currentDir.list()) {
      final name = path.basename(entity.path);

      // Skip items that shouldn't be included in the build
      if (_shouldSkipItem(name)) {
        _logger.detail('Skipping: $name');
        continue;
      }

      final targetPath = path.join(buildDir.path, name);

      if (entity is File) {
        await entity.copy(targetPath);
        _logger.detail('Copied file: $name');
      } else if (entity is Directory) {
        await _copyDirectory(entity, Directory(targetPath));
        _logger.detail('Copied directory: $name');
      }
    }

    _logger.success('All project files copied successfully');
  }

  /// Recursively copies a directory and its contents.
  ///
  /// This method handles deep directory copying while respecting
  /// the skip rules for development artifacts. It preserves the
  /// directory structure and handles both files and subdirectories.
  ///
  /// Parameters:
  /// - [source]: The source directory to copy from
  /// - [target]: The target directory to copy to
  Future<void> _copyDirectory(Directory source, Directory target) async {
    await target.create(recursive: true);

    await for (final entity in source.list()) {
      final name = path.basename(entity.path);

      // Skip items that shouldn't be included in the build
      if (_shouldSkipItem(name)) continue;

      if (entity is File) {
        final targetFile = File(path.join(target.path, name));
        await entity.copy(targetFile.path);
      } else if (entity is Directory) {
        final targetDir = Directory(path.join(target.path, name));
        await _copyDirectory(entity, targetDir);
      }
    }
  }

  /// Determines whether a file or directory should be skipped during copying.
  ///
  /// This method checks if a given name matches any of the patterns for
  /// items that should be excluded from the production build. It handles
  /// both exact matches and wildcard patterns.
  ///
  /// Parameters:
  /// - [name]: The file or directory name to check
  ///
  /// Returns:
  /// - `true` if the item should be skipped
  /// - `false` if the item should be included in the build
  ///
  /// Skipped items include development tools, build artifacts, version
  /// control files, and temporary files that are not needed in production.
  bool _shouldSkipItem(String name) {
    final skipItems = {
      '.dart_tool', // Dart build cache
      '.git', // Git version control
      '.github', // GitHub workflows
      'node_modules', // Node.js dependencies
      'build', // Build outputs
      '.vscode', // VS Code configuration
      '.idea', // IntelliJ IDEA configuration
      'coverage', // Code coverage reports
      'doc', // Documentation
      '.env', // Environment variables
      '.DS_Store', // macOS system files
      'Thumbs.db', // Windows system files
      '*.log', // Log files
      '*.tmp', // Temporary files
    };

    return skipItems.any((pattern) {
      if (pattern.contains('*')) {
        // Handle wildcard patterns
        final extension = pattern.replaceAll('*', '');
        return name.endsWith(extension);
      }
      return name == pattern;
    });
  }

  /// Creates the Dockerfile for containerized deployment.
  ///
  /// This method generates a multi-stage Dockerfile that:
  /// 1. Uses the official Dart SDK image for building
  /// 2. Resolves dependencies using pub get
  /// 3. AOT-compiles the server executable for optimal performance
  /// 4. Creates a minimal runtime image from scratch
  /// 5. Exposes port 8080 for the server
  ///
  /// The resulting Docker image is optimized for production with
  /// minimal size and maximum performance.
  Future<void> _createDockerfile() async {
    _logger.info('Creating Dockerfile...');

    const dockerfile = '''
# Use latest stable channel SDK.
FROM dart:stable AS build

# Resolve app dependencies.
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code (except anything in .dockerignore) and AOT compile app.
COPY . .
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled `/server`
# and the pre-built AOT-runtime in the `/runtime/` directory of the base image.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
''';

    final dockerfileFile = File('build/Dockerfile');
    await dockerfileFile.writeAsString(dockerfile);

    _logger.success('Dockerfile created');
  }

  /// Creates the docker-compose.yml file for easy deployment.
  ///
  /// This method generates a Docker Compose configuration that:
  /// 1. Defines the server service with the local Dockerfile
  /// 2. Maps port 8080 for external access
  /// 3. Sets production environment variables
  /// 4. Configures automatic restart policy
  ///
  /// The compose file simplifies deployment and management of the
  /// containerized application.
  Future<void> _createDockerCompose() async {
    _logger.info('Creating docker-compose.yml...');

    const dockerCompose = '''
version: '3.8'

services:
  server:
    build:
      context: .
    ports:
      - "8080:8080"
    environment:
      - DART_ENV=production
    restart: unless-stopped
''';

    final dockerComposeFile = File('build/docker-compose.yml');
    await dockerComposeFile.writeAsString(dockerCompose);

    _logger.success('docker-compose.yml created');
  }

  /// Creates the .dockerignore file to optimize Docker builds.
  ///
  /// This method generates a .dockerignore file that excludes
  /// unnecessary files from the Docker build context, improving
  /// build performance and reducing image size.
  ///
  /// The ignore file excludes:
  /// - Version control files
  /// - IDE configuration
  /// - Build artifacts
  /// - Documentation
  /// - Environment files
  /// - Development dependencies
  Future<void> _createDockerignore() async {
    _logger.info('Creating .dockerignore...');

    const dockerignore = '''
.git
.github
.vscode
.idea
.dart_tool
build
coverage
doc
*.log
.env
node_modules
README.md
''';

    final dockerignoreFile = File('build/.dockerignore');
    await dockerignoreFile.writeAsString(dockerignore);

    _logger.success('.dockerignore created');
  }

  /// Generates build information and deployment scripts.
  ///
  /// This method creates:
  /// 1. A build_info.json file with build metadata including:
  ///    - Build timestamp
  ///    - Build type (production)
  ///    - Dart version information
  ///    - Platform information
  /// 2. A docker-build.sh script for easy deployment with:
  ///    - Automated Docker Compose commands
  ///    - Helpful usage instructions
  ///    - Service management commands
  ///
  /// The build information can be used for debugging and monitoring,
  /// while the build script simplifies deployment operations.
  Future<void> _generateBuildInfo() async {
    _logger.info('Generating build information...');

    // Collect build metadata
    final buildInfo = {
      'buildTime': DateTime.now().toIso8601String(),
      'buildType': 'production',
      'dartVersion': Platform.version,
      'platform': Platform.operatingSystem,
    };

    // Create build info JSON file
    final buildInfoFile = File('build/build_info.json');
    await buildInfoFile.writeAsString('''
{
  "buildTime": "${buildInfo['buildTime']}",
  "buildType": "${buildInfo['buildType']}",
  "dartVersion": ${buildInfo['dartVersion']},
  "platform": "${buildInfo['platform']}"
}
''');

    // Create deployment script with helpful commands
    const buildScript = '''
#!/bin/bash
echo "🚀 Sarus Server Build & Deploy Script"
echo "===================================="
echo "Building and starting services with Docker Compose..."
docker-compose up --build -d
echo ""
echo "✅ Services started successfully!"
echo ""
echo "📋 Available commands:"
echo "  View logs:           docker-compose logs -f"
echo "  Stop services:       docker-compose down"
echo "  Rebuild:             docker-compose up --build -d"
echo "  View running:        docker-compose ps"
echo ""
echo "🌐 Server should be available at: http://localhost:8080"
''';

    final buildScriptFile = File('build/docker-build.sh');
    await buildScriptFile.writeAsString(buildScript);

    // Make the script executable on Unix-like systems
    final result = await Process.run('chmod', ['+x', 'build/docker-build.sh']);
    if (result.exitCode == 0) {
      _logger.success('Build script created and made executable');
    }

    _logger.success('Build information generated');
  }
}
