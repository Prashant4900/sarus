import 'package:example/sarus_application.dart';

void main() async {
  // await setup();

  // Create an instance of the SarusApplication
  final application = SarusApplication();

  try {
    // Set up the application
    await application.setup();

    // Start the server
    final server = await application.run();

    // Enable content compression
    server.autoCompress = true;

    print('Serving at http://${server.address.host}:${server.port}');
  } catch (e) {
    print('Error starting server: $e');

    print('Shutting down server...');
    // Close the application
    await application.close();
  }
}
