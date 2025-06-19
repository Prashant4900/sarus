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
        // abbr: 'h',
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
        'hostname',
        // abbr: 'H',
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
  StreamSubscription? _fileWatcher;
  StreamSubscription<List<int>>? _stdinSubscription;
  bool _isRestarting = false;
  bool _isShuttingDown = false;
  final Completer<int> _exitCodeCompleter = Completer<int>();

  @override
  FutureOr<int>? run() async {
    // Check if we're in a Sarus project
    if (!_isValidSarusProject()) {
      _logger.err('Error: Not in a valid Sarus project directory.');
      _logger.info(
        'Make sure you have an application.yaml file in the project root.',
      );
      return ExitCode.usage.code;
    }

    final port =
        Platform.environment['PORT'] ?? (argResults!['port'] as String);
    final hostname = argResults!['hostname'] as String;
    final hotReload = argResults!['hot-reload'] as bool;
    final env = argResults!['env'] as String;
    final verbose = argResults!['verbose'] as bool;
    final watchDirs = argResults!['watch'] as List<String>;

    // Validate hostname
    InternetAddress? address;
    if (hostname != 'localhost') {
      address = InternetAddress.tryParse(hostname);
      if (address == null) {
        _logger.err(
          'Invalid hostname "$hostname": must be a valid IPv4 or IPv6 address.',
        );
        return ExitCode.software.code;
      }
    }

    // Set environment variables
    _setEnvironmentVariables(port, hostname, env, verbose);

    _logger.info('🚀 Starting Sarus server in development mode...');
    _logger.info('📍 Environment: $env');
    _logger.info('🌐 Server: http://$hostname:$port');

    // Handle Ctrl+C gracefully
    ProcessSignal.sigint.watch().listen((_) async {
      if (!_isShuttingDown) {
        _logger.info('\n🛑 Shutting down server...');
        await _shutdown();
      }
    });

    try {
      if (hotReload && env == 'development') {
        _logger.info(
          '🔥 Hot reload enabled - changes will restart the server automatically',
        );
        _startListeningForHelpers();
        await _runWithHotReload(watchDirs);
      } else {
        _logger.info('🔧 Running without hot reload');
        await _runServer();
      }

      return await _exitCodeCompleter.future;
    } catch (e) {
      _logger.err('Error running server: $e');
      return ExitCode.software.code;
    } finally {
      await _cleanup();
    }
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
    String hostname,
    String env,
    bool verbose,
  ) {
    Platform.environment['PORT'] = port;
    Platform.environment['HOST'] = hostname;
    Platform.environment['ENVIRONMENT'] = env;
    Platform.environment['LOG_LEVEL'] = verbose ? 'debug' : 'info';
  }

  /// Starts listening for keyboard shortcuts (like 'r' for reload)
  void _startListeningForHelpers() {
    if (_stdinSubscription != null) return;
    if (!stdin.hasTerminal) return;

    // Listen for the R key to manually trigger reload
    stdin
      ..echoMode = false
      ..lineMode = false;

    _stdinSubscription = stdin.listen(
      (event) {
        if (event.length == 1 &&
            (event.first == 'R'.codeUnitAt(0) ||
                event.first == 'r'.codeUnitAt(0))) {
          if (!_isRestarting && !_isShuttingDown) {
            _logger.info('🔄 Manual reload triggered...');
            _triggerReload();
          }
        }
      },
      onError: (dynamic error) {
        _logger.err('Stdin error: $error');
        _stopListeningForHelpers();
      },
      cancelOnError: true,
      onDone: _stopListeningForHelpers,
    );

    _logger.info('💡 Press R or r to manually reload the server');
  }

  /// Stops listening for keyboard shortcuts
  void _stopListeningForHelpers() {
    _stdinSubscription?.cancel();
    _stdinSubscription = null;

    if (!stdin.hasTerminal) return;

    stdin
      ..lineMode = true
      ..echoMode = true;
  }

  /// Runs the server with hot reload (file watching and automatic restart)
  Future<void> _runWithHotReload(List<String> additionalWatchDirs) async {
    await _startServer();
    await _watchFiles(additionalWatchDirs);
  }

  /// Runs the server without hot reload (normal mode)
  Future<void> _runServer() async {
    await _startServer();

    // Wait for the server process to exit
    if (_serverProcess != null) {
      final exitCode = await _serverProcess!.exitCode;
      if (!_exitCodeCompleter.isCompleted) {
        _exitCodeCompleter.complete(exitCode);
      }
    }
  }

  /// Starts the Dart server process
  Future<void> _startServer() async {
    if (_isShuttingDown) return;

    await _stopServer();

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

      // Forward stdout and stderr with better handling
      process.stdout.transform(const SystemEncoding().decoder).listen(
        (data) {
          final output = data.trim();
          if (output.isNotEmpty) {
            stdout.writeln(output);
          }
        },
        onError: (error) => _logger.err('Stdout error: $error'),
      );

      process.stderr.transform(const SystemEncoding().decoder).listen(
        (data) {
          final error = data.trim();
          if (error.isNotEmpty &&
              !error.contains('Observatory') &&
              !error.contains('DevTools')) {
            stderr.writeln(error);
          }
        },
        onError: (error) => _logger.err('Stderr error: $error'),
      );

      // Handle process exit
      process.exitCode.then((exitCode) {
        if (!_isShuttingDown && !_isRestarting) {
          _logger
              .err('Server process exited unexpectedly with code: $exitCode');
          if (!_exitCodeCompleter.isCompleted) {
            _exitCodeCompleter.complete(exitCode);
          }
        }
      });

      // Wait a bit to ensure server starts properly
      await Future.delayed(const Duration(milliseconds: 800));

      if (!_isRestarting) {
        _logger.success('✅ Server started successfully');
      } else {
        _logger.success('✅ Server restarted successfully');
      }

      _isRestarting = false;
    } catch (e) {
      _logger.err('Error starting server: $e');
      _isRestarting = false;
      if (!_exitCodeCompleter.isCompleted) {
        _exitCodeCompleter.complete(ExitCode.software.code);
      }
    }
  }

  /// Triggers a server reload
  void _triggerReload() {
    if (_isRestarting || _isShuttingDown) return;
    _isRestarting = true;
    _startServer();
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

    try {
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
                fileName.endsWith('.log') ||
                fileName.contains('.git')) {
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
        const Duration(milliseconds: 1000),
      ) // Increased debounce time
          .listen(
        (event) async {
          if (_isRestarting || _isShuttingDown) return;

          final relativePath =
              event.path.replaceFirst('${Directory.current.path}/', '');
          _logger.info('📝 File changed: $relativePath');
          _triggerReload();
        },
        onError: (error) {
          _logger.err('File watcher error: $error');
        },
      );

      final watchedDirsStr = directories.map((d) => d.path).join(', ');
      _logger.info('👀 Watching for changes in: $watchedDirsStr');

      // Keep the process alive until shutdown
      while (!_isShuttingDown) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    } catch (e) {
      _logger.err('Error setting up file watcher: $e');
    }
  }

  /// Merges multiple file system event streams
  Stream<FileSystemEvent> _mergeStreams(List<Stream<FileSystemEvent>> streams) {
    final controller = StreamController<FileSystemEvent>();
    final subscriptions = <StreamSubscription>[];

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
    if (_serverProcess != null) {
      _serverProcess!.kill();
      try {
        await _serverProcess!.exitCode.timeout(const Duration(seconds: 3));
      } catch (e) {
        // Force kill if graceful shutdown takes too long
        _logger.warn('Force killing server process...');
        _serverProcess!.kill(ProcessSignal.sigkill);
      }
      _serverProcess = null;
    }
  }

  /// Initiates shutdown sequence
  Future<void> _shutdown() async {
    if (_isShuttingDown) return;
    _isShuttingDown = true;

    await _cleanup();

    if (!_exitCodeCompleter.isCompleted) {
      _exitCodeCompleter.complete(ExitCode.success.code);
    }
  }

  /// Cleans up resources
  Future<void> _cleanup() async {
    _stopListeningForHelpers();
    await _fileWatcher?.cancel();
    _fileWatcher = null;
    await _stopServer();
  }
}

/// Simple debounce extension for streams
extension StreamDebounce<T> on Stream<T> {
  Stream<T> debounce(Duration duration) {
    Timer? timer;
    final controller = StreamController<T>();

    final subscription = listen(
      (event) {
        timer?.cancel();
        timer = Timer(duration, () {
          if (!controller.isClosed) {
            controller.add(event);
          }
        });
      },
      onError: (Object error) {
        if (!controller.isClosed) {
          controller.addError(error);
        }
      },
      onDone: () {
        timer?.cancel();
        if (!controller.isClosed) {
          controller.close();
        }
      },
    );

    controller.onCancel = () {
      timer?.cancel();
      subscription.cancel();
    };

    return controller.stream;
  }
}
