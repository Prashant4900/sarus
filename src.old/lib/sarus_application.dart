import 'dart:io';

import 'package:example/config/db.dart';
import 'package:example/config/router.dart';
import 'package:example/users/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sarus/sarus.dart' hide Database;

final injector = GetIt.instance;

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
      injector.registerSingleton<UserService>(userService);
    } catch (e) {
      print('Failed to setup dependencies injection: $e');
    }
  }

  @override
  Future<void> close() async {}
}
