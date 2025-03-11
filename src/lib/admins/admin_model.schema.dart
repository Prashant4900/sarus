// ignore_for_file: annotate_overrides

part of 'admin_model.dart';

extension AdminModelRepositories on Session {
  AdminModelRepository get adminModels => AdminModelRepository._(this);
}

abstract class AdminModelRepository
    implements
        ModelRepository,
        ModelRepositoryInsert<AdminModelInsertRequest>,
        ModelRepositoryUpdate<AdminModelUpdateRequest> {
  factory AdminModelRepository._(Session db) = _AdminModelRepository;

  Future<List<AdminModelView>> queryAdminModels([QueryParams? params]);
}

class _AdminModelRepository extends BaseRepository
    with
        RepositoryInsertMixin<AdminModelInsertRequest>,
        RepositoryUpdateMixin<AdminModelUpdateRequest>
    implements AdminModelRepository {
  _AdminModelRepository(super.db) : super(tableName: 'admins');

  @override
  Future<List<AdminModelView>> queryAdminModels([QueryParams? params]) {
    return queryMany(AdminModelViewQueryable(), params);
  }

  @override
  Future<void> insert(List<AdminModelInsertRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'INSERT INTO "admins" (  )\n'
        'VALUES ${requests.map((r) => '(  )').join(', ')}\n',
      ),
      parameters: values.values,
    );
  }

  @override
  Future<void> update(List<AdminModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'UPDATE "admins"\n'
        'SET \n'
        'FROM ( VALUES ${requests.map((r) => '(  )').join(', ')} )\n'
        'AS UPDATED()\n'
        'WHERE ',
      ),
      parameters: values.values,
    );
  }
}

class AdminModelInsertRequest {
  AdminModelInsertRequest();
}

class AdminModelUpdateRequest {
  AdminModelUpdateRequest();
}

class AdminModelViewQueryable extends ViewQueryable<AdminModelView> {
  @override
  String get query =>
      'SELECT "admins".*'
      'FROM "admins"';

  @override
  String get tableAlias => 'admins';

  @override
  AdminModelView decode(TypedMap map) => AdminModelView();
}

class AdminModelView {
  AdminModelView();
}
