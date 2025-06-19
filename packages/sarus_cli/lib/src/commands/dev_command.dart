import 'dart:async';
import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason/mason.dart';

/// {@template dev_command}
///
/// `sarus dev`
/// A [Command] to run the Sarus server in development mode with automatic hot reload.
/// {@endtemplate}
class DevCommand extends Command<int> {
  DevCommand({
    required Logger logger,
  }) : _logger = logger {
    argParser
      ..addOption(
        'port',
        abbr: 'p',
        help: 'Port to run the server on',
        defaultsTo: '8080',
      )
      ..addFlag(
        'hot-reload',
        abbr: 'r',
        help: 'Enable hot reload (automatically restarts on file changes)',
        defaultsTo: true,
      )
      ..addOption(
        'env',
        abbr: 'e',
        help: 'Environment to run in',
        defaultsTo: 'development',
        allowed: ['development', 'staging', 'production'],
      )
      ..addFlag(
        'verbose',
        abbr: 'v',
        help: 'Enable verbose logging',
      )
      ..addOption(
        'host',
        help: 'Host to bind the server to',
        defaultsTo: 'localhost',
      )
      ..addMultiOption(
        'watch',
        abbr: 'w',
        help: 'Additional directories to watch for changes',
        defaultsTo: [],
      );
  }

  @override
  String get description =>
      'Run the Sarus server in development mode with automatic hot reload.';

  @override
  String get name => 'dev';

  final Logger _logger;
  Process? _serverProcess;
  StreamSubscription<dynamic>? _fileWatcher;
  bool _isRestarting = false;

  @override
  FutureOr<int>? run() async {
    // Check if we're in a Sarus project
    if (!_isValidSarusProject()) {
      _logger
        ..err('Error: Not in a valid Sarus project directory.')
        ..info(
          'Make sure you have an application.yaml file in the project root.',
        );
      return ExitCode.usage.code;
    }

    final port = argResults!['port'] as String;
    final host = argResults!['host'] as String;
    final hotReload = argResults!['hot-reload'] as bool;
    final env = argResults!['env'] as String;
    final verbose = argResults!['verbose'] as bool;
    final watchDirs = argResults!['watch'] as List<String>;

    // Set environment variables
    _setEnvironmentVariables(port, host, env, verbose);

    _logger.info('🚀 Starting Sarus server in development mode...');
    _logger.info('📍 Environment: $env');
    _logger.info('🌐 Server: http://$host:$port');

    // Handle Ctrl+C gracefully
    ProcessSignal.sigint.watch().listen((_) async {
      _logger.info('\n🛑 Shutting down server...');
      await _stopServer();
      exit(0);
    });

    if (hotReload && env == 'development') {
      _logger.info(
        '🔥 Hot reload enabled - changes will restart the server automatically',
      );
      await _runWithHotReload(watchDirs);
    } else {
      _logger.info('🔧 Running without hot reload');
      await _runServer();
    }

    return ExitCode.success.code;
  }

  /// Checks if the current directory is a valid Sarus project
  bool _isValidSarusProject() {
    final applicationYaml = File('application.yaml');
    final mainDart = File('lib/main.dart');

    return applicationYaml.existsSync() && mainDart.existsSync();
  }

  /// Sets up environment variables for the development server
  void _setEnvironmentVariables(
    String port,
    String host,
    String env,
    bool verbose,
  ) {
    Platform.environment['PORT'] = port;
    Platform.environment['HOST'] = host;
    Platform.environment['ENVIRONMENT'] = env;
    Platform.environment['LOG_LEVEL'] = verbose ? 'debug' : 'info';
  }

  /// Runs the server with hot reload (file watching and automatic restart)
  Future<void> _runWithHotReload(List<String> additionalWatchDirs) async {
    // Start the server initially
    await _startServer();

    // Set up file watching
    await _watchFiles(additionalWatchDirs);
  }

  /// Runs the server without hot reload (normal mode)
  Future<void> _runServer() async {
    await _startServer();

    // Keep the process alive
    if (_serverProcess != null) {
      await _serverProcess!.exitCode;
    }
  }

