// import 'dart:async';
// import 'dart:io';
// import 'dart:isolate';

// import 'package:args/command_runner.dart';
// import 'package:mason_logger/mason_logger.dart';
// import 'package:path/path.dart' as p;
// import 'package:watcher/watcher.dart';

// /// {@template dev_command}
// /// `package dev`
// /// A [Command] to run a development server with hot reload
// /// {@endtemplate}
// class DevCommand extends Command<int> {
//   /// {@macro dev_command}
//   DevCommand({
//     required Logger logger,
//   }) : _logger = logger {
//     argParser.addOption(
//       'entry-point',
//       abbr: 'e',
//       defaultsTo: 'lib/main.dart',
//       help: 'The entry point to your server application',
//     );

//     argParser.addOption(
//       'port',
//       abbr: 'p',
//       defaultsTo: '8080',
//       help: 'The port to run the server on',
//     );

//     argParser.addFlag(
//       'verbose',
//       abbr: 'v',
//       help: 'Enable verbose logging',
//     );
//   }

//   @override
//   String get description =>
//       'Run a development server with hot reload capability';

//   @override
//   String get name => 'dev';

//   final Logger _logger;
//   Isolate? _serverIsolate;
//   ReceivePort? _receivePort;
//   SendPort? _sendPort;
//   final _fileChanges = StreamController<String>.broadcast();
//   final _watchers = <DirectoryWatcher>[];
//   Timer? _debounceTimer;
//   bool _isRestarting = false;

//   @override
//   Future<int> run() async {
//     final entryPoint = argResults?['entry-point'] as String;
//     final port = int.tryParse(argResults?['port'] as String) ?? 8080;
//     final verbose = argResults?['verbose'] as bool;

//     // Check if entry point exists
//     final entryFile = File(p.join(Directory.current.path, entryPoint));
//     if (!entryFile.existsSync()) {
//       _logger.err('Entry point file not found: ${entryFile.path}');
//       return ExitCode.usage.code;
//     }

//     await _startServer(entryPoint, port, verbose);
//     _setupFileWatcher();
//     _listenForShutdown();

//     _fileChanges.stream
//         .distinct() // Only process unique file changes
//         .listen((_) {
//       if (_debounceTimer?.isActive ?? false) return;
//       _debounceTimer = Timer(const Duration(milliseconds: 250), () {
//         if (!_isRestarting) {
//           _restartServer(entryPoint, port, verbose);
//         }
//       });
//     });

//     return ExitCode.success.code;
//   }

//   Future<void> _startServer(String entryPoint, int port, bool verbose) async {
//     _isRestarting = true;

//     // Kill any existing isolate
//     await _shutdownIsolate();

//     _logger.info('🚀 Starting development server...');
//     _logger.info('Entry point: $entryPoint');
//     _logger.info('Port: $port');

//     _receivePort = ReceivePort();

//     // Set up listener for messages from the isolate
//     _receivePort!.listen((message) {
//       if (message is SendPort) {
//         _sendPort = message;
//         _sendPort!.send({'type': 'init', 'port': port, 'verbose': verbose});
//       } else if (message is Map) {
//         // Handle log messages from the server isolate
//         if (message['type'] == 'log') {
//           final level = message['level'] as String? ?? 'info';
//           final msg = message['message'] as String? ?? '';

//           switch (level) {
//             case 'info':
//               _logger.info(msg);
//             case 'warning':
//               _logger.warn(msg);
//             case 'error':
//               _logger.err(msg);
//             case 'debug':
//               if (verbose) _logger.detail(msg);
//             default:
//               _logger.write(msg);
//           }
//         } else if (message['type'] == 'serverStarted') {
//           _logger.success('✅ Server running at http://localhost:$port');
//           _isRestarting = false;
//         }
//       }
//     });

//     try {
//       // Start the server in a new isolate
//       _serverIsolate = await Isolate.spawn(
//         _isolateEntryPoint,
//         _IsolateConfig(
//           entryPoint: entryPoint,
//           sendPort: _receivePort!.sendPort,
//         ),
//         debugName: 'ServerIsolate',
//       );
//     } catch (e) {
//       _logger.err('Failed to start server: $e');
//       _isRestarting = false;
//     }
//   }

//   void _restartServer(String entryPoint, int port, bool verbose) {
//     if (_isRestarting) return;

//     _logger.info('🔄 Reloading server...');
//     _startServer(entryPoint, port, verbose);
//   }

//   void _setupFileWatcher() {
//     final watchDirs = ['lib', 'bin', 'config', 'web']
//         .where(
//           (dir) => Directory(p.join(Directory.current.path, dir)).existsSync(),
//         )
//         .toList();

//     _logger.info('👀 Watching directories: ${watchDirs.join(', ')}');

//     for (final dir in watchDirs) {
//       try {
//         final watcher = DirectoryWatcher(
//           p.join(Directory.current.path, dir),
//         );

