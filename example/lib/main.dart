import 'dart:io';

import 'package:example/config/router.dart';
import 'package:sarus/sarus.dart';

void main() async {
  // Create the main router
  final router = AppRouter();

  // Use the main router's handler in the pipeline
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.handler);

  final server = await serve(handler, 'localhost', 8080, shared: true);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');

  // Handle SIGINT (Ctrl+C)
  ProcessSignal.sigint.watch().listen((_) async {
    print('\n🛑 Stopping server...');
    await server.close();
    exit(0);
  });
}
