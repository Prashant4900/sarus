// // import '../config/config.dart';
// // import 'model.dart';
// // import 'package:stormberry/stormberry.dart';

// // class AdminControllers {
// //   final _db = Config.db;

// //   // Single Insert
// //   Future<int> insert(AdminModelInsertRequest request) async {
// //     final results = await _db.adminModels.insertOne(request);
// //     return results;
// //   }

// //   // Bulk Insert
// //   Future<List<int>> insertMany(List<AdminModelInsertRequest> requests) async {
// //     return _db.adminModels.insertMany(requests);
// //   }

// //   // Single Update
// //   Future<void> update(AdminModelUpdateRequest request) async {
// //     await _db.adminModels.updateOne(request);
// //   }

// //   // Bulk Update
// //   Future<void> updateMany(List<AdminModelUpdateRequest> requests) async {
// //     await _db.adminModels.updateMany(requests);
// //   }

// //   // Single Delete
// //   Future<void> delete(int id) async {
// //     await _db.adminModels.deleteOne(id);
// //   }

// //   // Bulk Delete
// //   Future<void> deleteMany(List<int> ids) async {
// //     await _db.adminModels.deleteMany(ids);
// //   }

// //   // Get Single Admin by ID
// //   Future<AdminModelView?> get(int id) {
// //     return _db.adminModels.queryAdminModel(id);
// //   }

// //   // Get All Admins with optional query parameters
// //   Future<List<AdminModelView>> gets([QueryParams? params]) {
// //     return _db.adminModels.queryAdminModels(params);
// //   }

// //   // Get Admins with Pagination
// //   Future<List<AdminModelView>> getAdminsPaginated({
// //     required int limit,
// //     required int offset,
// //     String? orderBy,
// //     bool orderDesc = false,
// //   }) {
// //     final params = QueryParams(
// //       limit: limit,
// //       offset: offset,
// //       orderBy: orderBy,
// //     );
// //     return gets(params);
// //   }

// //   // Check if admin exists by ID
// //   Future<bool> exists(int id) async {
// //     final admin = await get(id);
// //     return admin != null;
// //   }
// // }

// // // abstract class BaseController<TInsert, TUpdate, TView, TId, TRepo> {
// // //   final TRepo repository;

// // //   BaseController(this.repository);

// // //   // CRUD Operations
// // //   Future<TId> insert(TInsert request) => repository.insertOne(request);
// // //   Future<List<TId>> insertMany(List<TInsert> requests) => repository.insertMany(requests);

// // //   Future<void> update(TUpdate request) => repository.updateOne(request);
// // //   Future<void> updateMany(List<TUpdate> requests) => repository.updateMany(requests);

// // //   Future<void> delete(TId id) => repository.deleteOne(id);
// // //   Future<void> deleteMany(List<TId> ids) => repository.deleteMany(ids);

// // //   // Query Operations
// // //   Future<TView?> get(TId id) => repository.queryModel(id);
// // //   Future<List<TView>> gets([QueryParams? params]) => repository.queryModels(params);

// // //   // Pagination
// // //   Future<List<TView>> getPaginated({
// // //     required int limit,
// // //     required int offset,
// // //     String? orderBy,
// // //     bool orderDesc = false,
// // //   }) {
// // //     return gets(QueryParams(
// // //       limit: limit,
// // //       offset: offset,
// // //       orderBy: orderBy,
// // //     ));
// // //   }

// // // }

// // class BaseController
// //     implements
// //         ModelRepository,
// //         KeyedModelRepositoryInsert<ModelRepositoryInsert>,
// //         ModelRepositoryDelete<int> {
// //   @override
// //   Future<void> deleteMany(List<int> ids) {
// //     // TODO: implement deleteMany
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<void> deleteOne(int id) {
// //     // TODO: implement deleteOne
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<List<int>> insertMany(List<ModelRepositoryInsert> requests) {
// //     // TODO: implement insertMany
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<int> insertOne(ModelRepositoryInsert request) {
// //     // TODO: implement insertOne
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<T> query<T, U>(Query<T, U> query, U params) {
// //     // TODO: implement query
// //     throw UnimplementedError();
// //   }

// //   @override
// //   Future<void> run<T>(Action<T> action, T request) {
// //     // TODO: implement run
// //     throw UnimplementedError();
// //   }
// // }


// import '../config/config.dart';
// import 'model.dart';
// import 'package:stormberry/stormberry.dart';

// class AdminController {
//   final Session _db = Config.db;
//   final RepositoryController<AdminModelInsertRequest, AdminModelUpdateRequest, AdminModelView, int> _controller;

//   AdminController() : _controller = RepositoryController(Config.db, Config.db.adminModels);

//   // Direct CRUD operations that delegate to the repository controller
//   Future<int> insert(AdminModelInsertRequest request) => _controller.insertOne(request);
//   Future<List<int>> insertMany(List<AdminModelInsertRequest> requests) => _controller.insertMany(requests);
  
//   Future<void> update(AdminModelUpdateRequest request) => _controller.updateOne(request);
//   Future<void> updateMany(List<AdminModelUpdateRequest> requests) => _controller.updateMany(requests);
  
//   Future<void> delete(int id) => _controller.deleteOne(id);
//   Future<void> deleteMany(List<int> ids) => _controller.deleteMany(ids);

//   // Query operations that use the specific repository methods
//   Future<AdminModelView?> get(int id) => _db.adminModels.queryAdminModel(id);
//   Future<List<AdminModelView>> getAll([QueryParams? params]) => _db.adminModels.queryAdminModels(params);

//   // Pagination using the controller helper
//   Future<List<AdminModelView>> getPaginated({
//     required int limit,
//     required int offset,
//     String? orderBy,
//     bool orderDesc = false,
//   }) {
//     return _controller.getPaginated(
//       queryFunc: _db.adminModels.queryAdminModels,
//       limit: limit,
//       offset: offset,
//       orderBy: orderBy,
//       orderDesc: orderDesc,
//     );
//   }

//   // Existence check using the controller helper
//   Future<bool> exists(int id) {
//     return _controller.exists(
//       queryFunc: _db.adminModels.queryAdminModel,
//       id: id,
//     );
//   }
// }