//         watcher.events.listen((event) {
//           if (_isValidFileChange(event)) {
//             _fileChanges.add(event.path);
//           }
//         });

//         _watchers.add(watcher);
//       } catch (e) {
//         _logger.warn('Could not watch directory "$dir": $e');
//       }
//     }
//   }

//   bool _isValidFileChange(WatchEvent event) {
//     if (event.type != ChangeType.MODIFY) return false;

//     final filePath = event.path.toLowerCase();
//     return filePath.endsWith('.dart') ||
//         filePath.endsWith('.yaml') ||
//         filePath.endsWith('.json');
//   }

//   Future<void> _shutdownIsolate() async {
//     if (_serverIsolate != null) {
//       _sendPort?.send({'type': 'shutdown'});

//       // Give the isolate a chance to clean up
//       await Future.delayed(const Duration(milliseconds: 100));

//       _serverIsolate?.kill(priority: Isolate.immediate);
//       _serverIsolate = null;
//     }

//     _receivePort?.close();
//     _receivePort = null;
//     _sendPort = null;
//   }

//   void _listenForShutdown() {
//     ProcessSignal.sigint.watch().listen((_) async {
//       _logger.info('\n🛑 Stopping server...');
//       await _shutdownIsolate();

//       // Close watchers
//       for (final watcher in _watchers) {
//         await watcher.ready;
//       }

//       await _fileChanges.close();
//       exit(ExitCode.success.code);
//     });
//   }
// }

// /// Configuration data to pass to the isolate
// class _IsolateConfig {
//   _IsolateConfig({
//     required this.entryPoint,
//     required this.sendPort,
//   });
//   final String entryPoint;
//   final SendPort sendPort;
// }

// /// Entry point for the server isolate
// Future<void> _isolateEntryPoint(_IsolateConfig config) async {
//   // Create a receive port for this isolate
//   final receivePort = ReceivePort();

//   // Send the send port back to the main isolate
//   config.sendPort.send(receivePort.sendPort);

//   var port = 8080;
//   var verbose = false;
//   HttpServer? server;

//   // Listen for messages from the main isolate
//   receivePort.listen((message) async {
//     if (message is Map) {
//       if (message['type'] == 'init') {
//         port = message['port'] as int? ?? 8080;
//         verbose = message['verbose'] as bool? ?? false;

//         // Override print to forward logs to the main isolate
//         overridePrint(config.sendPort, verbose);

//         // Start the server
//         await _startServerFromEntryPoint(
//           config.entryPoint,
//           port,
//           config.sendPort,
//         );
//       } else if (message['type'] == 'shutdown') {
//         server?.close(force: true);
//       }
//     }
//   });
// }

// /// Starts the server from the given entry point
// Future<void> _startServerFromEntryPoint(
//   String entryPoint,
//   int port,
//   SendPort sendPort,
// ) async {
//   try {
//     sendPort.send({
//       'type': 'log',
//       'level': 'info',
//       'message': 'Loading server from $entryPoint...',
//     });

//     // Use dynamic import to load the entry point
//     final mainScript = Uri.file(p.join(Directory.current.path, entryPoint));
//     await runAppFromUri(mainScript, port);

//     sendPort.send({'type': 'serverStarted'});
//   } catch (e, stack) {
//     sendPort.send({
//       'type': 'log',
//       'level': 'error',
//       'message': 'Error starting server: $e\n$stack',
//     });
//   }
// }

// /// Function to run the app from URI using mirrors (or dart:developer)
// Future<void> runAppFromUri(Uri mainScript, int port) async {
//   try {
//     // Load the entry point dynamically
//     final context = await Isolate.spawnUri(
//       mainScript,
//       ['--port=$port', '--dev-mode=true'],
//       null,
//       checked: true,
//       debugName: 'AppIsolate',
//       automaticPackageResolution: true,
//     );

//     // Keep the app running
//     await Future<void>.delayed(const Duration(days: 1));
//   } catch (e, stack) {
//     print('Failed to load server: $e\n$stack');
//     rethrow;
//   }
// }

// /// Override print function to forward logs to the main isolate
// void overridePrint(SendPort sendPort, bool verbose) {
//   // const originalPrint = print;
//   //  print = (Object? object) {
//   //   sendPort.send({
//   //     'type': 'log',
//   //     'level': 'info',
//   //     'message': object?.toString() ?? '',
//   //   });
//   //   originalPrint(object);
//   // };

//   // Override zone's print handler too for broader coverage
//   Zone.current.fork(
//     specification: ZoneSpecification(
//       print: (self, parent, zone, message) {
//         sendPort.send({
//           'type': 'log',
//           'level': 'info',
//           'message': message,
//         });
//         parent.print(zone, message);
//       },
//     ),
//   ).run<void>(() {});
// }
