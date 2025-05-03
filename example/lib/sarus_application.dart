import 'dart:io';

import 'package:sarus/sarus.dart';
import 'package:example/config/router.dart';

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

  @override
  Future<void> setup() async {
    try {} catch (e) {
      print('Failed to setup dependencies injection: $e');
    }
  }

  @override
  Future<void> close() async {
    print('Shutting down server...');
  }
}
