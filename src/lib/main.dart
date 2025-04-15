import 'package:example/config/router.dart';
import 'package:example/setup.dart';
import 'package:sarus/sarus.dart';

void main() async {
  await setup();

  // Use the main router's handler in the pipeline
  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.handler);

  final server = await serve(handler, 'localhost', 8080);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}
