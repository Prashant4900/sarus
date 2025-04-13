import 'dart:async';

import 'package:sarus/src/orm/annotation.dart';

typedef Runnable<T> = FutureOr<T> Function();

abstract class ModelRepository {
  Future<T> query<T, U>(Query<T, U> query, U params);
  Future<void> run<T>(Action<T> action, T request);
}
