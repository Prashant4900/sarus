import 'package:stormberry/stormberry.dart';

/// A generic controller for any repository that implements Stormberry's standard repository interfaces
class RepositoryController<TInsert, TUpdate, TView, TId> {
  const RepositoryController(this._db, this._repository);

  final Session _db;
  final dynamic _repository;

  // Helper method to access the repository with proper type
  T _getRepo<T>() => _repository as T;

  // CRUD operations
  Future<int> insertOne(TInsert request) {
    final repo = _getRepo<KeyedModelRepositoryInsert<TInsert>>();
    return repo.insertOne(request);
  }

  Future<List<int>> insertMany(List<TInsert> requests) {
    final repo = _getRepo<KeyedModelRepositoryInsert<TInsert>>();
    return repo.insertMany(requests);
  }

  Future<void> updateOne(TUpdate request) {
    final repo = _getRepo<ModelRepositoryUpdate<TUpdate>>();
    return repo.updateOne(request);
  }

  Future<void> updateMany(List<TUpdate> requests) {
    final repo = _getRepo<ModelRepositoryUpdate<TUpdate>>();
    return repo.updateMany(requests);
  }

  Future<void> deleteOne(TId id) {
    final repo = _getRepo<ModelRepositoryDelete<TId>>();
    return repo.deleteOne(id);
  }

  Future<void> deleteMany(List<TId> ids) {
    final repo = _getRepo<ModelRepositoryDelete<TId>>();
    return repo.deleteMany(ids);
  }

  // Helper for pagination
  Future<List<TView>> getPaginated({
    required Future<List<TView>> Function(QueryParams?) queryFunc,
    required int limit,
    required int offset,
    String? orderBy,
    bool orderDesc = false,
  }) {
    final params = QueryParams(
      limit: limit,
      offset: offset,
      orderBy: orderBy,
    );
    return queryFunc(params);
  }

  // Helper for existence check
  Future<bool> exists({
    required Future<TView?> Function(TId) queryFunc,
    required TId id,
  }) async {
    final entity = await queryFunc(id);
    return entity != null;
  }

  Future<Result> rawQuery({
    String? query,
    Map<String, dynamic>? parameters,
  }) async {
    return _db.execute(query!, parameters: parameters);
  }
}
