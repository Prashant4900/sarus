import 'dart:io';

import 'package:stormberry/stormberry.dart';

class Database {
  final _conn = Connection.open(
    Endpoint(
      host: Platform.environment['DB_HOST'] ?? 'localhost',
      database: Platform.environment['DB_NAME'] ?? 'postgres',
      username: Platform.environment['DB_USER'] ?? 'postgres',
      password: Platform.environment['DB_PASS'] ?? 'admin',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  Future<Connection> getConnection() async => _conn;

  Future<void> close() async {
    final res = await _conn;
    await res.close();
  }
}
