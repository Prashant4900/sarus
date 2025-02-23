// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/dmmf.dart' as _i4;
import 'package:orm/engines/binary.dart' as _i5;
import 'package:orm/orm.dart' as _i1;

import 'model.dart' as _i2;
import 'prisma.dart' as _i3;

class AdminDelegate {
  const AdminDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Admin?> findUnique({
    required _i3.AdminWhereUniqueInput where,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin?>(
      action: 'findUniqueAdmin',
      result: result,
      factory: (e) => e != null ? _i2.Admin.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Admin> findUniqueOrThrow({
    required _i3.AdminWhereUniqueInput where,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin>(
      action: 'findUniqueAdminOrThrow',
      result: result,
      factory: (e) => _i2.Admin.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Admin?> findFirst({
    _i3.AdminWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AdminOrderByWithRelationInput>,
            _i3.AdminOrderByWithRelationInput>?
        orderBy,
    _i3.AdminWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AdminScalar, Iterable<_i3.AdminScalar>>? distinct,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin?>(
      action: 'findFirstAdmin',
      result: result,
      factory: (e) => e != null ? _i2.Admin.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Admin> findFirstOrThrow({
    _i3.AdminWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AdminOrderByWithRelationInput>,
            _i3.AdminOrderByWithRelationInput>?
        orderBy,
    _i3.AdminWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AdminScalar, Iterable<_i3.AdminScalar>>? distinct,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin>(
      action: 'findFirstAdminOrThrow',
      result: result,
      factory: (e) => _i2.Admin.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Admin>> findMany({
    _i3.AdminWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AdminOrderByWithRelationInput>,
            _i3.AdminOrderByWithRelationInput>?
        orderBy,
    _i3.AdminWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AdminScalar, Iterable<_i3.AdminScalar>>? distinct,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Admin>>(
      action: 'findManyAdmin',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Admin.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Admin> create({
    required _i1
        .PrismaUnion<_i3.AdminCreateInput, _i3.AdminUncheckedCreateInput>
        data,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'data': data,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin>(
      action: 'createOneAdmin',
      result: result,
      factory: (e) => _i2.Admin.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany({
    required _i1.PrismaUnion<_i3.AdminCreateManyInput,
            Iterable<_i3.AdminCreateManyInput>>
        data,
    bool? skipDuplicates,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyAdmin',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyAdminAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.AdminCreateManyInput,
            Iterable<_i3.AdminCreateManyInput>>
        data,
    bool? skipDuplicates,
    _i3.CreateManyAdminAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'skipDuplicates': skipDuplicates,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyAdminAndReturnOutputType>>(
      action: 'createManyAdminAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyAdminAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Admin?> update({
    required _i1
        .PrismaUnion<_i3.AdminUpdateInput, _i3.AdminUncheckedUpdateInput>
        data,
    required _i3.AdminWhereUniqueInput where,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin?>(
      action: 'updateOneAdmin',
      result: result,
      factory: (e) => e != null ? _i2.Admin.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.AdminUpdateManyMutationInput,
            _i3.AdminUncheckedUpdateManyInput>
        data,
    _i3.AdminWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyAdmin',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyAdminAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.AdminUpdateManyMutationInput,
            _i3.AdminUncheckedUpdateManyInput>
        data,
    _i3.AdminWhereInput? where,
    int? limit,
    _i3.UpdateManyAdminAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyAdminAndReturnOutputType>>(
      action: 'updateManyAdminAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyAdminAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Admin> upsert({
    required _i3.AdminWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.AdminCreateInput, _i3.AdminUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.AdminUpdateInput, _i3.AdminUncheckedUpdateInput>
        update,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin>(
      action: 'upsertOneAdmin',
      result: result,
      factory: (e) => _i2.Admin.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Admin?> delete({
    required _i3.AdminWhereUniqueInput where,
    _i3.AdminSelect? select,
  }) {
    final args = {
      'where': where,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Admin?>(
      action: 'deleteOneAdmin',
      result: result,
      factory: (e) => e != null ? _i2.Admin.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.AdminWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyAdmin',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.AdminGroupByOutputType>> groupBy({
    _i3.AdminWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AdminOrderByWithAggregationInput>,
            _i3.AdminOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.AdminScalar>, _i3.AdminScalar> by,
    _i3.AdminScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.AdminGroupByOutputTypeSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'by': _i1.JsonQuery.groupBySerializer(by),
      'having': having,
      'take': take,
      'skip': skip,
      'select': select ?? _i1.JsonQuery.groupBySelectSerializer(by),
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.AdminGroupByOutputType>>(
      action: 'groupByAdmin',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.AdminGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateAdmin> aggregate({
    _i3.AdminWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AdminOrderByWithRelationInput>,
            _i3.AdminOrderByWithRelationInput>?
        orderBy,
    _i3.AdminWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateAdminSelect? select,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Admin',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateAdmin>(
      action: 'aggregateAdmin',
      result: result,
      factory: (e) => _i3.AggregateAdmin.fromJson(e),
    );
  }
}

class PrismaClient extends _i1.BasePrismaClient<PrismaClient> {
  PrismaClient({
    super.datasourceUrl,
    super.datasources,
    super.errorFormat,
    super.log,
    _i1.Engine? engine,
  }) : _engine = engine;

  static final datamodel = _i4.DataModel.fromJson({
    'enums': [],
    'models': [
      {
        'name': 'Admin',
        'dbName': 'admins',
        'schema': null,
        'fields': [
          {
            'name': 'id',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': true,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Int',
            'nativeType': null,
            'default': {
              'name': 'autoincrement',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'firstName',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'lastName',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'email',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': true,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'password',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'String',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'isActive',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Boolean',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'isSuperAdmin',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Boolean',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'createdAt',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'DateTime',
            'nativeType': null,
            'default': {
              'name': 'now',
              'args': [],
            },
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'updatedAt',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'DateTime',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [
          ['email']
        ],
        'uniqueIndexes': [
          {
            'name': null,
            'fields': ['email'],
          }
        ],
        'isGenerated': false,
      }
    ],
    'types': [],
    'indexes': [
      {
        'model': 'Admin',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Admin',
        'type': 'unique',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'email'}
        ],
      },
    ],
  });

  _i1.Engine? _engine;

  _i1.TransactionClient<PrismaClient>? _transaction;

  @override
  get $transaction {
    if (_transaction != null) return _transaction!;
    PrismaClient factory(_i1.TransactionClient<PrismaClient> transaction) {
      final client = PrismaClient(
        engine: $engine,
        datasources: $options.datasources,
        datasourceUrl: $options.datasourceUrl,
        errorFormat: $options.errorFormat,
        log: $options.logEmitter.definition,
      );
      client.$options.logEmitter = $options.logEmitter;
      client._transaction = transaction;

      return client;
    }

    return _transaction = _i1.TransactionClient<PrismaClient>($engine, factory);
  }

  @override
  get $engine => _engine ??= _i5.BinaryEngine(
        schema:
            'generator client {\n  provider = "dart run orm"\n  output   = "../../lib/generated/"\n}\n\ndatasource db {\n  provider = "postgresql"\n  url      = "postgres://admin:admin@localhost:5432/jaspr"\n}\n\nmodel Admin {\n  id        Int    @id @default(autoincrement())\n  firstName String\n  lastName  String\n  email     String\n  password  String\n\n  isActive     Boolean\n  isSuperAdmin Boolean\n\n  createdAt DateTime @default(now())\n  updatedAt DateTime\n\n  @@unique([email])\n  @@map("admins")\n}\n',
        datasources: const {
          'db': _i1.Datasource(
            _i1.DatasourceType.url,
            'postgres://admin:admin@localhost:5432/jaspr',
          )
        },
        options: $options,
      );

  @override
  get $datamodel => datamodel;

  AdminDelegate get admin => AdminDelegate._(this);
}
