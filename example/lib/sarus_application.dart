import 'dart:io';

import 'package:example/config/router.dart';
import 'package:sarus/sarus.dart';

class SarusApplication implements Application {
  @override
  Future<HttpServer> run() async {
    try {
      final handler = const Pipeline()
          .addMiddleware(logRequests())
          .addHandler(router.handler);

      return await serve(handler, InternetAddress.anyIPv4, 8080);
    } catch (e) {
      print('Error starting server: $e');
      rethrow;
    }
  }

  Future<void> setup() async {
    // Any setup logic can go here, such as initializing services or databases.
    print('Setting up SarusApplication...');
  }
}
