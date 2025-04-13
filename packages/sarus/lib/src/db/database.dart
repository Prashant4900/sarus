import 'dart:io';

import 'package:postgres/postgres.dart';
import 'package:sarus/src/db/default_values.dart';

abstract class Database implements Session, SessionExecutor {
  factory Database({
    String? host,
    int? port,
    String? database,
    String? username,
    String? password,
    bool? useSSL,
    bool? isUnixSocket,
  }) {
    useSSL ??= (Platform.environment['DB_SSL'] != DB_SSL);
    return Database.withOneConnection(
      endpoint: Endpoint(
        host:
            host ?? Platform.environment['DB_HOST_ADDRESS'] ?? DB_HOST_ADDRESS,
        port: port ??
            int.tryParse(Platform.environment['DB_PORT'] ?? '') ??
            DB_PORT,
        database: database ?? Platform.environment['DB_NAME'] ?? DB_NAME,
        username:
            username ?? Platform.environment['DB_USERNAME'] ?? DB_USERNAME,
        password:
            password ?? Platform.environment['DB_PASSWORD'] ?? DB_PASSWORD,
        isUnixSocket:
            isUnixSocket ?? (Platform.environment['DB_SOCKET'] == DB_SOCKET),
      ),
      connectionSettings: ConnectionSettings(
        sslMode: useSSL ? SslMode.require : SslMode.disable,
      ),
    );
  }

  factory Database.withOneConnection({
    required Endpoint endpoint,
    bool debugPrint,
    ConnectionSettings? connectionSettings,
  }) = _DatabaseWithOneConnection;

  factory Database.withPool({
    required Pool<Connection> pool,
    bool debugPrint,
  }) = _DatabaseWithPool;

  Database._({
    required this.debugPrint,
  });

  Future<void> open();

  @override
  Future<void> close({bool force = false});

  bool debugPrint;

  void _printQuery(Object query) {
    if (query is! String) return;
    var offset = 0;
    final q = query
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .map((l) => l.replaceAll(RegExp(r'\s+'), ' '))
        .reduce((v, s) {
      if (s.startsWith('SELECT')) offset += 2;
      if (s.startsWith(')')) offset -= 2;
      return "$v\n${" " * offset}$s";
    });
    print('---\n$q');
  }
}

class _DatabaseWithOneConnection extends Database {
  _DatabaseWithOneConnection({
    required this.endpoint,
    super.debugPrint = false,
    this.connectionSettings,
  }) : super._();
  final Endpoint endpoint;
  final ConnectionSettings? connectionSettings;
  Future<Connection>? _connection;

  @override
  bool get isOpen => _connection != null;

  @override
  Future<void> get closed async => (await _connection)?.closed;

  @override
  Future<Connection> open() async {
    return _connection ??= _tryOpen();
  }

  @override
  Future<void> close({
    bool force = false,
  }) async {
    final connection = await _connection;
    await connection?.close(force: force);
    _connection = null;
  }

  @override
  Future<Statement> prepare(Object query) async {
    final connection = await open();
    if (debugPrint) _printQuery(query);
    return connection.prepare(query);
  }

  @override
  Future<Result> execute(
    Object query, {
    Object? parameters,
    bool ignoreRows = false,
    QueryMode? queryMode,
    Duration? timeout,
  }) async {
    final connection = await open();
    if (debugPrint) _printQuery(query);
    return connection.execute(
      query,
      parameters: parameters,
      ignoreRows: ignoreRows,
      queryMode: queryMode,
      timeout: timeout,
    );
  }

  @override
  Future<R> run<R>(
    Future<R> Function(Session session) fn, {
    SessionSettings? settings,
  }) async {
    final connection = await open();
    return connection.run(fn, settings: settings);
  }

  @override
  Future<R> runTx<R>(
    Future<R> Function(TxSession session) fn, {
    TransactionSettings? settings,
  }) async {
    final connection = await open();
    return connection.runTx(fn, settings: settings);
  }

  Future<Connection> _tryOpen() async {
    final connection = await Connection.open(
      endpoint,
      settings: connectionSettings,
    );
    _connection = null;
    return connection;
  }
}

class _DatabaseWithPool extends Database {
  _DatabaseWithPool({
    required this.pool,
    super.debugPrint = false,
  }) : super._();
  final Pool<Connection> pool;

  @override
  bool get isOpen => pool.isOpen;

  @override
  Future<void> get closed => pool.closed;

  @override
  Future<Statement> prepare(Object query) {
    if (debugPrint) _printQuery(query);
    return pool.prepare(query);
  }

  @override
  Future<Result> execute(
    Object query, {
    Object? parameters,
    bool ignoreRows = false,
    QueryMode? queryMode,
    Duration? timeout,
  }) {
    if (debugPrint) _printQuery(query);
    return pool.execute(
      query,
      parameters: parameters,
      ignoreRows: ignoreRows,
      queryMode: queryMode,
      timeout: timeout,
    );
  }

  @override
  Future<R> run<R>(
    Future<R> Function(Session session) fn, {
    SessionSettings? settings,
  }) {
    return pool.run(fn, settings: settings);
  }

  @override
  Future<R> runTx<R>(
    Future<R> Function(TxSession session) fn, {
    TransactionSettings? settings,
  }) {
    return pool.runTx(fn, settings: settings);
  }

  @override
  Future<void> close({
    bool force = false,
  }) async =>
      pool.close(force: force);

  @override
  Future<void> open() async {}
}