  /// Starts the Dart server process
  Future<void> _startServer() async {
    if (_serverProcess != null) {
      await _stopServer();
    }

    try {
      if (!_isRestarting) {
        _logger.info('🔄 Starting server...');
      } else {
        _logger.info('🔄 Restarting server...');
      }

      final process = await Process.start(
        'dart',
        ['run', 'lib/main.dart'],
      );

      _serverProcess = process;

      // Forward stdout and stderr
      process.stdout.listen((data) {
        final output = String.fromCharCodes(data).trim();
        if (output.isNotEmpty) {
          stdout.writeln(output);
        }
      });

      process.stderr.listen((data) {
        final error = String.fromCharCodes(data).trim();
        if (error.isNotEmpty && !error.contains('Observatory')) {
          // Filter out Observatory messages which are not important
          stderr.writeln(error);
        }
      });

      // Wait a bit to ensure server starts properly
      await Future<void>.delayed(const Duration(milliseconds: 500));

      if (!_isRestarting) {
        _logger.success('✅ Server started successfully');
      } else {
        _logger.success('✅ Server restarted successfully');
      }

      _isRestarting = false;
    } catch (e) {
      _logger.err('Error starting server: $e');
      _isRestarting = false;
    }
  }

  /// Watches for file changes and restarts the server
  Future<void> _watchFiles(List<String> additionalWatchDirs) async {
    // Default directories to watch
    final defaultDirs = ['lib', 'bin'];

    // Add additional directories if they exist
    final watchDirs = <String>[
      ...defaultDirs,
      ...additionalWatchDirs,
      if (Directory('config').existsSync()) 'config',
      if (Directory('views').existsSync()) 'views',
      if (Directory('assets').existsSync()) 'assets',
    ];

    final directories =
        watchDirs.map(Directory.new).where((dir) => dir.existsSync()).toList();

    if (directories.isEmpty) {
      _logger.warn('No directories found to watch for changes');
      return;
    }

    final streams = <Stream<FileSystemEvent>>[];

    for (final dir in directories) {
      streams.add(
        dir.watch(recursive: true).where((event) {
          final path = event.path;
          final fileName = path.split(Platform.pathSeparator).last;

          // Skip hidden files, temp files, and non-relevant files
          if (fileName.startsWith('.') ||
              fileName.startsWith('#') ||
              fileName.endsWith('~') ||
              fileName.endsWith('.log')) {
            return false;
          }

          // Watch for relevant file types
          return path.endsWith('.dart') ||
              path.endsWith('.yaml') ||
              path.endsWith('.yml') ||
              path.endsWith('.json') ||
              path.endsWith('.html') ||
              path.endsWith('.css') ||
              path.endsWith('.js');
        }),
      );
    }

    final mergedStream =
        streams.length == 1 ? streams.first : _mergeStreams(streams);

    _fileWatcher = mergedStream
        .debounce(
      const Duration(
        milliseconds: 800,
      ),
    ) // Debounce to avoid multiple rapid restarts
        .listen((event) async {
      if (_isRestarting) return; // Prevent multiple simultaneous restarts

      event.path.split(Platform.pathSeparator).last;
      final relativePath =
          event.path.replaceFirst('${Directory.current.path}/', '');

      _logger.info('📝 File changed: $relativePath');
      _isRestarting = true;

      await _startServer();
    });

    final watchedDirsStr = directories.map((d) => d.path).join(', ');
    _logger.info('👀 Watching for changes in: $watchedDirsStr');

    // Keep the process alive
    await Completer<void>().future;
  }

  /// Merges multiple file system event streams
  Stream<FileSystemEvent> _mergeStreams(List<Stream<FileSystemEvent>> streams) {
    final controller = StreamController<FileSystemEvent>();
    final subscriptions = <StreamSubscription<dynamic>>[];

    for (final stream in streams) {
      subscriptions.add(
        stream.listen(
          controller.add,
          onError: controller.addError,
        ),
      );
    }

    controller.onCancel = () {
      for (final sub in subscriptions) {
        sub.cancel();
      }
    };

    return controller.stream;
  }

  /// Stops the current server process
  Future<void> _stopServer() async {
    await _fileWatcher?.cancel();
    _fileWatcher = null;

    if (_serverProcess != null) {
      _serverProcess!.kill();
      try {
        await _serverProcess!.exitCode.timeout(const Duration(seconds: 3));
      } catch (e) {
        // Force kill if graceful shutdown takes too long
        _serverProcess!.kill(ProcessSignal.sigkill);
      }
      _serverProcess = null;
    }
  }
}

// Simple debounce extension
extension StreamDebounce<T> on Stream<T> {
  Stream<T> debounce(Duration duration) {
    Timer? timer;
    final controller = StreamController<T>();

    listen(
      (event) {
        timer?.cancel();
        timer = Timer(duration, () {
          controller.add(event);
        });
      },
      onError: controller.addError,
      onDone: controller.close,
    );

    return controller.stream;
  }
}
