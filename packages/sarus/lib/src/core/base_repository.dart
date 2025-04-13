import 'package:stormberry/stormberry.dart';

/// A generic repository that provides standardized CRUD operations
/// for any Stormberry repository that implements the standard repository interfaces.
///
/// Type parameters:
/// - [TInsert]: The insert request type (e.g. AdminModelInsertRequest)
/// - [TUpdate]: The update request type (e.g. AdminModelUpdateRequest)
/// - [TView]: The view model type returned by queries (e.g. AdminModelView)
/// - [TId]: The ID type of the model (typically int)
class CoreRepository<TInsert, TUpdate, TView, TId> {
  /// Creates a new controller instance.
  ///
  /// [repository] must implement the appropriate Stormberry repository interfaces.
  /// [queryOne] function must be provided to fetch single entities by ID.
  /// [queryMany] function must be provided to fetch multiple entities with optional parameters.
  const CoreRepository({
    required this.repository,
    required this.queryOne,
    required this.queryMany,
  });

  /// The repository instance for the model this controller manages
  final dynamic repository;

  /// Function to query a single entity by ID
  final Future<TView?> Function(TId id) queryOne;

  /// Function to query multiple entities with optional parameters
  final Future<List<TView>> Function(QueryParams?) queryMany;

  /// Helper method to access the repository with proper type
  T _getRepo<T>() => repository as T;

  /// Inserts a single entity
  ///
  /// Returns the ID of the inserted entity
  Future<int> insert(TInsert request) {
    final repo = _getRepo<KeyedModelRepositoryInsert<TInsert>>();
    return repo.insertOne(request);
  }

  /// Inserts multiple entities
  ///
  /// Returns the IDs of the inserted entities
  Future<List<int>> insertMany(List<TInsert> requests) {
    final repo = _getRepo<KeyedModelRepositoryInsert<TInsert>>();
    return repo.insertMany(requests);
  }

  /// Updates a single entity
  Future<void> update(TUpdate request) {
    final repo = _getRepo<ModelRepositoryUpdate<TUpdate>>();
    return repo.updateOne(request);
  }

  /// Updates multiple entities
  Future<void> updateMany(List<TUpdate> requests) {
    final repo = _getRepo<ModelRepositoryUpdate<TUpdate>>();
    return repo.updateMany(requests);
  }

  /// Deletes a single entity by ID
  Future<void> delete(TId id) {
    final repo = _getRepo<ModelRepositoryDelete<TId>>();
    return repo.deleteOne(id);
  }

  /// Deletes multiple entities by IDs
  Future<void> deleteMany(List<TId> ids) {
    final repo = _getRepo<ModelRepositoryDelete<TId>>();
    return repo.deleteMany(ids);
  }

  /// Gets a single entity by ID
  ///
  /// Returns null if the entity does not exist
  Future<TView?> get(TId id) => queryOne(id);

  /// Gets multiple entities with optional query parameters
  Future<List<TView>> getAll([QueryParams? params]) => queryMany(params);

  /// Gets multiple entities with pagination
  ///
  /// [limit] specifies the maximum number of entities to return
  /// [offset] specifies the number of entities to skip
  /// [orderBy] specifies the column to order by
  /// [orderDesc] specifies whether to order in descending order
  Future<List<TView>> getPaginated({
    required int limit,
    required int offset,
    String? orderBy,
    bool orderDesc = false,
  }) {
    final params = QueryParams(limit: limit, offset: offset, orderBy: orderBy);
    return queryMany(params);
  }

  /// Checks if an entity with the given ID exists
  Future<bool> exists(TId id) async {
    final entity = await queryOne(id);
    return entity != null;
  }
}
