import 'package:stormberry/stormberry.dart';

class Database {
  final _conn = Connection.open(
    Endpoint(
      host: 'localhost',
      database: 'postgres',
      username: 'postgres',
      password: 'admin',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  Future<Connection> getConnection() async => _conn;

  Future<void> close() async {
    final res = await _conn;
    await res.close();
  }
}
