// ignore_for_file: annotate_overrides

part of 'models.dart';

extension ModelsRepositories on Session {
  UsersRepository get userses => UsersRepository._(this);
  AddressRepository get addresses => AddressRepository._(this);
}

abstract class UsersRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UsersInsertRequest>,
        ModelRepositoryUpdate<UsersUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UsersRepository._(Session db) = _UsersRepository;

  Future<UsersView?> queryUsers(int id);
  Future<List<UsersView>> queryUserses([QueryParams? params]);
}

class _UsersRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UsersInsertRequest>,
        RepositoryUpdateMixin<UsersUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UsersRepository {
  _UsersRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<UsersView?> queryUsers(int id) {
    return queryOne(id, UsersViewQueryable());
  }

  @override
  Future<List<UsersView>> queryUserses([QueryParams? params]) {
    return queryMany(UsersViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UsersInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.execute(
      Sql.named(
        'INSERT INTO "users" ( "first_name", "last_name", "email", "password", "phone", "created_at", "updated_at" )\n'
        'VALUES ${requests.map((r) => '( ${values.add(r.firstName)}:text, ${values.add(r.lastName)}:text, ${values.add(r.email)}:text, ${values.add(r.password)}:text, ${values.add(r.phone)}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.updatedAt)}:timestamp )').join(', ')}\n'
        'RETURNING "id"',
      ),
      parameters: values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<UsersUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'UPDATE "users"\n'
        'SET "first_name" = COALESCE(UPDATED."first_name", "users"."first_name"), "last_name" = COALESCE(UPDATED."last_name", "users"."last_name"), "email" = COALESCE(UPDATED."email", "users"."email"), "password" = COALESCE(UPDATED."password", "users"."password"), "phone" = COALESCE(UPDATED."phone", "users"."phone"), "created_at" = COALESCE(UPDATED."created_at", "users"."created_at"), "updated_at" = COALESCE(UPDATED."updated_at", "users"."updated_at")\n'
        'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.firstName)}:text::text, ${values.add(r.lastName)}:text::text, ${values.add(r.email)}:text::text, ${values.add(r.password)}:text::text, ${values.add(r.phone)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.updatedAt)}:timestamp::timestamp )').join(', ')} )\n'
        'AS UPDATED("id", "first_name", "last_name", "email", "password", "phone", "created_at", "updated_at")\n'
        'WHERE "users"."id" = UPDATED."id"',
      ),
      parameters: values.values,
    );
  }
}

abstract class AddressRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<AddressInsertRequest>,
        ModelRepositoryUpdate<AddressUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory AddressRepository._(Session db) = _AddressRepository;

  Future<AddressView?> queryAddress(int id);
  Future<List<AddressView>> queryAddresses([QueryParams? params]);
}

class _AddressRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<AddressInsertRequest>,
        RepositoryUpdateMixin<AddressUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements AddressRepository {
  _AddressRepository(super.db) : super(tableName: 'address', keyName: 'id');

  @override
  Future<AddressView?> queryAddress(int id) {
    return queryOne(id, AddressViewQueryable());
  }

  @override
  Future<List<AddressView>> queryAddresses([QueryParams? params]) {
    return queryMany(AddressViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<AddressInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.execute(
      Sql.named(
        'INSERT INTO "address" ( "is_default", "address_line1", "address_line2", "city", "state", "country", "zip_code", "created_at", "updated_at", "users_id" )\n'
        'VALUES ${requests.map((r) => '( ${values.add(r.isDefault)}:boolean, ${values.add(r.addressLine1)}:text, ${values.add(r.addressLine2)}:text, ${values.add(r.city)}:text, ${values.add(r.state)}:text, ${values.add(r.country)}:text, ${values.add(r.zipCode)}:text, ${values.add(r.createdAt)}:timestamp, ${values.add(r.updatedAt)}:timestamp, ${values.add(r.usersId)}:int8 )').join(', ')}\n'
        'RETURNING "id"',
      ),
      parameters: values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<AddressUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.execute(
      Sql.named(
        'UPDATE "address"\n'
        'SET "is_default" = COALESCE(UPDATED."is_default", "address"."is_default"), "address_line1" = COALESCE(UPDATED."address_line1", "address"."address_line1"), "address_line2" = COALESCE(UPDATED."address_line2", "address"."address_line2"), "city" = COALESCE(UPDATED."city", "address"."city"), "state" = COALESCE(UPDATED."state", "address"."state"), "country" = COALESCE(UPDATED."country", "address"."country"), "zip_code" = COALESCE(UPDATED."zip_code", "address"."zip_code"), "created_at" = COALESCE(UPDATED."created_at", "address"."created_at"), "updated_at" = COALESCE(UPDATED."updated_at", "address"."updated_at"), "users_id" = COALESCE(UPDATED."users_id", "address"."users_id")\n'
        'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.isDefault)}:boolean::boolean, ${values.add(r.addressLine1)}:text::text, ${values.add(r.addressLine2)}:text::text, ${values.add(r.city)}:text::text, ${values.add(r.state)}:text::text, ${values.add(r.country)}:text::text, ${values.add(r.zipCode)}:text::text, ${values.add(r.createdAt)}:timestamp::timestamp, ${values.add(r.updatedAt)}:timestamp::timestamp, ${values.add(r.usersId)}:int8::int8 )').join(', ')} )\n'
        'AS UPDATED("id", "is_default", "address_line1", "address_line2", "city", "state", "country", "zip_code", "created_at", "updated_at", "users_id")\n'
        'WHERE "address"."id" = UPDATED."id"',
      ),
      parameters: values.values,
    );
  }
}

