// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/dmmf.dart' as _i4;
import 'package:orm/engines/binary.dart' as _i5;
import 'package:orm/orm.dart' as _i1;

import 'model.dart' as _i2;
import 'prisma.dart' as _i3;

class UserDelegate {
  const UserDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.User?> findUnique({
    required _i3.UserWhereUniqueInput where,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User?>(
      action: 'findUniqueUser',
      result: result,
      factory: (e) => e != null ? _i2.User.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.User> findUniqueOrThrow({
    required _i3.UserWhereUniqueInput where,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User>(
      action: 'findUniqueUserOrThrow',
      result: result,
      factory: (e) => _i2.User.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.User?> findFirst({
    _i3.UserWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UserOrderByWithRelationInput>,
            _i3.UserOrderByWithRelationInput>?
        orderBy,
    _i3.UserWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UserScalar, Iterable<_i3.UserScalar>>? distinct,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User?>(
      action: 'findFirstUser',
      result: result,
      factory: (e) => e != null ? _i2.User.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.User> findFirstOrThrow({
    _i3.UserWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UserOrderByWithRelationInput>,
            _i3.UserOrderByWithRelationInput>?
        orderBy,
    _i3.UserWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UserScalar, Iterable<_i3.UserScalar>>? distinct,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User>(
      action: 'findFirstUserOrThrow',
      result: result,
      factory: (e) => _i2.User.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.User>> findMany({
    _i3.UserWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UserOrderByWithRelationInput>,
            _i3.UserOrderByWithRelationInput>?
        orderBy,
    _i3.UserWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.UserScalar, Iterable<_i3.UserScalar>>? distinct,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.User>>(
      action: 'findManyUser',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.User.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.User> create({
    required _i1.PrismaUnion<_i3.UserCreateInput, _i3.UserUncheckedCreateInput>
        data,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User>(
      action: 'createOneUser',
      result: result,
      factory: (e) => _i2.User.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.UserCreateManyInput,
              Iterable<_i3.UserCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyUser',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyUserAndReturnOutputType>>
      createManyAndReturn({
    required _i1
        .PrismaUnion<_i3.UserCreateManyInput, Iterable<_i3.UserCreateManyInput>>
        data,
    _i3.CreateManyUserAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyUserAndReturnOutputType>>(
      action: 'createManyUserAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyUserAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.User?> update({
    required _i1.PrismaUnion<_i3.UserUpdateInput, _i3.UserUncheckedUpdateInput>
        data,
    required _i3.UserWhereUniqueInput where,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User?>(
      action: 'updateOneUser',
      result: result,
      factory: (e) => e != null ? _i2.User.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.UserUpdateManyMutationInput,
            _i3.UserUncheckedUpdateManyInput>
        data,
    _i3.UserWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyUser',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyUserAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.UserUpdateManyMutationInput,
            _i3.UserUncheckedUpdateManyInput>
        data,
    _i3.UserWhereInput? where,
    int? limit,
    _i3.UpdateManyUserAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyUserAndReturnOutputType>>(
      action: 'updateManyUserAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyUserAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.User> upsert({
    required _i3.UserWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.UserCreateInput, _i3.UserUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.UserUpdateInput, _i3.UserUncheckedUpdateInput>
        update,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User>(
      action: 'upsertOneUser',
      result: result,
      factory: (e) => _i2.User.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.User?> delete({
    required _i3.UserWhereUniqueInput where,
    _i3.UserSelect? select,
    _i3.UserInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.User?>(
      action: 'deleteOneUser',
      result: result,
      factory: (e) => e != null ? _i2.User.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.UserWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'User',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyUser',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.UserGroupByOutputType>> groupBy({
    _i3.UserWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UserOrderByWithAggregationInput>,
            _i3.UserOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.UserScalar>, _i3.UserScalar> by,
    _i3.UserScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.UserGroupByOutputTypeSelect? select,
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
      modelName: 'User',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.UserGroupByOutputType>>(
      action: 'groupByUser',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.UserGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateUser> aggregate({
    _i3.UserWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.UserOrderByWithRelationInput>,
            _i3.UserOrderByWithRelationInput>?
        orderBy,
    _i3.UserWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateUserSelect? select,
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
      modelName: 'User',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateUser>(
      action: 'aggregateUser',
      result: result,
      factory: (e) => _i3.AggregateUser.fromJson(e),
    );
  }
}

class AddressDelegate {
  const AddressDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Address?> findUnique({
    required _i3.AddressWhereUniqueInput where,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address?>(
      action: 'findUniqueAddress',
      result: result,
      factory: (e) => e != null ? _i2.Address.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Address> findUniqueOrThrow({
    required _i3.AddressWhereUniqueInput where,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address>(
      action: 'findUniqueAddressOrThrow',
      result: result,
      factory: (e) => _i2.Address.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Address?> findFirst({
    _i3.AddressWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AddressOrderByWithRelationInput>,
            _i3.AddressOrderByWithRelationInput>?
        orderBy,
    _i3.AddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AddressScalar, Iterable<_i3.AddressScalar>>? distinct,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address?>(
      action: 'findFirstAddress',
      result: result,
      factory: (e) => e != null ? _i2.Address.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Address> findFirstOrThrow({
    _i3.AddressWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AddressOrderByWithRelationInput>,
            _i3.AddressOrderByWithRelationInput>?
        orderBy,
    _i3.AddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AddressScalar, Iterable<_i3.AddressScalar>>? distinct,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address>(
      action: 'findFirstAddressOrThrow',
      result: result,
      factory: (e) => _i2.Address.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Address>> findMany({
    _i3.AddressWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AddressOrderByWithRelationInput>,
            _i3.AddressOrderByWithRelationInput>?
        orderBy,
    _i3.AddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.AddressScalar, Iterable<_i3.AddressScalar>>? distinct,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Address>>(
      action: 'findManyAddress',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Address.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Address> create({
    required _i1
        .PrismaUnion<_i3.AddressCreateInput, _i3.AddressUncheckedCreateInput>
        data,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address>(
      action: 'createOneAddress',
      result: result,
      factory: (e) => _i2.Address.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.AddressCreateManyInput,
              Iterable<_i3.AddressCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyAddress',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyAddressAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.AddressCreateManyInput,
            Iterable<_i3.AddressCreateManyInput>>
        data,
    _i3.CreateManyAddressAndReturnOutputTypeSelect? select,
    _i3.CreateManyAddressAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyAddressAndReturnOutputType>>(
      action: 'createManyAddressAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyAddressAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Address?> update({
    required _i1
        .PrismaUnion<_i3.AddressUpdateInput, _i3.AddressUncheckedUpdateInput>
        data,
    required _i3.AddressWhereUniqueInput where,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address?>(
      action: 'updateOneAddress',
      result: result,
      factory: (e) => e != null ? _i2.Address.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.AddressUpdateManyMutationInput,
            _i3.AddressUncheckedUpdateManyInput>
        data,
    _i3.AddressWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyAddress',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyAddressAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.AddressUpdateManyMutationInput,
            _i3.AddressUncheckedUpdateManyInput>
        data,
    _i3.AddressWhereInput? where,
    int? limit,
    _i3.UpdateManyAddressAndReturnOutputTypeSelect? select,
    _i3.UpdateManyAddressAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyAddressAndReturnOutputType>>(
      action: 'updateManyAddressAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyAddressAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Address> upsert({
    required _i3.AddressWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.AddressCreateInput, _i3.AddressUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.AddressUpdateInput, _i3.AddressUncheckedUpdateInput>
        update,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address>(
      action: 'upsertOneAddress',
      result: result,
      factory: (e) => _i2.Address.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Address?> delete({
    required _i3.AddressWhereUniqueInput where,
    _i3.AddressSelect? select,
    _i3.AddressInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Address?>(
      action: 'deleteOneAddress',
      result: result,
      factory: (e) => e != null ? _i2.Address.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.AddressWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Address',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyAddress',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.AddressGroupByOutputType>> groupBy({
    _i3.AddressWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AddressOrderByWithAggregationInput>,
            _i3.AddressOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.AddressScalar>, _i3.AddressScalar> by,
    _i3.AddressScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.AddressGroupByOutputTypeSelect? select,
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
      modelName: 'Address',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.AddressGroupByOutputType>>(
      action: 'groupByAddress',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.AddressGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateAddress> aggregate({
    _i3.AddressWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.AddressOrderByWithRelationInput>,
            _i3.AddressOrderByWithRelationInput>?
        orderBy,
    _i3.AddressWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateAddressSelect? select,
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
      modelName: 'Address',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateAddress>(
      action: 'aggregateAddress',
      result: result,
      factory: (e) => _i3.AggregateAddress.fromJson(e),
    );
  }
}

class CategoryDelegate {
  const CategoryDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Category?> findUnique({
    required _i3.CategoryWhereUniqueInput where,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category?>(
      action: 'findUniqueCategory',
      result: result,
      factory: (e) => e != null ? _i2.Category.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Category> findUniqueOrThrow({
    required _i3.CategoryWhereUniqueInput where,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category>(
      action: 'findUniqueCategoryOrThrow',
      result: result,
      factory: (e) => _i2.Category.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Category?> findFirst({
    _i3.CategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CategoryOrderByWithRelationInput>,
            _i3.CategoryOrderByWithRelationInput>?
        orderBy,
    _i3.CategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CategoryScalar, Iterable<_i3.CategoryScalar>>? distinct,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category?>(
      action: 'findFirstCategory',
      result: result,
      factory: (e) => e != null ? _i2.Category.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Category> findFirstOrThrow({
    _i3.CategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CategoryOrderByWithRelationInput>,
            _i3.CategoryOrderByWithRelationInput>?
        orderBy,
    _i3.CategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CategoryScalar, Iterable<_i3.CategoryScalar>>? distinct,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category>(
      action: 'findFirstCategoryOrThrow',
      result: result,
      factory: (e) => _i2.Category.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Category>> findMany({
    _i3.CategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CategoryOrderByWithRelationInput>,
            _i3.CategoryOrderByWithRelationInput>?
        orderBy,
    _i3.CategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CategoryScalar, Iterable<_i3.CategoryScalar>>? distinct,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Category>>(
      action: 'findManyCategory',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Category.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Category> create({
    required _i1
        .PrismaUnion<_i3.CategoryCreateInput, _i3.CategoryUncheckedCreateInput>
        data,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category>(
      action: 'createOneCategory',
      result: result,
      factory: (e) => _i2.Category.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.CategoryCreateManyInput,
              Iterable<_i3.CategoryCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyCategoryAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.CategoryCreateManyInput,
            Iterable<_i3.CategoryCreateManyInput>>
        data,
    _i3.CreateManyCategoryAndReturnOutputTypeSelect? select,
    _i3.CreateManyCategoryAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyCategoryAndReturnOutputType>>(
      action: 'createManyCategoryAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyCategoryAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Category?> update({
    required _i1
        .PrismaUnion<_i3.CategoryUpdateInput, _i3.CategoryUncheckedUpdateInput>
        data,
    required _i3.CategoryWhereUniqueInput where,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category?>(
      action: 'updateOneCategory',
      result: result,
      factory: (e) => e != null ? _i2.Category.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.CategoryUpdateManyMutationInput,
            _i3.CategoryUncheckedUpdateManyInput>
        data,
    _i3.CategoryWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyCategoryAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.CategoryUpdateManyMutationInput,
            _i3.CategoryUncheckedUpdateManyInput>
        data,
    _i3.CategoryWhereInput? where,
    int? limit,
    _i3.UpdateManyCategoryAndReturnOutputTypeSelect? select,
    _i3.UpdateManyCategoryAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyCategoryAndReturnOutputType>>(
      action: 'updateManyCategoryAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyCategoryAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Category> upsert({
    required _i3.CategoryWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.CategoryCreateInput, _i3.CategoryUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.CategoryUpdateInput, _i3.CategoryUncheckedUpdateInput>
        update,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category>(
      action: 'upsertOneCategory',
      result: result,
      factory: (e) => _i2.Category.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Category?> delete({
    required _i3.CategoryWhereUniqueInput where,
    _i3.CategorySelect? select,
    _i3.CategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Category?>(
      action: 'deleteOneCategory',
      result: result,
      factory: (e) => e != null ? _i2.Category.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.CategoryWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Category',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.CategoryGroupByOutputType>> groupBy({
    _i3.CategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CategoryOrderByWithAggregationInput>,
            _i3.CategoryOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.CategoryScalar>, _i3.CategoryScalar>
        by,
    _i3.CategoryScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.CategoryGroupByOutputTypeSelect? select,
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
      modelName: 'Category',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.CategoryGroupByOutputType>>(
      action: 'groupByCategory',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.CategoryGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateCategory> aggregate({
    _i3.CategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CategoryOrderByWithRelationInput>,
            _i3.CategoryOrderByWithRelationInput>?
        orderBy,
    _i3.CategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateCategorySelect? select,
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
      modelName: 'Category',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateCategory>(
      action: 'aggregateCategory',
      result: result,
      factory: (e) => _i3.AggregateCategory.fromJson(e),
    );
  }
}

class ProductDelegate {
  const ProductDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Product?> findUnique({
    required _i3.ProductWhereUniqueInput where,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product?>(
      action: 'findUniqueProduct',
      result: result,
      factory: (e) => e != null ? _i2.Product.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Product> findUniqueOrThrow({
    required _i3.ProductWhereUniqueInput where,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product>(
      action: 'findUniqueProductOrThrow',
      result: result,
      factory: (e) => _i2.Product.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Product?> findFirst({
    _i3.ProductWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductOrderByWithRelationInput>,
            _i3.ProductOrderByWithRelationInput>?
        orderBy,
    _i3.ProductWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductScalar, Iterable<_i3.ProductScalar>>? distinct,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product?>(
      action: 'findFirstProduct',
      result: result,
      factory: (e) => e != null ? _i2.Product.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Product> findFirstOrThrow({
    _i3.ProductWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductOrderByWithRelationInput>,
            _i3.ProductOrderByWithRelationInput>?
        orderBy,
    _i3.ProductWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductScalar, Iterable<_i3.ProductScalar>>? distinct,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product>(
      action: 'findFirstProductOrThrow',
      result: result,
      factory: (e) => _i2.Product.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Product>> findMany({
    _i3.ProductWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductOrderByWithRelationInput>,
            _i3.ProductOrderByWithRelationInput>?
        orderBy,
    _i3.ProductWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductScalar, Iterable<_i3.ProductScalar>>? distinct,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Product>>(
      action: 'findManyProduct',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Product.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Product> create({
    required _i1
        .PrismaUnion<_i3.ProductCreateInput, _i3.ProductUncheckedCreateInput>
        data,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product>(
      action: 'createOneProduct',
      result: result,
      factory: (e) => _i2.Product.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.ProductCreateManyInput,
              Iterable<_i3.ProductCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProduct',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyProductAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductCreateManyInput,
            Iterable<_i3.ProductCreateManyInput>>
        data,
    _i3.CreateManyProductAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyProductAndReturnOutputType>>(
      action: 'createManyProductAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyProductAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Product?> update({
    required _i1
        .PrismaUnion<_i3.ProductUpdateInput, _i3.ProductUncheckedUpdateInput>
        data,
    required _i3.ProductWhereUniqueInput where,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product?>(
      action: 'updateOneProduct',
      result: result,
      factory: (e) => e != null ? _i2.Product.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProductUpdateManyMutationInput,
            _i3.ProductUncheckedUpdateManyInput>
        data,
    _i3.ProductWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProduct',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyProductAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductUpdateManyMutationInput,
            _i3.ProductUncheckedUpdateManyInput>
        data,
    _i3.ProductWhereInput? where,
    int? limit,
    _i3.UpdateManyProductAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyProductAndReturnOutputType>>(
      action: 'updateManyProductAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyProductAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Product> upsert({
    required _i3.ProductWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.ProductCreateInput, _i3.ProductUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.ProductUpdateInput, _i3.ProductUncheckedUpdateInput>
        update,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product>(
      action: 'upsertOneProduct',
      result: result,
      factory: (e) => _i2.Product.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Product?> delete({
    required _i3.ProductWhereUniqueInput where,
    _i3.ProductSelect? select,
    _i3.ProductInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Product?>(
      action: 'deleteOneProduct',
      result: result,
      factory: (e) => e != null ? _i2.Product.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.ProductWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Product',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProduct',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProductGroupByOutputType>> groupBy({
    _i3.ProductWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductOrderByWithAggregationInput>,
            _i3.ProductOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ProductScalar>, _i3.ProductScalar> by,
    _i3.ProductScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProductGroupByOutputTypeSelect? select,
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
      modelName: 'Product',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProductGroupByOutputType>>(
      action: 'groupByProduct',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProductGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProduct> aggregate({
    _i3.ProductWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductOrderByWithRelationInput>,
            _i3.ProductOrderByWithRelationInput>?
        orderBy,
    _i3.ProductWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProductSelect? select,
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
      modelName: 'Product',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProduct>(
      action: 'aggregateProduct',
      result: result,
      factory: (e) => _i3.AggregateProduct.fromJson(e),
    );
  }
}

class ProductCategoryDelegate {
  const ProductCategoryDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ProductCategory?> findUnique({
    required _i3.ProductCategoryWhereUniqueInput where,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory?>(
      action: 'findUniqueProductCategory',
      result: result,
      factory: (e) => e != null ? _i2.ProductCategory.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductCategory> findUniqueOrThrow({
    required _i3.ProductCategoryWhereUniqueInput where,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory>(
      action: 'findUniqueProductCategoryOrThrow',
      result: result,
      factory: (e) => _i2.ProductCategory.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductCategory?> findFirst({
    _i3.ProductCategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductCategoryOrderByWithRelationInput>,
            _i3.ProductCategoryOrderByWithRelationInput>?
        orderBy,
    _i3.ProductCategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductCategoryScalar,
            Iterable<_i3.ProductCategoryScalar>>?
        distinct,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory?>(
      action: 'findFirstProductCategory',
      result: result,
      factory: (e) => e != null ? _i2.ProductCategory.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductCategory> findFirstOrThrow({
    _i3.ProductCategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductCategoryOrderByWithRelationInput>,
            _i3.ProductCategoryOrderByWithRelationInput>?
        orderBy,
    _i3.ProductCategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductCategoryScalar,
            Iterable<_i3.ProductCategoryScalar>>?
        distinct,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory>(
      action: 'findFirstProductCategoryOrThrow',
      result: result,
      factory: (e) => _i2.ProductCategory.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ProductCategory>> findMany({
    _i3.ProductCategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductCategoryOrderByWithRelationInput>,
            _i3.ProductCategoryOrderByWithRelationInput>?
        orderBy,
    _i3.ProductCategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductCategoryScalar,
            Iterable<_i3.ProductCategoryScalar>>?
        distinct,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ProductCategory>>(
      action: 'findManyProductCategory',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ProductCategory.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductCategory> create({
    required _i1.PrismaUnion<_i3.ProductCategoryCreateInput,
            _i3.ProductCategoryUncheckedCreateInput>
        data,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory>(
      action: 'createOneProductCategory',
      result: result,
      factory: (e) => _i2.ProductCategory.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.ProductCategoryCreateManyInput,
              Iterable<_i3.ProductCategoryCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProductCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyProductCategoryAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductCategoryCreateManyInput,
            Iterable<_i3.ProductCategoryCreateManyInput>>
        data,
    _i3.CreateManyProductCategoryAndReturnOutputTypeSelect? select,
    _i3.CreateManyProductCategoryAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyProductCategoryAndReturnOutputType>>(
      action: 'createManyProductCategoryAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.CreateManyProductCategoryAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductCategory?> update({
    required _i1.PrismaUnion<_i3.ProductCategoryUpdateInput,
            _i3.ProductCategoryUncheckedUpdateInput>
        data,
    required _i3.ProductCategoryWhereUniqueInput where,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory?>(
      action: 'updateOneProductCategory',
      result: result,
      factory: (e) => e != null ? _i2.ProductCategory.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProductCategoryUpdateManyMutationInput,
            _i3.ProductCategoryUncheckedUpdateManyInput>
        data,
    _i3.ProductCategoryWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProductCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyProductCategoryAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductCategoryUpdateManyMutationInput,
            _i3.ProductCategoryUncheckedUpdateManyInput>
        data,
    _i3.ProductCategoryWhereInput? where,
    int? limit,
    _i3.UpdateManyProductCategoryAndReturnOutputTypeSelect? select,
    _i3.UpdateManyProductCategoryAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyProductCategoryAndReturnOutputType>>(
      action: 'updateManyProductCategoryAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.UpdateManyProductCategoryAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductCategory> upsert({
    required _i3.ProductCategoryWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ProductCategoryCreateInput,
            _i3.ProductCategoryUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ProductCategoryUpdateInput,
            _i3.ProductCategoryUncheckedUpdateInput>
        update,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory>(
      action: 'upsertOneProductCategory',
      result: result,
      factory: (e) => _i2.ProductCategory.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductCategory?> delete({
    required _i3.ProductCategoryWhereUniqueInput where,
    _i3.ProductCategorySelect? select,
    _i3.ProductCategoryInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductCategory?>(
      action: 'deleteOneProductCategory',
      result: result,
      factory: (e) => e != null ? _i2.ProductCategory.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.ProductCategoryWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProductCategory',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProductCategoryGroupByOutputType>> groupBy({
    _i3.ProductCategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductCategoryOrderByWithAggregationInput>,
            _i3.ProductCategoryOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ProductCategoryScalar>,
            _i3.ProductCategoryScalar>
        by,
    _i3.ProductCategoryScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProductCategoryGroupByOutputTypeSelect? select,
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
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProductCategoryGroupByOutputType>>(
      action: 'groupByProductCategory',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProductCategoryGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProductCategory> aggregate({
    _i3.ProductCategoryWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductCategoryOrderByWithRelationInput>,
            _i3.ProductCategoryOrderByWithRelationInput>?
        orderBy,
    _i3.ProductCategoryWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProductCategorySelect? select,
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
      modelName: 'ProductCategory',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProductCategory>(
      action: 'aggregateProductCategory',
      result: result,
      factory: (e) => _i3.AggregateProductCategory.fromJson(e),
    );
  }
}

class ProductImageDelegate {
  const ProductImageDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ProductImage?> findUnique({
    required _i3.ProductImageWhereUniqueInput where,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage?>(
      action: 'findUniqueProductImage',
      result: result,
      factory: (e) => e != null ? _i2.ProductImage.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductImage> findUniqueOrThrow({
    required _i3.ProductImageWhereUniqueInput where,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage>(
      action: 'findUniqueProductImageOrThrow',
      result: result,
      factory: (e) => _i2.ProductImage.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductImage?> findFirst({
    _i3.ProductImageWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductImageOrderByWithRelationInput>,
            _i3.ProductImageOrderByWithRelationInput>?
        orderBy,
    _i3.ProductImageWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductImageScalar, Iterable<_i3.ProductImageScalar>>?
        distinct,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage?>(
      action: 'findFirstProductImage',
      result: result,
      factory: (e) => e != null ? _i2.ProductImage.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductImage> findFirstOrThrow({
    _i3.ProductImageWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductImageOrderByWithRelationInput>,
            _i3.ProductImageOrderByWithRelationInput>?
        orderBy,
    _i3.ProductImageWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductImageScalar, Iterable<_i3.ProductImageScalar>>?
        distinct,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage>(
      action: 'findFirstProductImageOrThrow',
      result: result,
      factory: (e) => _i2.ProductImage.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ProductImage>> findMany({
    _i3.ProductImageWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductImageOrderByWithRelationInput>,
            _i3.ProductImageOrderByWithRelationInput>?
        orderBy,
    _i3.ProductImageWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductImageScalar, Iterable<_i3.ProductImageScalar>>?
        distinct,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ProductImage>>(
      action: 'findManyProductImage',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ProductImage.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductImage> create({
    required _i1.PrismaUnion<_i3.ProductImageCreateInput,
            _i3.ProductImageUncheckedCreateInput>
        data,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage>(
      action: 'createOneProductImage',
      result: result,
      factory: (e) => _i2.ProductImage.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.ProductImageCreateManyInput,
              Iterable<_i3.ProductImageCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProductImage',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyProductImageAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductImageCreateManyInput,
            Iterable<_i3.ProductImageCreateManyInput>>
        data,
    _i3.CreateManyProductImageAndReturnOutputTypeSelect? select,
    _i3.CreateManyProductImageAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyProductImageAndReturnOutputType>>(
      action: 'createManyProductImageAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.CreateManyProductImageAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductImage?> update({
    required _i1.PrismaUnion<_i3.ProductImageUpdateInput,
            _i3.ProductImageUncheckedUpdateInput>
        data,
    required _i3.ProductImageWhereUniqueInput where,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage?>(
      action: 'updateOneProductImage',
      result: result,
      factory: (e) => e != null ? _i2.ProductImage.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProductImageUpdateManyMutationInput,
            _i3.ProductImageUncheckedUpdateManyInput>
        data,
    _i3.ProductImageWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProductImage',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyProductImageAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductImageUpdateManyMutationInput,
            _i3.ProductImageUncheckedUpdateManyInput>
        data,
    _i3.ProductImageWhereInput? where,
    int? limit,
    _i3.UpdateManyProductImageAndReturnOutputTypeSelect? select,
    _i3.UpdateManyProductImageAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyProductImageAndReturnOutputType>>(
      action: 'updateManyProductImageAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.UpdateManyProductImageAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductImage> upsert({
    required _i3.ProductImageWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ProductImageCreateInput,
            _i3.ProductImageUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ProductImageUpdateInput,
            _i3.ProductImageUncheckedUpdateInput>
        update,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage>(
      action: 'upsertOneProductImage',
      result: result,
      factory: (e) => _i2.ProductImage.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductImage?> delete({
    required _i3.ProductImageWhereUniqueInput where,
    _i3.ProductImageSelect? select,
    _i3.ProductImageInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductImage?>(
      action: 'deleteOneProductImage',
      result: result,
      factory: (e) => e != null ? _i2.ProductImage.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.ProductImageWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProductImage',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProductImageGroupByOutputType>> groupBy({
    _i3.ProductImageWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductImageOrderByWithAggregationInput>,
            _i3.ProductImageOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.ProductImageScalar>, _i3.ProductImageScalar>
        by,
    _i3.ProductImageScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProductImageGroupByOutputTypeSelect? select,
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
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProductImageGroupByOutputType>>(
      action: 'groupByProductImage',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProductImageGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProductImage> aggregate({
    _i3.ProductImageWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductImageOrderByWithRelationInput>,
            _i3.ProductImageOrderByWithRelationInput>?
        orderBy,
    _i3.ProductImageWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProductImageSelect? select,
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
      modelName: 'ProductImage',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProductImage>(
      action: 'aggregateProductImage',
      result: result,
      factory: (e) => _i3.AggregateProductImage.fromJson(e),
    );
  }
}

class CartDelegate {
  const CartDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Cart?> findUnique({
    required _i3.CartWhereUniqueInput where,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart?>(
      action: 'findUniqueCart',
      result: result,
      factory: (e) => e != null ? _i2.Cart.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Cart> findUniqueOrThrow({
    required _i3.CartWhereUniqueInput where,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart>(
      action: 'findUniqueCartOrThrow',
      result: result,
      factory: (e) => _i2.Cart.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Cart?> findFirst({
    _i3.CartWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartOrderByWithRelationInput>,
            _i3.CartOrderByWithRelationInput>?
        orderBy,
    _i3.CartWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartScalar, Iterable<_i3.CartScalar>>? distinct,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart?>(
      action: 'findFirstCart',
      result: result,
      factory: (e) => e != null ? _i2.Cart.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Cart> findFirstOrThrow({
    _i3.CartWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartOrderByWithRelationInput>,
            _i3.CartOrderByWithRelationInput>?
        orderBy,
    _i3.CartWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartScalar, Iterable<_i3.CartScalar>>? distinct,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart>(
      action: 'findFirstCartOrThrow',
      result: result,
      factory: (e) => _i2.Cart.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Cart>> findMany({
    _i3.CartWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartOrderByWithRelationInput>,
            _i3.CartOrderByWithRelationInput>?
        orderBy,
    _i3.CartWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartScalar, Iterable<_i3.CartScalar>>? distinct,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Cart>>(
      action: 'findManyCart',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Cart.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Cart> create({
    required _i1.PrismaUnion<_i3.CartCreateInput, _i3.CartUncheckedCreateInput>
        data,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart>(
      action: 'createOneCart',
      result: result,
      factory: (e) => _i2.Cart.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.CartCreateManyInput,
              Iterable<_i3.CartCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyCart',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyCartAndReturnOutputType>>
      createManyAndReturn({
    required _i1
        .PrismaUnion<_i3.CartCreateManyInput, Iterable<_i3.CartCreateManyInput>>
        data,
    _i3.CreateManyCartAndReturnOutputTypeSelect? select,
    _i3.CreateManyCartAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyCartAndReturnOutputType>>(
      action: 'createManyCartAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyCartAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Cart?> update({
    required _i1.PrismaUnion<_i3.CartUpdateInput, _i3.CartUncheckedUpdateInput>
        data,
    required _i3.CartWhereUniqueInput where,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart?>(
      action: 'updateOneCart',
      result: result,
      factory: (e) => e != null ? _i2.Cart.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.CartUpdateManyMutationInput,
            _i3.CartUncheckedUpdateManyInput>
        data,
    _i3.CartWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyCart',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyCartAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.CartUpdateManyMutationInput,
            _i3.CartUncheckedUpdateManyInput>
        data,
    _i3.CartWhereInput? where,
    int? limit,
    _i3.UpdateManyCartAndReturnOutputTypeSelect? select,
    _i3.UpdateManyCartAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyCartAndReturnOutputType>>(
      action: 'updateManyCartAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyCartAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Cart> upsert({
    required _i3.CartWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.CartCreateInput, _i3.CartUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.CartUpdateInput, _i3.CartUncheckedUpdateInput>
        update,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart>(
      action: 'upsertOneCart',
      result: result,
      factory: (e) => _i2.Cart.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Cart?> delete({
    required _i3.CartWhereUniqueInput where,
    _i3.CartSelect? select,
    _i3.CartInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Cart?>(
      action: 'deleteOneCart',
      result: result,
      factory: (e) => e != null ? _i2.Cart.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.CartWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Cart',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyCart',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.CartGroupByOutputType>> groupBy({
    _i3.CartWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartOrderByWithAggregationInput>,
            _i3.CartOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.CartScalar>, _i3.CartScalar> by,
    _i3.CartScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.CartGroupByOutputTypeSelect? select,
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
      modelName: 'Cart',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.CartGroupByOutputType>>(
      action: 'groupByCart',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.CartGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateCart> aggregate({
    _i3.CartWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartOrderByWithRelationInput>,
            _i3.CartOrderByWithRelationInput>?
        orderBy,
    _i3.CartWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateCartSelect? select,
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
      modelName: 'Cart',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateCart>(
      action: 'aggregateCart',
      result: result,
      factory: (e) => _i3.AggregateCart.fromJson(e),
    );
  }
}

class CartItemDelegate {
  const CartItemDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.CartItem?> findUnique({
    required _i3.CartItemWhereUniqueInput where,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem?>(
      action: 'findUniqueCartItem',
      result: result,
      factory: (e) => e != null ? _i2.CartItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.CartItem> findUniqueOrThrow({
    required _i3.CartItemWhereUniqueInput where,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem>(
      action: 'findUniqueCartItemOrThrow',
      result: result,
      factory: (e) => _i2.CartItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.CartItem?> findFirst({
    _i3.CartItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartItemOrderByWithRelationInput>,
            _i3.CartItemOrderByWithRelationInput>?
        orderBy,
    _i3.CartItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartItemScalar, Iterable<_i3.CartItemScalar>>? distinct,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem?>(
      action: 'findFirstCartItem',
      result: result,
      factory: (e) => e != null ? _i2.CartItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.CartItem> findFirstOrThrow({
    _i3.CartItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartItemOrderByWithRelationInput>,
            _i3.CartItemOrderByWithRelationInput>?
        orderBy,
    _i3.CartItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartItemScalar, Iterable<_i3.CartItemScalar>>? distinct,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem>(
      action: 'findFirstCartItemOrThrow',
      result: result,
      factory: (e) => _i2.CartItem.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CartItem>> findMany({
    _i3.CartItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartItemOrderByWithRelationInput>,
            _i3.CartItemOrderByWithRelationInput>?
        orderBy,
    _i3.CartItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.CartItemScalar, Iterable<_i3.CartItemScalar>>? distinct,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CartItem>>(
      action: 'findManyCartItem',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.CartItem.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.CartItem> create({
    required _i1
        .PrismaUnion<_i3.CartItemCreateInput, _i3.CartItemUncheckedCreateInput>
        data,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem>(
      action: 'createOneCartItem',
      result: result,
      factory: (e) => _i2.CartItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.CartItemCreateManyInput,
              Iterable<_i3.CartItemCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyCartItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyCartItemAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.CartItemCreateManyInput,
            Iterable<_i3.CartItemCreateManyInput>>
        data,
    _i3.CreateManyCartItemAndReturnOutputTypeSelect? select,
    _i3.CreateManyCartItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyCartItemAndReturnOutputType>>(
      action: 'createManyCartItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyCartItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.CartItem?> update({
    required _i1
        .PrismaUnion<_i3.CartItemUpdateInput, _i3.CartItemUncheckedUpdateInput>
        data,
    required _i3.CartItemWhereUniqueInput where,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem?>(
      action: 'updateOneCartItem',
      result: result,
      factory: (e) => e != null ? _i2.CartItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.CartItemUpdateManyMutationInput,
            _i3.CartItemUncheckedUpdateManyInput>
        data,
    _i3.CartItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyCartItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyCartItemAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.CartItemUpdateManyMutationInput,
            _i3.CartItemUncheckedUpdateManyInput>
        data,
    _i3.CartItemWhereInput? where,
    int? limit,
    _i3.UpdateManyCartItemAndReturnOutputTypeSelect? select,
    _i3.UpdateManyCartItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyCartItemAndReturnOutputType>>(
      action: 'updateManyCartItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyCartItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.CartItem> upsert({
    required _i3.CartItemWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.CartItemCreateInput, _i3.CartItemUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.CartItemUpdateInput, _i3.CartItemUncheckedUpdateInput>
        update,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem>(
      action: 'upsertOneCartItem',
      result: result,
      factory: (e) => _i2.CartItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.CartItem?> delete({
    required _i3.CartItemWhereUniqueInput where,
    _i3.CartItemSelect? select,
    _i3.CartItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.CartItem?>(
      action: 'deleteOneCartItem',
      result: result,
      factory: (e) => e != null ? _i2.CartItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.CartItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyCartItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.CartItemGroupByOutputType>> groupBy({
    _i3.CartItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartItemOrderByWithAggregationInput>,
            _i3.CartItemOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.CartItemScalar>, _i3.CartItemScalar>
        by,
    _i3.CartItemScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.CartItemGroupByOutputTypeSelect? select,
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
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.CartItemGroupByOutputType>>(
      action: 'groupByCartItem',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.CartItemGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateCartItem> aggregate({
    _i3.CartItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.CartItemOrderByWithRelationInput>,
            _i3.CartItemOrderByWithRelationInput>?
        orderBy,
    _i3.CartItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateCartItemSelect? select,
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
      modelName: 'CartItem',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateCartItem>(
      action: 'aggregateCartItem',
      result: result,
      factory: (e) => _i3.AggregateCartItem.fromJson(e),
    );
  }
}

class OrderDelegate {
  const OrderDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Order?> findUnique({
    required _i3.OrderWhereUniqueInput where,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order?>(
      action: 'findUniqueOrder',
      result: result,
      factory: (e) => e != null ? _i2.Order.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Order> findUniqueOrThrow({
    required _i3.OrderWhereUniqueInput where,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order>(
      action: 'findUniqueOrderOrThrow',
      result: result,
      factory: (e) => _i2.Order.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Order?> findFirst({
    _i3.OrderWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderOrderByWithRelationInput>,
            _i3.OrderOrderByWithRelationInput>?
        orderBy,
    _i3.OrderWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderScalar, Iterable<_i3.OrderScalar>>? distinct,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order?>(
      action: 'findFirstOrder',
      result: result,
      factory: (e) => e != null ? _i2.Order.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Order> findFirstOrThrow({
    _i3.OrderWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderOrderByWithRelationInput>,
            _i3.OrderOrderByWithRelationInput>?
        orderBy,
    _i3.OrderWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderScalar, Iterable<_i3.OrderScalar>>? distinct,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order>(
      action: 'findFirstOrderOrThrow',
      result: result,
      factory: (e) => _i2.Order.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Order>> findMany({
    _i3.OrderWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderOrderByWithRelationInput>,
            _i3.OrderOrderByWithRelationInput>?
        orderBy,
    _i3.OrderWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderScalar, Iterable<_i3.OrderScalar>>? distinct,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Order>>(
      action: 'findManyOrder',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Order.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Order> create({
    required _i1
        .PrismaUnion<_i3.OrderCreateInput, _i3.OrderUncheckedCreateInput>
        data,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order>(
      action: 'createOneOrder',
      result: result,
      factory: (e) => _i2.Order.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.OrderCreateManyInput,
              Iterable<_i3.OrderCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyOrder',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyOrderAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.OrderCreateManyInput,
            Iterable<_i3.OrderCreateManyInput>>
        data,
    _i3.CreateManyOrderAndReturnOutputTypeSelect? select,
    _i3.CreateManyOrderAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyOrderAndReturnOutputType>>(
      action: 'createManyOrderAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyOrderAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Order?> update({
    required _i1
        .PrismaUnion<_i3.OrderUpdateInput, _i3.OrderUncheckedUpdateInput>
        data,
    required _i3.OrderWhereUniqueInput where,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order?>(
      action: 'updateOneOrder',
      result: result,
      factory: (e) => e != null ? _i2.Order.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.OrderUpdateManyMutationInput,
            _i3.OrderUncheckedUpdateManyInput>
        data,
    _i3.OrderWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyOrder',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyOrderAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.OrderUpdateManyMutationInput,
            _i3.OrderUncheckedUpdateManyInput>
        data,
    _i3.OrderWhereInput? where,
    int? limit,
    _i3.UpdateManyOrderAndReturnOutputTypeSelect? select,
    _i3.UpdateManyOrderAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyOrderAndReturnOutputType>>(
      action: 'updateManyOrderAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyOrderAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Order> upsert({
    required _i3.OrderWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.OrderCreateInput, _i3.OrderUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.OrderUpdateInput, _i3.OrderUncheckedUpdateInput>
        update,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order>(
      action: 'upsertOneOrder',
      result: result,
      factory: (e) => _i2.Order.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Order?> delete({
    required _i3.OrderWhereUniqueInput where,
    _i3.OrderSelect? select,
    _i3.OrderInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Order?>(
      action: 'deleteOneOrder',
      result: result,
      factory: (e) => e != null ? _i2.Order.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.OrderWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Order',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyOrder',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.OrderGroupByOutputType>> groupBy({
    _i3.OrderWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderOrderByWithAggregationInput>,
            _i3.OrderOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.OrderScalar>, _i3.OrderScalar> by,
    _i3.OrderScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.OrderGroupByOutputTypeSelect? select,
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
      modelName: 'Order',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.OrderGroupByOutputType>>(
      action: 'groupByOrder',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.OrderGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateOrder> aggregate({
    _i3.OrderWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderOrderByWithRelationInput>,
            _i3.OrderOrderByWithRelationInput>?
        orderBy,
    _i3.OrderWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateOrderSelect? select,
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
      modelName: 'Order',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateOrder>(
      action: 'aggregateOrder',
      result: result,
      factory: (e) => _i3.AggregateOrder.fromJson(e),
    );
  }
}

class OrderItemDelegate {
  const OrderItemDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.OrderItem?> findUnique({
    required _i3.OrderItemWhereUniqueInput where,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem?>(
      action: 'findUniqueOrderItem',
      result: result,
      factory: (e) => e != null ? _i2.OrderItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.OrderItem> findUniqueOrThrow({
    required _i3.OrderItemWhereUniqueInput where,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem>(
      action: 'findUniqueOrderItemOrThrow',
      result: result,
      factory: (e) => _i2.OrderItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.OrderItem?> findFirst({
    _i3.OrderItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderItemOrderByWithRelationInput>,
            _i3.OrderItemOrderByWithRelationInput>?
        orderBy,
    _i3.OrderItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderItemScalar, Iterable<_i3.OrderItemScalar>>?
        distinct,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem?>(
      action: 'findFirstOrderItem',
      result: result,
      factory: (e) => e != null ? _i2.OrderItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.OrderItem> findFirstOrThrow({
    _i3.OrderItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderItemOrderByWithRelationInput>,
            _i3.OrderItemOrderByWithRelationInput>?
        orderBy,
    _i3.OrderItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderItemScalar, Iterable<_i3.OrderItemScalar>>?
        distinct,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem>(
      action: 'findFirstOrderItemOrThrow',
      result: result,
      factory: (e) => _i2.OrderItem.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.OrderItem>> findMany({
    _i3.OrderItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderItemOrderByWithRelationInput>,
            _i3.OrderItemOrderByWithRelationInput>?
        orderBy,
    _i3.OrderItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.OrderItemScalar, Iterable<_i3.OrderItemScalar>>?
        distinct,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.OrderItem>>(
      action: 'findManyOrderItem',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.OrderItem.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.OrderItem> create({
    required _i1.PrismaUnion<_i3.OrderItemCreateInput,
            _i3.OrderItemUncheckedCreateInput>
        data,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem>(
      action: 'createOneOrderItem',
      result: result,
      factory: (e) => _i2.OrderItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.OrderItemCreateManyInput,
              Iterable<_i3.OrderItemCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyOrderItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyOrderItemAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.OrderItemCreateManyInput,
            Iterable<_i3.OrderItemCreateManyInput>>
        data,
    _i3.CreateManyOrderItemAndReturnOutputTypeSelect? select,
    _i3.CreateManyOrderItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyOrderItemAndReturnOutputType>>(
      action: 'createManyOrderItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyOrderItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.OrderItem?> update({
    required _i1.PrismaUnion<_i3.OrderItemUpdateInput,
            _i3.OrderItemUncheckedUpdateInput>
        data,
    required _i3.OrderItemWhereUniqueInput where,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem?>(
      action: 'updateOneOrderItem',
      result: result,
      factory: (e) => e != null ? _i2.OrderItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.OrderItemUpdateManyMutationInput,
            _i3.OrderItemUncheckedUpdateManyInput>
        data,
    _i3.OrderItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyOrderItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyOrderItemAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.OrderItemUpdateManyMutationInput,
            _i3.OrderItemUncheckedUpdateManyInput>
        data,
    _i3.OrderItemWhereInput? where,
    int? limit,
    _i3.UpdateManyOrderItemAndReturnOutputTypeSelect? select,
    _i3.UpdateManyOrderItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyOrderItemAndReturnOutputType>>(
      action: 'updateManyOrderItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyOrderItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.OrderItem> upsert({
    required _i3.OrderItemWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.OrderItemCreateInput,
            _i3.OrderItemUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.OrderItemUpdateInput,
            _i3.OrderItemUncheckedUpdateInput>
        update,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem>(
      action: 'upsertOneOrderItem',
      result: result,
      factory: (e) => _i2.OrderItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.OrderItem?> delete({
    required _i3.OrderItemWhereUniqueInput where,
    _i3.OrderItemSelect? select,
    _i3.OrderItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.OrderItem?>(
      action: 'deleteOneOrderItem',
      result: result,
      factory: (e) => e != null ? _i2.OrderItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.OrderItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyOrderItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.OrderItemGroupByOutputType>> groupBy({
    _i3.OrderItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderItemOrderByWithAggregationInput>,
            _i3.OrderItemOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.OrderItemScalar>, _i3.OrderItemScalar>
        by,
    _i3.OrderItemScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.OrderItemGroupByOutputTypeSelect? select,
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
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.OrderItemGroupByOutputType>>(
      action: 'groupByOrderItem',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.OrderItemGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateOrderItem> aggregate({
    _i3.OrderItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.OrderItemOrderByWithRelationInput>,
            _i3.OrderItemOrderByWithRelationInput>?
        orderBy,
    _i3.OrderItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateOrderItemSelect? select,
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
      modelName: 'OrderItem',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateOrderItem>(
      action: 'aggregateOrderItem',
      result: result,
      factory: (e) => _i3.AggregateOrderItem.fromJson(e),
    );
  }
}

class PaymentDelegate {
  const PaymentDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Payment?> findUnique({
    required _i3.PaymentWhereUniqueInput where,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment?>(
      action: 'findUniquePayment',
      result: result,
      factory: (e) => e != null ? _i2.Payment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Payment> findUniqueOrThrow({
    required _i3.PaymentWhereUniqueInput where,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment>(
      action: 'findUniquePaymentOrThrow',
      result: result,
      factory: (e) => _i2.Payment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Payment?> findFirst({
    _i3.PaymentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PaymentOrderByWithRelationInput>,
            _i3.PaymentOrderByWithRelationInput>?
        orderBy,
    _i3.PaymentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PaymentScalar, Iterable<_i3.PaymentScalar>>? distinct,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment?>(
      action: 'findFirstPayment',
      result: result,
      factory: (e) => e != null ? _i2.Payment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Payment> findFirstOrThrow({
    _i3.PaymentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PaymentOrderByWithRelationInput>,
            _i3.PaymentOrderByWithRelationInput>?
        orderBy,
    _i3.PaymentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PaymentScalar, Iterable<_i3.PaymentScalar>>? distinct,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment>(
      action: 'findFirstPaymentOrThrow',
      result: result,
      factory: (e) => _i2.Payment.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Payment>> findMany({
    _i3.PaymentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PaymentOrderByWithRelationInput>,
            _i3.PaymentOrderByWithRelationInput>?
        orderBy,
    _i3.PaymentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.PaymentScalar, Iterable<_i3.PaymentScalar>>? distinct,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Payment>>(
      action: 'findManyPayment',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Payment.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Payment> create({
    required _i1
        .PrismaUnion<_i3.PaymentCreateInput, _i3.PaymentUncheckedCreateInput>
        data,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment>(
      action: 'createOnePayment',
      result: result,
      factory: (e) => _i2.Payment.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.PaymentCreateManyInput,
              Iterable<_i3.PaymentCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyPayment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyPaymentAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.PaymentCreateManyInput,
            Iterable<_i3.PaymentCreateManyInput>>
        data,
    _i3.CreateManyPaymentAndReturnOutputTypeSelect? select,
    _i3.CreateManyPaymentAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyPaymentAndReturnOutputType>>(
      action: 'createManyPaymentAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyPaymentAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Payment?> update({
    required _i1
        .PrismaUnion<_i3.PaymentUpdateInput, _i3.PaymentUncheckedUpdateInput>
        data,
    required _i3.PaymentWhereUniqueInput where,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment?>(
      action: 'updateOnePayment',
      result: result,
      factory: (e) => e != null ? _i2.Payment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.PaymentUpdateManyMutationInput,
            _i3.PaymentUncheckedUpdateManyInput>
        data,
    _i3.PaymentWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyPayment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyPaymentAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.PaymentUpdateManyMutationInput,
            _i3.PaymentUncheckedUpdateManyInput>
        data,
    _i3.PaymentWhereInput? where,
    int? limit,
    _i3.UpdateManyPaymentAndReturnOutputTypeSelect? select,
    _i3.UpdateManyPaymentAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyPaymentAndReturnOutputType>>(
      action: 'updateManyPaymentAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyPaymentAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Payment> upsert({
    required _i3.PaymentWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.PaymentCreateInput, _i3.PaymentUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.PaymentUpdateInput, _i3.PaymentUncheckedUpdateInput>
        update,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment>(
      action: 'upsertOnePayment',
      result: result,
      factory: (e) => _i2.Payment.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Payment?> delete({
    required _i3.PaymentWhereUniqueInput where,
    _i3.PaymentSelect? select,
    _i3.PaymentInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Payment?>(
      action: 'deleteOnePayment',
      result: result,
      factory: (e) => e != null ? _i2.Payment.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.PaymentWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Payment',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyPayment',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.PaymentGroupByOutputType>> groupBy({
    _i3.PaymentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PaymentOrderByWithAggregationInput>,
            _i3.PaymentOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.PaymentScalar>, _i3.PaymentScalar> by,
    _i3.PaymentScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.PaymentGroupByOutputTypeSelect? select,
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
      modelName: 'Payment',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.PaymentGroupByOutputType>>(
      action: 'groupByPayment',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.PaymentGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregatePayment> aggregate({
    _i3.PaymentWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.PaymentOrderByWithRelationInput>,
            _i3.PaymentOrderByWithRelationInput>?
        orderBy,
    _i3.PaymentWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregatePaymentSelect? select,
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
      modelName: 'Payment',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregatePayment>(
      action: 'aggregatePayment',
      result: result,
      factory: (e) => _i3.AggregatePayment.fromJson(e),
    );
  }
}

class ReviewDelegate {
  const ReviewDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Review?> findUnique({
    required _i3.ReviewWhereUniqueInput where,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review?>(
      action: 'findUniqueReview',
      result: result,
      factory: (e) => e != null ? _i2.Review.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Review> findUniqueOrThrow({
    required _i3.ReviewWhereUniqueInput where,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review>(
      action: 'findUniqueReviewOrThrow',
      result: result,
      factory: (e) => _i2.Review.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Review?> findFirst({
    _i3.ReviewWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReviewOrderByWithRelationInput>,
            _i3.ReviewOrderByWithRelationInput>?
        orderBy,
    _i3.ReviewWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReviewScalar, Iterable<_i3.ReviewScalar>>? distinct,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review?>(
      action: 'findFirstReview',
      result: result,
      factory: (e) => e != null ? _i2.Review.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Review> findFirstOrThrow({
    _i3.ReviewWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReviewOrderByWithRelationInput>,
            _i3.ReviewOrderByWithRelationInput>?
        orderBy,
    _i3.ReviewWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReviewScalar, Iterable<_i3.ReviewScalar>>? distinct,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review>(
      action: 'findFirstReviewOrThrow',
      result: result,
      factory: (e) => _i2.Review.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Review>> findMany({
    _i3.ReviewWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReviewOrderByWithRelationInput>,
            _i3.ReviewOrderByWithRelationInput>?
        orderBy,
    _i3.ReviewWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ReviewScalar, Iterable<_i3.ReviewScalar>>? distinct,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Review>>(
      action: 'findManyReview',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Review.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Review> create({
    required _i1
        .PrismaUnion<_i3.ReviewCreateInput, _i3.ReviewUncheckedCreateInput>
        data,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review>(
      action: 'createOneReview',
      result: result,
      factory: (e) => _i2.Review.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.ReviewCreateManyInput,
              Iterable<_i3.ReviewCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyReview',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyReviewAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.ReviewCreateManyInput,
            Iterable<_i3.ReviewCreateManyInput>>
        data,
    _i3.CreateManyReviewAndReturnOutputTypeSelect? select,
    _i3.CreateManyReviewAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.CreateManyReviewAndReturnOutputType>>(
      action: 'createManyReviewAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyReviewAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Review?> update({
    required _i1
        .PrismaUnion<_i3.ReviewUpdateInput, _i3.ReviewUncheckedUpdateInput>
        data,
    required _i3.ReviewWhereUniqueInput where,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review?>(
      action: 'updateOneReview',
      result: result,
      factory: (e) => e != null ? _i2.Review.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ReviewUpdateManyMutationInput,
            _i3.ReviewUncheckedUpdateManyInput>
        data,
    _i3.ReviewWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyReview',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyReviewAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.ReviewUpdateManyMutationInput,
            _i3.ReviewUncheckedUpdateManyInput>
        data,
    _i3.ReviewWhereInput? where,
    int? limit,
    _i3.UpdateManyReviewAndReturnOutputTypeSelect? select,
    _i3.UpdateManyReviewAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.UpdateManyReviewAndReturnOutputType>>(
      action: 'updateManyReviewAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyReviewAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Review> upsert({
    required _i3.ReviewWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.ReviewCreateInput, _i3.ReviewUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.ReviewUpdateInput, _i3.ReviewUncheckedUpdateInput>
        update,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review>(
      action: 'upsertOneReview',
      result: result,
      factory: (e) => _i2.Review.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Review?> delete({
    required _i3.ReviewWhereUniqueInput where,
    _i3.ReviewSelect? select,
    _i3.ReviewInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Review?>(
      action: 'deleteOneReview',
      result: result,
      factory: (e) => e != null ? _i2.Review.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.ReviewWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Review',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyReview',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ReviewGroupByOutputType>> groupBy({
    _i3.ReviewWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReviewOrderByWithAggregationInput>,
            _i3.ReviewOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ReviewScalar>, _i3.ReviewScalar> by,
    _i3.ReviewScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ReviewGroupByOutputTypeSelect? select,
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
      modelName: 'Review',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ReviewGroupByOutputType>>(
      action: 'groupByReview',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ReviewGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateReview> aggregate({
    _i3.ReviewWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ReviewOrderByWithRelationInput>,
            _i3.ReviewOrderByWithRelationInput>?
        orderBy,
    _i3.ReviewWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateReviewSelect? select,
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
      modelName: 'Review',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateReview>(
      action: 'aggregateReview',
      result: result,
      factory: (e) => _i3.AggregateReview.fromJson(e),
    );
  }
}

class WishlistDelegate {
  const WishlistDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Wishlist?> findUnique({
    required _i3.WishlistWhereUniqueInput where,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist?>(
      action: 'findUniqueWishlist',
      result: result,
      factory: (e) => e != null ? _i2.Wishlist.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Wishlist> findUniqueOrThrow({
    required _i3.WishlistWhereUniqueInput where,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist>(
      action: 'findUniqueWishlistOrThrow',
      result: result,
      factory: (e) => _i2.Wishlist.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Wishlist?> findFirst({
    _i3.WishlistWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistOrderByWithRelationInput>,
            _i3.WishlistOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistScalar, Iterable<_i3.WishlistScalar>>? distinct,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist?>(
      action: 'findFirstWishlist',
      result: result,
      factory: (e) => e != null ? _i2.Wishlist.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Wishlist> findFirstOrThrow({
    _i3.WishlistWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistOrderByWithRelationInput>,
            _i3.WishlistOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistScalar, Iterable<_i3.WishlistScalar>>? distinct,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist>(
      action: 'findFirstWishlistOrThrow',
      result: result,
      factory: (e) => _i2.Wishlist.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Wishlist>> findMany({
    _i3.WishlistWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistOrderByWithRelationInput>,
            _i3.WishlistOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistScalar, Iterable<_i3.WishlistScalar>>? distinct,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Wishlist>>(
      action: 'findManyWishlist',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Wishlist.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Wishlist> create({
    required _i1
        .PrismaUnion<_i3.WishlistCreateInput, _i3.WishlistUncheckedCreateInput>
        data,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist>(
      action: 'createOneWishlist',
      result: result,
      factory: (e) => _i2.Wishlist.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.WishlistCreateManyInput,
              Iterable<_i3.WishlistCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyWishlist',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyWishlistAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.WishlistCreateManyInput,
            Iterable<_i3.WishlistCreateManyInput>>
        data,
    _i3.CreateManyWishlistAndReturnOutputTypeSelect? select,
    _i3.CreateManyWishlistAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyWishlistAndReturnOutputType>>(
      action: 'createManyWishlistAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyWishlistAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Wishlist?> update({
    required _i1
        .PrismaUnion<_i3.WishlistUpdateInput, _i3.WishlistUncheckedUpdateInput>
        data,
    required _i3.WishlistWhereUniqueInput where,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist?>(
      action: 'updateOneWishlist',
      result: result,
      factory: (e) => e != null ? _i2.Wishlist.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.WishlistUpdateManyMutationInput,
            _i3.WishlistUncheckedUpdateManyInput>
        data,
    _i3.WishlistWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyWishlist',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyWishlistAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.WishlistUpdateManyMutationInput,
            _i3.WishlistUncheckedUpdateManyInput>
        data,
    _i3.WishlistWhereInput? where,
    int? limit,
    _i3.UpdateManyWishlistAndReturnOutputTypeSelect? select,
    _i3.UpdateManyWishlistAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyWishlistAndReturnOutputType>>(
      action: 'updateManyWishlistAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyWishlistAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Wishlist> upsert({
    required _i3.WishlistWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.WishlistCreateInput, _i3.WishlistUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.WishlistUpdateInput, _i3.WishlistUncheckedUpdateInput>
        update,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist>(
      action: 'upsertOneWishlist',
      result: result,
      factory: (e) => _i2.Wishlist.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Wishlist?> delete({
    required _i3.WishlistWhereUniqueInput where,
    _i3.WishlistSelect? select,
    _i3.WishlistInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Wishlist?>(
      action: 'deleteOneWishlist',
      result: result,
      factory: (e) => e != null ? _i2.Wishlist.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.WishlistWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyWishlist',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.WishlistGroupByOutputType>> groupBy({
    _i3.WishlistWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistOrderByWithAggregationInput>,
            _i3.WishlistOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.WishlistScalar>, _i3.WishlistScalar>
        by,
    _i3.WishlistScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.WishlistGroupByOutputTypeSelect? select,
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
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.WishlistGroupByOutputType>>(
      action: 'groupByWishlist',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.WishlistGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateWishlist> aggregate({
    _i3.WishlistWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistOrderByWithRelationInput>,
            _i3.WishlistOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateWishlistSelect? select,
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
      modelName: 'Wishlist',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateWishlist>(
      action: 'aggregateWishlist',
      result: result,
      factory: (e) => _i3.AggregateWishlist.fromJson(e),
    );
  }
}

class WishlistItemDelegate {
  const WishlistItemDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.WishlistItem?> findUnique({
    required _i3.WishlistItemWhereUniqueInput where,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem?>(
      action: 'findUniqueWishlistItem',
      result: result,
      factory: (e) => e != null ? _i2.WishlistItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.WishlistItem> findUniqueOrThrow({
    required _i3.WishlistItemWhereUniqueInput where,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem>(
      action: 'findUniqueWishlistItemOrThrow',
      result: result,
      factory: (e) => _i2.WishlistItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.WishlistItem?> findFirst({
    _i3.WishlistItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistItemOrderByWithRelationInput>,
            _i3.WishlistItemOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistItemScalar, Iterable<_i3.WishlistItemScalar>>?
        distinct,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem?>(
      action: 'findFirstWishlistItem',
      result: result,
      factory: (e) => e != null ? _i2.WishlistItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.WishlistItem> findFirstOrThrow({
    _i3.WishlistItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistItemOrderByWithRelationInput>,
            _i3.WishlistItemOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistItemScalar, Iterable<_i3.WishlistItemScalar>>?
        distinct,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem>(
      action: 'findFirstWishlistItemOrThrow',
      result: result,
      factory: (e) => _i2.WishlistItem.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.WishlistItem>> findMany({
    _i3.WishlistItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistItemOrderByWithRelationInput>,
            _i3.WishlistItemOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.WishlistItemScalar, Iterable<_i3.WishlistItemScalar>>?
        distinct,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.WishlistItem>>(
      action: 'findManyWishlistItem',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.WishlistItem.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.WishlistItem> create({
    required _i1.PrismaUnion<_i3.WishlistItemCreateInput,
            _i3.WishlistItemUncheckedCreateInput>
        data,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem>(
      action: 'createOneWishlistItem',
      result: result,
      factory: (e) => _i2.WishlistItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.WishlistItemCreateManyInput,
              Iterable<_i3.WishlistItemCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyWishlistItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyWishlistItemAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.WishlistItemCreateManyInput,
            Iterable<_i3.WishlistItemCreateManyInput>>
        data,
    _i3.CreateManyWishlistItemAndReturnOutputTypeSelect? select,
    _i3.CreateManyWishlistItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyWishlistItemAndReturnOutputType>>(
      action: 'createManyWishlistItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.CreateManyWishlistItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.WishlistItem?> update({
    required _i1.PrismaUnion<_i3.WishlistItemUpdateInput,
            _i3.WishlistItemUncheckedUpdateInput>
        data,
    required _i3.WishlistItemWhereUniqueInput where,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem?>(
      action: 'updateOneWishlistItem',
      result: result,
      factory: (e) => e != null ? _i2.WishlistItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.WishlistItemUpdateManyMutationInput,
            _i3.WishlistItemUncheckedUpdateManyInput>
        data,
    _i3.WishlistItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyWishlistItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyWishlistItemAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.WishlistItemUpdateManyMutationInput,
            _i3.WishlistItemUncheckedUpdateManyInput>
        data,
    _i3.WishlistItemWhereInput? where,
    int? limit,
    _i3.UpdateManyWishlistItemAndReturnOutputTypeSelect? select,
    _i3.UpdateManyWishlistItemAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyWishlistItemAndReturnOutputType>>(
      action: 'updateManyWishlistItemAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.UpdateManyWishlistItemAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.WishlistItem> upsert({
    required _i3.WishlistItemWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.WishlistItemCreateInput,
            _i3.WishlistItemUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.WishlistItemUpdateInput,
            _i3.WishlistItemUncheckedUpdateInput>
        update,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem>(
      action: 'upsertOneWishlistItem',
      result: result,
      factory: (e) => _i2.WishlistItem.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.WishlistItem?> delete({
    required _i3.WishlistItemWhereUniqueInput where,
    _i3.WishlistItemSelect? select,
    _i3.WishlistItemInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.WishlistItem?>(
      action: 'deleteOneWishlistItem',
      result: result,
      factory: (e) => e != null ? _i2.WishlistItem.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.WishlistItemWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyWishlistItem',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.WishlistItemGroupByOutputType>> groupBy({
    _i3.WishlistItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistItemOrderByWithAggregationInput>,
            _i3.WishlistItemOrderByWithAggregationInput>?
        orderBy,
    required _i1
        .PrismaUnion<Iterable<_i3.WishlistItemScalar>, _i3.WishlistItemScalar>
        by,
    _i3.WishlistItemScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.WishlistItemGroupByOutputTypeSelect? select,
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
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.WishlistItemGroupByOutputType>>(
      action: 'groupByWishlistItem',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.WishlistItemGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateWishlistItem> aggregate({
    _i3.WishlistItemWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.WishlistItemOrderByWithRelationInput>,
            _i3.WishlistItemOrderByWithRelationInput>?
        orderBy,
    _i3.WishlistItemWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateWishlistItemSelect? select,
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
      modelName: 'WishlistItem',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateWishlistItem>(
      action: 'aggregateWishlistItem',
      result: result,
      factory: (e) => _i3.AggregateWishlistItem.fromJson(e),
    );
  }
}

class DiscountDelegate {
  const DiscountDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.Discount?> findUnique({
    required _i3.DiscountWhereUniqueInput where,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount?>(
      action: 'findUniqueDiscount',
      result: result,
      factory: (e) => e != null ? _i2.Discount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Discount> findUniqueOrThrow({
    required _i3.DiscountWhereUniqueInput where,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount>(
      action: 'findUniqueDiscountOrThrow',
      result: result,
      factory: (e) => _i2.Discount.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Discount?> findFirst({
    _i3.DiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DiscountOrderByWithRelationInput>,
            _i3.DiscountOrderByWithRelationInput>?
        orderBy,
    _i3.DiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DiscountScalar, Iterable<_i3.DiscountScalar>>? distinct,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount?>(
      action: 'findFirstDiscount',
      result: result,
      factory: (e) => e != null ? _i2.Discount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.Discount> findFirstOrThrow({
    _i3.DiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DiscountOrderByWithRelationInput>,
            _i3.DiscountOrderByWithRelationInput>?
        orderBy,
    _i3.DiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DiscountScalar, Iterable<_i3.DiscountScalar>>? distinct,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount>(
      action: 'findFirstDiscountOrThrow',
      result: result,
      factory: (e) => _i2.Discount.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.Discount>> findMany({
    _i3.DiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DiscountOrderByWithRelationInput>,
            _i3.DiscountOrderByWithRelationInput>?
        orderBy,
    _i3.DiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.DiscountScalar, Iterable<_i3.DiscountScalar>>? distinct,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.Discount>>(
      action: 'findManyDiscount',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.Discount.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Discount> create({
    required _i1
        .PrismaUnion<_i3.DiscountCreateInput, _i3.DiscountUncheckedCreateInput>
        data,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount>(
      action: 'createOneDiscount',
      result: result,
      factory: (e) => _i2.Discount.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.DiscountCreateManyInput,
              Iterable<_i3.DiscountCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyDiscountAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.DiscountCreateManyInput,
            Iterable<_i3.DiscountCreateManyInput>>
        data,
    _i3.CreateManyDiscountAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyDiscountAndReturnOutputType>>(
      action: 'createManyDiscountAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.CreateManyDiscountAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Discount?> update({
    required _i1
        .PrismaUnion<_i3.DiscountUpdateInput, _i3.DiscountUncheckedUpdateInput>
        data,
    required _i3.DiscountWhereUniqueInput where,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount?>(
      action: 'updateOneDiscount',
      result: result,
      factory: (e) => e != null ? _i2.Discount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.DiscountUpdateManyMutationInput,
            _i3.DiscountUncheckedUpdateManyInput>
        data,
    _i3.DiscountWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyDiscountAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.DiscountUpdateManyMutationInput,
            _i3.DiscountUncheckedUpdateManyInput>
        data,
    _i3.DiscountWhereInput? where,
    int? limit,
    _i3.UpdateManyDiscountAndReturnOutputTypeSelect? select,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyDiscountAndReturnOutputType>>(
      action: 'updateManyDiscountAndReturn',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i2.UpdateManyDiscountAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.Discount> upsert({
    required _i3.DiscountWhereUniqueInput where,
    required _i1
        .PrismaUnion<_i3.DiscountCreateInput, _i3.DiscountUncheckedCreateInput>
        create,
    required _i1
        .PrismaUnion<_i3.DiscountUpdateInput, _i3.DiscountUncheckedUpdateInput>
        update,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount>(
      action: 'upsertOneDiscount',
      result: result,
      factory: (e) => _i2.Discount.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.Discount?> delete({
    required _i3.DiscountWhereUniqueInput where,
    _i3.DiscountSelect? select,
    _i3.DiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.Discount?>(
      action: 'deleteOneDiscount',
      result: result,
      factory: (e) => e != null ? _i2.Discount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.DiscountWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'Discount',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.DiscountGroupByOutputType>> groupBy({
    _i3.DiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DiscountOrderByWithAggregationInput>,
            _i3.DiscountOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.DiscountScalar>, _i3.DiscountScalar>
        by,
    _i3.DiscountScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.DiscountGroupByOutputTypeSelect? select,
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
      modelName: 'Discount',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.DiscountGroupByOutputType>>(
      action: 'groupByDiscount',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.DiscountGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateDiscount> aggregate({
    _i3.DiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.DiscountOrderByWithRelationInput>,
            _i3.DiscountOrderByWithRelationInput>?
        orderBy,
    _i3.DiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateDiscountSelect? select,
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
      modelName: 'Discount',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateDiscount>(
      action: 'aggregateDiscount',
      result: result,
      factory: (e) => _i3.AggregateDiscount.fromJson(e),
    );
  }
}

class ProductDiscountDelegate {
  const ProductDiscountDelegate._(this._client);

  final PrismaClient _client;

  _i1.ActionClient<_i2.ProductDiscount?> findUnique({
    required _i3.ProductDiscountWhereUniqueInput where,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.findUnique,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount?>(
      action: 'findUniqueProductDiscount',
      result: result,
      factory: (e) => e != null ? _i2.ProductDiscount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductDiscount> findUniqueOrThrow({
    required _i3.ProductDiscountWhereUniqueInput where,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.findUniqueOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount>(
      action: 'findUniqueProductDiscountOrThrow',
      result: result,
      factory: (e) => _i2.ProductDiscount.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductDiscount?> findFirst({
    _i3.ProductDiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductDiscountOrderByWithRelationInput>,
            _i3.ProductDiscountOrderByWithRelationInput>?
        orderBy,
    _i3.ProductDiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductDiscountScalar,
            Iterable<_i3.ProductDiscountScalar>>?
        distinct,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.findFirst,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount?>(
      action: 'findFirstProductDiscount',
      result: result,
      factory: (e) => e != null ? _i2.ProductDiscount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i2.ProductDiscount> findFirstOrThrow({
    _i3.ProductDiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductDiscountOrderByWithRelationInput>,
            _i3.ProductDiscountOrderByWithRelationInput>?
        orderBy,
    _i3.ProductDiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductDiscountScalar,
            Iterable<_i3.ProductDiscountScalar>>?
        distinct,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.findFirstOrThrow,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount>(
      action: 'findFirstProductDiscountOrThrow',
      result: result,
      factory: (e) => _i2.ProductDiscount.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.ProductDiscount>> findMany({
    _i3.ProductDiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductDiscountOrderByWithRelationInput>,
            _i3.ProductDiscountOrderByWithRelationInput>?
        orderBy,
    _i3.ProductDiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i1.PrismaUnion<_i3.ProductDiscountScalar,
            Iterable<_i3.ProductDiscountScalar>>?
        distinct,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'orderBy': orderBy,
      'cursor': cursor,
      'take': take,
      'skip': skip,
      'distinct': distinct,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.findMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i2.ProductDiscount>>(
      action: 'findManyProductDiscount',
      result: result,
      factory: (values) =>
          (values as Iterable).map((e) => _i2.ProductDiscount.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductDiscount> create({
    required _i1.PrismaUnion<_i3.ProductDiscountCreateInput,
            _i3.ProductDiscountUncheckedCreateInput>
        data,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.createOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount>(
      action: 'createOneProductDiscount',
      result: result,
      factory: (e) => _i2.ProductDiscount.fromJson(e),
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> createMany(
      {required _i1.PrismaUnion<_i3.ProductDiscountCreateManyInput,
              Iterable<_i3.ProductDiscountCreateManyInput>>
          data}) {
    final args = {'data': data};
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.createMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'createManyProductDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.CreateManyProductDiscountAndReturnOutputType>>
      createManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductDiscountCreateManyInput,
            Iterable<_i3.ProductDiscountCreateManyInput>>
        data,
    _i3.CreateManyProductDiscountAndReturnOutputTypeSelect? select,
    _i3.CreateManyProductDiscountAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.createManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.CreateManyProductDiscountAndReturnOutputType>>(
      action: 'createManyProductDiscountAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.CreateManyProductDiscountAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductDiscount?> update({
    required _i1.PrismaUnion<_i3.ProductDiscountUpdateInput,
            _i3.ProductDiscountUncheckedUpdateInput>
        data,
    required _i3.ProductDiscountWhereUniqueInput where,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.updateOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount?>(
      action: 'updateOneProductDiscount',
      result: result,
      factory: (e) => e != null ? _i2.ProductDiscount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> updateMany({
    required _i1.PrismaUnion<_i3.ProductDiscountUpdateManyMutationInput,
            _i3.ProductDiscountUncheckedUpdateManyInput>
        data,
    _i3.ProductDiscountWhereInput? where,
    int? limit,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.updateMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'updateManyProductDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i2.UpdateManyProductDiscountAndReturnOutputType>>
      updateManyAndReturn({
    required _i1.PrismaUnion<_i3.ProductDiscountUpdateManyMutationInput,
            _i3.ProductDiscountUncheckedUpdateManyInput>
        data,
    _i3.ProductDiscountWhereInput? where,
    int? limit,
    _i3.UpdateManyProductDiscountAndReturnOutputTypeSelect? select,
    _i3.UpdateManyProductDiscountAndReturnOutputTypeInclude? include,
  }) {
    final args = {
      'data': data,
      'where': where,
      'limit': limit,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.updateManyAndReturn,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<
        Iterable<_i2.UpdateManyProductDiscountAndReturnOutputType>>(
      action: 'updateManyProductDiscountAndReturn',
      result: result,
      factory: (values) => (values as Iterable).map(
          (e) => _i2.UpdateManyProductDiscountAndReturnOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i2.ProductDiscount> upsert({
    required _i3.ProductDiscountWhereUniqueInput where,
    required _i1.PrismaUnion<_i3.ProductDiscountCreateInput,
            _i3.ProductDiscountUncheckedCreateInput>
        create,
    required _i1.PrismaUnion<_i3.ProductDiscountUpdateInput,
            _i3.ProductDiscountUncheckedUpdateInput>
        update,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'create': create,
      'update': update,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.upsertOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount>(
      action: 'upsertOneProductDiscount',
      result: result,
      factory: (e) => _i2.ProductDiscount.fromJson(e),
    );
  }

  _i1.ActionClient<_i2.ProductDiscount?> delete({
    required _i3.ProductDiscountWhereUniqueInput where,
    _i3.ProductDiscountSelect? select,
    _i3.ProductDiscountInclude? include,
  }) {
    final args = {
      'where': where,
      'select': select,
      'include': include,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.deleteOne,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i2.ProductDiscount?>(
      action: 'deleteOneProductDiscount',
      result: result,
      factory: (e) => e != null ? _i2.ProductDiscount.fromJson(e) : null,
    );
  }

  _i1.ActionClient<_i3.AffectedRowsOutput> deleteMany({
    _i3.ProductDiscountWhereInput? where,
    int? limit,
  }) {
    final args = {
      'where': where,
      'limit': limit,
    };
    final query = _i1.serializeJsonQuery(
      args: args,
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.deleteMany,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AffectedRowsOutput>(
      action: 'deleteManyProductDiscount',
      result: result,
      factory: (e) => _i3.AffectedRowsOutput.fromJson(e),
    );
  }

  _i1.ActionClient<Iterable<_i3.ProductDiscountGroupByOutputType>> groupBy({
    _i3.ProductDiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductDiscountOrderByWithAggregationInput>,
            _i3.ProductDiscountOrderByWithAggregationInput>?
        orderBy,
    required _i1.PrismaUnion<Iterable<_i3.ProductDiscountScalar>,
            _i3.ProductDiscountScalar>
        by,
    _i3.ProductDiscountScalarWhereWithAggregatesInput? having,
    int? take,
    int? skip,
    _i3.ProductDiscountGroupByOutputTypeSelect? select,
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
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.groupBy,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<Iterable<_i3.ProductDiscountGroupByOutputType>>(
      action: 'groupByProductDiscount',
      result: result,
      factory: (values) => (values as Iterable)
          .map((e) => _i3.ProductDiscountGroupByOutputType.fromJson(e)),
    );
  }

  _i1.ActionClient<_i3.AggregateProductDiscount> aggregate({
    _i3.ProductDiscountWhereInput? where,
    _i1.PrismaUnion<Iterable<_i3.ProductDiscountOrderByWithRelationInput>,
            _i3.ProductDiscountOrderByWithRelationInput>?
        orderBy,
    _i3.ProductDiscountWhereUniqueInput? cursor,
    int? take,
    int? skip,
    _i3.AggregateProductDiscountSelect? select,
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
      modelName: 'ProductDiscount',
      action: _i1.JsonQueryAction.aggregate,
      datamodel: PrismaClient.datamodel,
    );
    final result = _client.$engine.request(
      query,
      headers: _client.$transaction.headers,
      transaction: _client.$transaction.transaction,
    );
    return _i1.ActionClient<_i3.AggregateProductDiscount>(
      action: 'aggregateProductDiscount',
      result: result,
      factory: (e) => _i3.AggregateProductDiscount.fromJson(e),
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
        'name': 'User',
        'dbName': 'users',
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
            'name': 'phone',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'isUpdatedAt': true,
          },
          {
            'name': 'addresses',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Address',
            'nativeType': null,
            'relationName': 'AddressToUser',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'carts',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Cart',
            'nativeType': null,
            'relationName': 'CartToUser',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'orders',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Order',
            'nativeType': null,
            'relationName': 'OrderToUser',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'reviews',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Review',
            'nativeType': null,
            'relationName': 'ReviewToUser',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'wishlists',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Wishlist',
            'nativeType': null,
            'relationName': 'UserToWishlist',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Address',
        'dbName': 'addresses',
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
            'name': 'userId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'addressLine1',
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
            'name': 'addressLine2',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'city',
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
            'name': 'state',
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
            'name': 'postalCode',
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
            'name': 'country',
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
            'name': 'isDefault',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'nativeType': null,
            'default': false,
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
            'isUpdatedAt': true,
          },
          {
            'name': 'user',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'User',
            'nativeType': null,
            'relationName': 'AddressToUser',
            'relationFromFields': ['userId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'shippingOrders',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Order',
            'nativeType': null,
            'relationName': 'ShippingAddress',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'billingOrders',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Order',
            'nativeType': null,
            'relationName': 'BillingAddress',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Category',
        'dbName': 'categories',
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
            'name': 'name',
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
            'name': 'description',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'parentCategoryId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
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
            'isUpdatedAt': true,
          },
          {
            'name': 'parentCategory',
            'kind': 'object',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Category',
            'nativeType': null,
            'relationName': 'CategorySubcategories',
            'relationFromFields': ['parentCategoryId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'SetNull',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'subcategories',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Category',
            'nativeType': null,
            'relationName': 'CategorySubcategories',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'products',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ProductCategory',
            'nativeType': null,
            'relationName': 'CategoryToProductCategory',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Product',
        'dbName': 'products',
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
            'name': 'name',
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
            'name': 'description',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'price',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'stockQuantity',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Int',
            'nativeType': null,
            'default': 0,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'sku',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'isActive',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'nativeType': null,
            'default': true,
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
            'isUpdatedAt': true,
          },
          {
            'name': 'categories',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ProductCategory',
            'nativeType': null,
            'relationName': 'ProductToProductCategory',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'images',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ProductImage',
            'nativeType': null,
            'relationName': 'ProductToProductImage',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'cartItems',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'CartItem',
            'nativeType': null,
            'relationName': 'CartItemToProduct',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'orderItems',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'OrderItem',
            'nativeType': null,
            'relationName': 'OrderItemToProduct',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'reviews',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Review',
            'nativeType': null,
            'relationName': 'ProductToReview',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'wishlistItems',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'WishlistItem',
            'nativeType': null,
            'relationName': 'ProductToWishlistItem',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'discounts',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ProductDiscount',
            'nativeType': null,
            'relationName': 'ProductToProductDiscount',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ProductCategory',
        'dbName': 'product_categories',
        'schema': null,
        'fields': [
          {
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'categoryId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'ProductToProductCategory',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'category',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Category',
            'nativeType': null,
            'relationName': 'CategoryToProductCategory',
            'relationFromFields': ['categoryId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': {
          'name': null,
          'fields': [
            'productId',
            'categoryId',
          ],
        },
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ProductImage',
        'dbName': 'product_images',
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
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'imageUrl',
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
            'name': 'isPrimary',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'nativeType': null,
            'default': false,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'displayOrder',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Int',
            'nativeType': null,
            'default': 0,
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
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'ProductToProductImage',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Cart',
        'dbName': 'carts',
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
            'name': 'userId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
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
            'isUpdatedAt': true,
          },
          {
            'name': 'user',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'User',
            'nativeType': null,
            'relationName': 'CartToUser',
            'relationFromFields': ['userId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'items',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'CartItem',
            'nativeType': null,
            'relationName': 'CartToCartItem',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'CartItem',
        'dbName': 'cart_items',
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
            'name': 'cartId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'quantity',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Int',
            'nativeType': null,
            'default': 1,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'priceAtAddition',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'addedAt',
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
            'name': 'cart',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Cart',
            'nativeType': null,
            'relationName': 'CartToCartItem',
            'relationFromFields': ['cartId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'CartItemToProduct',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Order',
        'dbName': 'orders',
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
            'name': 'userId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'shippingAddressId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'billingAddressId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'subtotal',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'tax',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'shippingCost',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'totalAmount',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'status',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'nativeType': null,
            'default': 'pending',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'paymentStatus',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'nativeType': null,
            'default': 'pending',
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
            'isUpdatedAt': true,
          },
          {
            'name': 'user',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'User',
            'nativeType': null,
            'relationName': 'OrderToUser',
            'relationFromFields': ['userId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'shippingAddress',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Address',
            'nativeType': null,
            'relationName': 'ShippingAddress',
            'relationFromFields': ['shippingAddressId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'billingAddress',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Address',
            'nativeType': null,
            'relationName': 'BillingAddress',
            'relationFromFields': ['billingAddressId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'items',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'OrderItem',
            'nativeType': null,
            'relationName': 'OrderToOrderItem',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'payments',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Payment',
            'nativeType': null,
            'relationName': 'OrderToPayment',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'OrderItem',
        'dbName': 'order_items',
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
            'name': 'orderId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'quantity',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'priceAtPurchase',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'subtotal',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
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
            'name': 'order',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Order',
            'nativeType': null,
            'relationName': 'OrderToOrderItem',
            'relationFromFields': ['orderId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'OrderItemToProduct',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Payment',
        'dbName': 'payments',
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
            'name': 'orderId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'paymentMethod',
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
            'name': 'transactionId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'amount',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'status',
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
            'name': 'paymentDate',
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
            'name': 'order',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Order',
            'nativeType': null,
            'relationName': 'OrderToPayment',
            'relationFromFields': ['orderId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Review',
        'dbName': 'reviews',
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
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'userId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'rating',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'comment',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'isUpdatedAt': true,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'ProductToReview',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'user',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'User',
            'nativeType': null,
            'relationName': 'ReviewToUser',
            'relationFromFields': ['userId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Wishlist',
        'dbName': 'wishlists',
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
            'name': 'userId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'name',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'String',
            'nativeType': null,
            'default': 'My Wishlist',
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
            'isUpdatedAt': true,
          },
          {
            'name': 'user',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'User',
            'nativeType': null,
            'relationName': 'UserToWishlist',
            'relationFromFields': ['userId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'items',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'WishlistItem',
            'nativeType': null,
            'relationName': 'WishlistToWishlistItem',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'WishlistItem',
        'dbName': 'wishlist_items',
        'schema': null,
        'fields': [
          {
            'name': 'wishlistId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'addedAt',
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
            'name': 'wishlist',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Wishlist',
            'nativeType': null,
            'relationName': 'WishlistToWishlistItem',
            'relationFromFields': ['wishlistId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'ProductToWishlistItem',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': {
          'name': null,
          'fields': [
            'wishlistId',
            'productId',
          ],
        },
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'Discount',
        'dbName': 'discounts',
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
            'name': 'code',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'description',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
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
            'name': 'amount',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Decimal',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'discountType',
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
            'name': 'usageLimit',
            'kind': 'scalar',
            'isList': false,
            'isRequired': false,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'timesUsed',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Int',
            'nativeType': null,
            'default': 0,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'validFrom',
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
          {
            'name': 'validTo',
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
          {
            'name': 'isActive',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': true,
            'type': 'Boolean',
            'nativeType': null,
            'default': true,
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
            'isUpdatedAt': true,
          },
          {
            'name': 'products',
            'kind': 'object',
            'isList': true,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'ProductDiscount',
            'nativeType': null,
            'relationName': 'DiscountToProductDiscount',
            'relationFromFields': [],
            'relationToFields': [],
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': null,
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
      {
        'name': 'ProductDiscount',
        'dbName': 'product_discounts',
        'schema': null,
        'fields': [
          {
            'name': 'productId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'discountId',
            'kind': 'scalar',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': true,
            'hasDefaultValue': false,
            'type': 'Int',
            'nativeType': null,
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'product',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Product',
            'nativeType': null,
            'relationName': 'ProductToProductDiscount',
            'relationFromFields': ['productId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
          {
            'name': 'discount',
            'kind': 'object',
            'isList': false,
            'isRequired': true,
            'isUnique': false,
            'isId': false,
            'isReadOnly': false,
            'hasDefaultValue': false,
            'type': 'Discount',
            'nativeType': null,
            'relationName': 'DiscountToProductDiscount',
            'relationFromFields': ['discountId'],
            'relationToFields': ['id'],
            'relationOnDelete': 'Cascade',
            'isGenerated': false,
            'isUpdatedAt': false,
          },
        ],
        'primaryKey': {
          'name': null,
          'fields': [
            'productId',
            'discountId',
          ],
        },
        'uniqueFields': [],
        'uniqueIndexes': [],
        'isGenerated': false,
      },
    ],
    'types': [],
    'indexes': [
      {
        'model': 'User',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'User',
        'type': 'unique',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'email'}
        ],
      },
      {
        'model': 'Address',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Category',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Product',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Product',
        'type': 'unique',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'sku'}
        ],
      },
      {
        'model': 'Product',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'name'}
        ],
      },
      {
        'model': 'ProductCategory',
        'type': 'id',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'productId'},
          {'name': 'categoryId'},
        ],
      },
      {
        'model': 'ProductImage',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Cart',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'CartItem',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'CartItem',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'productId'}
        ],
      },
      {
        'model': 'Order',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Order',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'userId'}
        ],
      },
      {
        'model': 'Order',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'status'}
        ],
      },
      {
        'model': 'OrderItem',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'OrderItem',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'productId'}
        ],
      },
      {
        'model': 'Payment',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Review',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Review',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'productId'}
        ],
      },
      {
        'model': 'Wishlist',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'WishlistItem',
        'type': 'id',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'wishlistId'},
          {'name': 'productId'},
        ],
      },
      {
        'model': 'Discount',
        'type': 'id',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'id'}
        ],
      },
      {
        'model': 'Discount',
        'type': 'unique',
        'isDefinedOnField': true,
        'fields': [
          {'name': 'code'}
        ],
      },
      {
        'model': 'Discount',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'code'}
        ],
      },
      {
        'model': 'Discount',
        'type': 'normal',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'validFrom'},
          {'name': 'validTo'},
          {'name': 'isActive'},
        ],
      },
      {
        'model': 'ProductDiscount',
        'type': 'id',
        'isDefinedOnField': false,
        'fields': [
          {'name': 'productId'},
          {'name': 'discountId'},
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
            '// This is your Prisma schema file,\n// learn more about it in the docs: https://pris.ly/d/prisma-schema\n\ngenerator client {\n  provider = "prisma-client-dart"\n  // output   = "../lib/gen/prisma"\n}\n\ndatasource db {\n  provider  = "sqlite"\n  url       = env("DATABASE_URL")\n  directUrl = env("DIRECT_DATABASE_URL")\n}\n\nmodel User {\n  id        Int      @id @default(autoincrement())\n  email     String   @unique\n  password  String\n  firstName String\n  lastName  String\n  phone     String?\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n\n  // Relations\n  addresses Address[]\n  carts     Cart[]\n  orders    Order[]\n  reviews   Review[]\n  wishlists Wishlist[]\n\n  @@map("users")\n}\n\nmodel Address {\n  id           Int      @id @default(autoincrement())\n  userId       Int\n  addressLine1 String\n  addressLine2 String?\n  city         String\n  state        String\n  postalCode   String\n  country      String\n  isDefault    Boolean  @default(false)\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  // Relations\n  user           User    @relation(fields: [userId], references: [id], onDelete: Cascade)\n  shippingOrders Order[] @relation("ShippingAddress")\n  billingOrders  Order[] @relation("BillingAddress")\n\n  @@map("addresses")\n}\n\nmodel Category {\n  id               Int      @id @default(autoincrement())\n  name             String\n  description      String?\n  parentCategoryId Int?\n  createdAt        DateTime @default(now())\n  updatedAt        DateTime @updatedAt\n\n  // Relations\n  parentCategory Category?         @relation("CategorySubcategories", fields: [parentCategoryId], references: [id], onDelete: SetNull)\n  subcategories  Category[]        @relation("CategorySubcategories")\n  products       ProductCategory[]\n\n  @@map("categories")\n}\n\nmodel Product {\n  id            Int      @id @default(autoincrement())\n  name          String\n  description   String?\n  price         Decimal\n  stockQuantity Int      @default(0)\n  sku           String?  @unique\n  isActive      Boolean  @default(true)\n  createdAt     DateTime @default(now())\n  updatedAt     DateTime @updatedAt\n\n  // Relations\n  categories    ProductCategory[]\n  images        ProductImage[]\n  cartItems     CartItem[]\n  orderItems    OrderItem[]\n  reviews       Review[]\n  wishlistItems WishlistItem[]\n  discounts     ProductDiscount[]\n\n  @@index([name])\n  @@map("products")\n}\n\nmodel ProductCategory {\n  productId  Int\n  categoryId Int\n\n  // Relations\n  product  Product  @relation(fields: [productId], references: [id], onDelete: Cascade)\n  category Category @relation(fields: [categoryId], references: [id], onDelete: Cascade)\n\n  @@id([productId, categoryId])\n  @@map("product_categories")\n}\n\nmodel ProductImage {\n  id           Int      @id @default(autoincrement())\n  productId    Int\n  imageUrl     String\n  isPrimary    Boolean  @default(false)\n  displayOrder Int      @default(0)\n  createdAt    DateTime @default(now())\n\n  // Relations\n  product Product @relation(fields: [productId], references: [id], onDelete: Cascade)\n\n  @@map("product_images")\n}\n\nmodel Cart {\n  id        Int      @id @default(autoincrement())\n  userId    Int\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n\n  // Relations\n  user  User       @relation(fields: [userId], references: [id], onDelete: Cascade)\n  items CartItem[]\n\n  @@map("carts")\n}\n\nmodel CartItem {\n  id              Int      @id @default(autoincrement())\n  cartId          Int\n  productId       Int\n  quantity        Int      @default(1)\n  priceAtAddition Decimal\n  addedAt         DateTime @default(now())\n\n  // Relations\n  cart    Cart    @relation(fields: [cartId], references: [id], onDelete: Cascade)\n  product Product @relation(fields: [productId], references: [id], onDelete: Cascade)\n\n  @@index([productId])\n  @@map("cart_items")\n}\n\nmodel Order {\n  id                Int      @id @default(autoincrement())\n  userId            Int\n  shippingAddressId Int\n  billingAddressId  Int\n  subtotal          Decimal\n  tax               Decimal\n  shippingCost      Decimal\n  totalAmount       Decimal\n  status            String   @default("pending")\n  paymentStatus     String   @default("pending")\n  createdAt         DateTime @default(now())\n  updatedAt         DateTime @updatedAt\n\n  // Relations\n  user            User        @relation(fields: [userId], references: [id])\n  shippingAddress Address     @relation("ShippingAddress", fields: [shippingAddressId], references: [id])\n  billingAddress  Address     @relation("BillingAddress", fields: [billingAddressId], references: [id])\n  items           OrderItem[]\n  payments        Payment[]\n\n  @@index([userId])\n  @@index([status])\n  @@map("orders")\n}\n\nmodel OrderItem {\n  id              Int      @id @default(autoincrement())\n  orderId         Int\n  productId       Int\n  quantity        Int\n  priceAtPurchase Decimal\n  subtotal        Decimal\n  createdAt       DateTime @default(now())\n\n  // Relations\n  order   Order   @relation(fields: [orderId], references: [id], onDelete: Cascade)\n  product Product @relation(fields: [productId], references: [id])\n\n  @@index([productId])\n  @@map("order_items")\n}\n\nmodel Payment {\n  id            Int      @id @default(autoincrement())\n  orderId       Int\n  paymentMethod String\n  transactionId String?\n  amount        Decimal\n  status        String\n  paymentDate   DateTime @default(now())\n\n  // Relations\n  order Order @relation(fields: [orderId], references: [id], onDelete: Cascade)\n\n  @@map("payments")\n}\n\nmodel Review {\n  id        Int      @id @default(autoincrement())\n  productId Int\n  userId    Int\n  rating    Int\n  comment   String?\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n\n  // Relations\n  product Product @relation(fields: [productId], references: [id], onDelete: Cascade)\n  user    User    @relation(fields: [userId], references: [id], onDelete: Cascade)\n\n  @@index([productId])\n  @@map("reviews")\n}\n\nmodel Wishlist {\n  id        Int      @id @default(autoincrement())\n  userId    Int\n  name      String   @default("My Wishlist")\n  createdAt DateTime @default(now())\n  updatedAt DateTime @updatedAt\n\n  // Relations\n  user  User           @relation(fields: [userId], references: [id], onDelete: Cascade)\n  items WishlistItem[]\n\n  @@map("wishlists")\n}\n\nmodel WishlistItem {\n  wishlistId Int\n  productId  Int\n  addedAt    DateTime @default(now())\n\n  // Relations\n  wishlist Wishlist @relation(fields: [wishlistId], references: [id], onDelete: Cascade)\n  product  Product  @relation(fields: [productId], references: [id], onDelete: Cascade)\n\n  @@id([wishlistId, productId])\n  @@map("wishlist_items")\n}\n\nmodel Discount {\n  id           Int      @id @default(autoincrement())\n  code         String?  @unique\n  description  String?\n  amount       Decimal\n  discountType String // \'percentage\' or \'fixed_amount\'\n  usageLimit   Int?\n  timesUsed    Int      @default(0)\n  validFrom    DateTime\n  validTo      DateTime\n  isActive     Boolean  @default(true)\n  createdAt    DateTime @default(now())\n  updatedAt    DateTime @updatedAt\n\n  // Relations\n  products ProductDiscount[]\n\n  @@index([code])\n  @@index([validFrom, validTo, isActive])\n  @@map("discounts")\n}\n\nmodel ProductDiscount {\n  productId  Int\n  discountId Int\n\n  // Relations\n  product  Product  @relation(fields: [productId], references: [id], onDelete: Cascade)\n  discount Discount @relation(fields: [discountId], references: [id], onDelete: Cascade)\n\n  @@id([productId, discountId])\n  @@map("product_discounts")\n}\n',
        datasources: const {
          'db': _i1.Datasource(
            _i1.DatasourceType.environment,
            'DATABASE_URL',
          )
        },
        options: $options,
      );

  @override
  get $datamodel => datamodel;

  UserDelegate get user => UserDelegate._(this);

  AddressDelegate get address => AddressDelegate._(this);

  CategoryDelegate get category => CategoryDelegate._(this);

  ProductDelegate get product => ProductDelegate._(this);

  ProductCategoryDelegate get productCategory =>
      ProductCategoryDelegate._(this);

  ProductImageDelegate get productImage => ProductImageDelegate._(this);

  CartDelegate get cart => CartDelegate._(this);

  CartItemDelegate get cartItem => CartItemDelegate._(this);

  OrderDelegate get order => OrderDelegate._(this);

  OrderItemDelegate get orderItem => OrderItemDelegate._(this);

  PaymentDelegate get payment => PaymentDelegate._(this);

  ReviewDelegate get review => ReviewDelegate._(this);

  WishlistDelegate get wishlist => WishlistDelegate._(this);

  WishlistItemDelegate get wishlistItem => WishlistItemDelegate._(this);

  DiscountDelegate get discount => DiscountDelegate._(this);

  ProductDiscountDelegate get productDiscount =>
      ProductDiscountDelegate._(this);
}
