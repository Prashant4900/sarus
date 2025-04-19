import 'dart:io';

import 'package:example/config/db.dart';
import 'package:example/config/router.dart';
import 'package:example/users/services.dart';
import 'package:sarus/sarus.dart';

final injector = AutoInjector();

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
    try {
      final db = Database();

      final userService = UserService(await db.getConnection());
      injector.addSingleton<UserService>(() => userService);
    } catch (e) {
      print('Failed to setup dependencies injection: $e');
    }

    injector.commit();
  }

  @override
  Future<void> close() async {}
}
