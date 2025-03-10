// ignore_for_file: annotate_overrides

part of 'admin_model.dart';

extension AdminModelRepositories on Session {
  AdminModelRepository get adminModels => AdminModelRepository._(this);
}

abstract class AdminModelRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<AdminModelInsertRequest>,
        ModelRepositoryUpdate<AdminModelUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory AdminModelRepository._(Session db) = _AdminModelRepository;

  Future<AdminModelView?> queryAdminModel(int id);
  Future<List<AdminModelView>> queryAdminModels([QueryParams? params]);
}

class _AdminModelRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<AdminModelInsertRequest>,
        RepositoryUpdateMixin<AdminModelUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements AdminModelRepository {
  _AdminModelRepository(super.db) : super(tableName: 'admins', keyName: 'id');

  @override
  Future<AdminModelView?> queryAdminModel(int id) {
    return queryOne(id, AdminModelViewQueryable());
  }

  @override
  Future<List<AdminModelView>> queryAdminModels([QueryParams? params]) {
    return queryMany(AdminModelViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<AdminModelInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.execute(
      Sql.named(
          'INSERT INTO "admins" ( "first_name", "last_name", "password", "email", "name", "role", "status", "created_at", "updated_at" )\n'
          'VALUES ${requests.map((r) => '( ${values.add(r.firstName)}:text, ${values.add(r.lastName)}:text, ${values.add(r.password)}:text, ${values.add(r.email)}:text, ${values.add(r.name)}:text, ${values.add(r.role)}:text, ${values.add(r.status)}:text, ${values.add(r.createdAt)}:text, ${values.add(r.updatedAt)}:text )').join(', ')}\n'
          'RETURNING "id"'),
      parameters: values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<AdminModelUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named('UPDATE "admins"\n'
          'SET "first_name" = COALESCE(UPDATED."first_name", "admins"."first_name"), "last_name" = COALESCE(UPDATED."last_name", "admins"."last_name"), "password" = COALESCE(UPDATED."password", "admins"."password"), "email" = COALESCE(UPDATED."email", "admins"."email"), "name" = COALESCE(UPDATED."name", "admins"."name"), "role" = COALESCE(UPDATED."role", "admins"."role"), "status" = COALESCE(UPDATED."status", "admins"."status"), "created_at" = COALESCE(UPDATED."created_at", "admins"."created_at"), "updated_at" = COALESCE(UPDATED."updated_at", "admins"."updated_at")\n'
          'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.firstName)}:text::text, ${values.add(r.lastName)}:text::text, ${values.add(r.password)}:text::text, ${values.add(r.email)}:text::text, ${values.add(r.name)}:text::text, ${values.add(r.role)}:text::text, ${values.add(r.status)}:text::text, ${values.add(r.createdAt)}:text::text, ${values.add(r.updatedAt)}:text::text )').join(', ')} )\n'
          'AS UPDATED("id", "first_name", "last_name", "password", "email", "name", "role", "status", "created_at", "updated_at")\n'
          'WHERE "admins"."id" = UPDATED."id"'),
      parameters: values.values,
    );
  }
}

class AdminModelInsertRequest {
  AdminModelInsertRequest({
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String name;
  final String role;
  final String status;
  final String createdAt;
  final String updatedAt;
}

class AdminModelUpdateRequest {
  AdminModelUpdateRequest({
    required this.id,
    this.firstName,
    this.lastName,
    this.password,
    this.email,
    this.name,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String? firstName;
  final String? lastName;
  final String? password;
  final String? email;
  final String? name;
  final String? role;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
}

class AdminModelViewQueryable extends KeyedViewQueryable<AdminModelView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "admins".*'
      'FROM "admins"';

  @override
  String get tableAlias => 'admins';

  @override
  AdminModelView decode(TypedMap map) => AdminModelView(
      id: map.get('id'),
      firstName: map.get('first_name'),
      lastName: map.get('last_name'),
      password: map.get('password'),
      email: map.get('email'),
      name: map.get('name'),
      role: map.get('role'),
      status: map.get('status'),
      createdAt: map.get('created_at'),
      updatedAt: map.get('updated_at'));
}

class AdminModelView {
  AdminModelView({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.email,
    required this.name,
    required this.role,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String firstName;
  final String lastName;
  final String password;
  final String email;
  final String name;
  final String role;
  final String status;
  final String createdAt;
  final String updatedAt;
}
