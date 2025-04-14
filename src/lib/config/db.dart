import 'package:postgres/postgres.dart';

class Database {
  static final Pool<Connection> _pool = Pool.withEndpoints(
    [
      Endpoint(
        host: 'localhost',
        database: 'tasks_db',
        username: 'your_username',
        password: 'your_password',
      ),
    ],
    settings: const PoolSettings(
      sslMode: SslMode.disable,
      maxConnectionCount: 5,
      maxConnectionAge: Duration(minutes: 5),
    ),
  );

  static Future<Connection> getConnection() async {
    return _pool.withConnection(Future.value);
  }

  static Future<void> close() async {
    await _pool.close();
    _pool.isOpen;
  }
}