class UsersInsertRequest {
  UsersInsertRequest({
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.createdAt,
    this.updatedAt,
  });

  final String? firstName;
  final String? lastName;
  final String email;
  final String password;
  final String phone;
  final DateTime createdAt;
  final DateTime? updatedAt;
}

class AddressInsertRequest {
  AddressInsertRequest({
    required this.isDefault,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.createdAt,
    this.updatedAt,
    this.usersId,
  });

  final bool isDefault;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final int? usersId;
}

class UsersUpdateRequest {
  UsersUpdateRequest({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}

class AddressUpdateRequest {
  AddressUpdateRequest({
    required this.id,
    this.isDefault,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.createdAt,
    this.updatedAt,
    this.usersId,
  });

  final int id;
  final bool? isDefault;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? usersId;
}

class UsersViewQueryable extends KeyedViewQueryable<UsersView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "users".*, "addresses"."data" as "addresses"'
      'FROM "users"'
      'LEFT JOIN ('
      '  SELECT "address"."users_id",'
      '    to_jsonb(array_agg("address".*)) as data'
      '  FROM (${AddressViewQueryable().query}) "address"'
      '  GROUP BY "address"."users_id"'
      ') "addresses"'
      'ON "users"."id" = "addresses"."users_id"';

  @override
  String get tableAlias => 'users';

  @override
  UsersView decode(TypedMap map) => UsersView(
    id: map.get('id'),
    firstName: map.getOpt('first_name'),
    lastName: map.getOpt('last_name'),
    email: map.get('email'),
    password: map.get('password'),
    phone: map.get('phone'),
    createdAt: map.get('created_at'),
    updatedAt: map.getOpt('updated_at'),
    addresses: map.getListOpt('addresses', AddressViewQueryable().decoder) ?? const [],
  );
}

class UsersView {
  UsersView({
    required this.id,
    this.firstName,
    this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.createdAt,
    this.updatedAt,
    required this.addresses,
  });

  final int id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String password;
  final String phone;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final List<AddressView> addresses;
}

class AddressViewQueryable extends KeyedViewQueryable<AddressView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "address".*'
      'FROM "address"';

  @override
  String get tableAlias => 'address';

  @override
  AddressView decode(TypedMap map) => AddressView(
    id: map.get('id'),
    isDefault: map.get('is_default'),
    addressLine1: map.get('address_line1'),
    addressLine2: map.get('address_line2'),
    city: map.get('city'),
    state: map.get('state'),
    country: map.get('country'),
    zipCode: map.get('zip_code'),
    createdAt: map.get('created_at'),
    updatedAt: map.getOpt('updated_at'),
  );
}

class AddressView {
  AddressView({
    required this.id,
    required this.isDefault,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.createdAt,
    this.updatedAt,
  });

  final int id;
  final bool isDefault;
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;
  final DateTime createdAt;
  final DateTime? updatedAt;
}
