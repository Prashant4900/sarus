import 'dart:io';

import 'package:example/config/db.dart';
import 'package:example/config/router.dart';
import 'package:example/users/services.dart';
import 'package:get_it/get_it.dart';
import 'package:sarus/sarus.dart';

class SarusApplication implements Application {
  final getIt = GetIt.instance;
  final _injector = AutoInjector();

  @override
  Future<HttpServer> run() async {
    try {
      final handler = const Pipeline().addHandler(router.handler);

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

      _injector.addLazySingleton<Database>(Database.new);

      _injector.addLazySingleton<Database>(() async {
        return db.getConnection();
      });

      getIt.registerSingleton<UserService>(
        UserService(await db.getConnection()),
      );
    } catch (e) {
      print('Failed to setup dependencies injection: $e');
    }
  }

  @override
  Future<void> close() async {}
}
