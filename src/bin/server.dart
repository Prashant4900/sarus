import 'dart:io';

import 'package:example/config/router.dart';
import 'package:example/setup.dart';
import 'package:sarus/sarus.dart';

void main(List<String> args) async {
  await setup();

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.handler);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
