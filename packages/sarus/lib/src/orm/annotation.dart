/// Extend this to define a custom query.
///
/// {@category Queries & Actions}
abstract class Query<T, U> {
  const Query();

  Future<T> apply(U params);
}

/// Extend this to define a custom action.
///
/// {@category Queries & Actions}
abstract class Action<T> {
  const Action();

  Future<void> apply(T request);
}
