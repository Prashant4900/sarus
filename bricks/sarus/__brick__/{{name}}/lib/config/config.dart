import 'dart:io';

import 'package:stormberry/stormberry.dart';

import 'env.dart';

class Config {
  static final Directory baseDir =
      File(Platform.script.toFilePath()).parent.parent;

  static final Database db = Database(
    host: Env.get(EnvKey.DB_HOST),
    password: Env.get(EnvKey.DB_PASSWORD),
    username: Env.get(EnvKey.DB_USER),
    database: Env.get(EnvKey.DB_NAME),
    port: int.parse(Env.get(EnvKey.DB_HOST) ?? '5432'),
  );
}
