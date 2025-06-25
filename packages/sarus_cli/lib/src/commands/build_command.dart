import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_cli/analytics/analytics_manager.dart';

/// {@template build_command}
/// `sarus_cli build`
/// A [Command] to create a production build of the Sarus server application.
/// {@endtemplate}
class BuildCommand extends Command<int> {
  BuildCommand({
    required Logger logger,
    MixpanelService? mixpanelService,
  })  : _logger = logger,
        _mixpanelService = mixpanelService;

  final Logger _logger;
  final MixpanelService? _mixpanelService;

  @override
  String get description =>
      'Create a production build ready for Docker deployment.';

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
    _logger.info('Starting production build...');

    final buildDir = Directory('build');
    if (buildDir.existsSync()) {
      _logger.info('Cleaning existing build directory...');
      await buildDir.delete(recursive: true);
    }

    _logger.info('Creating build directory...');
    await buildDir.create();

    await _mixpanelService?.trackEvent(
      'build_directory_created',
      properties: {'command': name},
    );

    await _copyProjectFiles();
    await _createDockerfile();
    await _createDockerCompose();
    await _createDockerignore();
    await _generateBuildInfo();

    _logger.success('Production build completed successfully!');
    _logger.info('Build directory is ready for Docker deployment.');
  }

  Future<void> _copyProjectFiles() async {
    _logger.info('Copying all project files...');

    final currentDir = Directory.current;
    final buildDir = Directory('build');

    await for (final entity in currentDir.list()) {
      final name = path.basename(entity.path);

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

  Future<void> _copyDirectory(Directory source, Directory target) async {
    await target.create(recursive: true);

    await for (final entity in source.list()) {
      final name = path.basename(entity.path);

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

  bool _shouldSkipItem(String name) {
    final skipItems = {
      '.dart_tool',
      '.git',
      '.github',
      'node_modules',
      'build',
      '.vscode',
      '.idea',
      'coverage',
      'doc',
      '.env',
      '.DS_Store',
      'Thumbs.db',
      '*.log',
      '*.tmp',
    };

    return skipItems.any((pattern) {
      if (pattern.contains('*')) {
        final extension = pattern.replaceAll('*', '');
        return name.endsWith(extension);
      }
      return name == pattern;
    });
  }

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

  Future<void> _generateBuildInfo() async {
    _logger.info('Generating build information...');

    final buildInfo = {
      'buildTime': DateTime.now().toIso8601String(),
      'buildType': 'production',
      'dartVersion': Platform.version,
      'platform': Platform.operatingSystem,
    };

    final buildInfoFile = File('build/build_info.json');
    await buildInfoFile.writeAsString('''
{
  "buildTime": "${buildInfo['buildTime']}",
  "buildType": "${buildInfo['buildType']}",
  "dartVersion": ${buildInfo['dartVersion']},
  "platform": "${buildInfo['platform']}"
}
''');

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

    final result = await Process.run('chmod', ['+x', 'build/docker-build.sh']);
    if (result.exitCode == 0) {
      _logger.success('Build script created and made executable');
    }

    _logger.success('Build information generated');
  }
}
