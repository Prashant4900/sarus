import 'dart:io';

import 'package:example/sarus_application.dart';

void main() async {
  // Create an instance of the SarusApplication
  final application = SarusApplication();

  try {
    await setup(application);
  } catch (e) {
    print('Error starting server: $e');

    print('Shutting down server...');
    // Close the application
    await application.close();
  }
}

Future<HttpServer> setup(SarusApplication application) async {
  // Set up the application
  await application.setup();

  // Start the server
  final server = await application.run();

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');

  return server;
}
