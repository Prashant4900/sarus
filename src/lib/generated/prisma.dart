// ignore_for_file: non_constant_identifier_names

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:orm/orm.dart' as _i1;

import 'prisma.dart' as _i2;

class NestedIntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedIntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<int, _i1.Reference<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lte;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gte;

  final _i1.PrismaUnion<int, _i2.NestedIntFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
      };
}

class IntFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const IntFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<int, _i1.Reference<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lte;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gte;

  final _i1.PrismaUnion<int, _i2.NestedIntFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
      };
}

enum QueryMode implements _i1.PrismaEnum {
  $default._('default'),
  insensitive._('insensitive');

  const QueryMode._(this.name);

  @override
  final String name;
}

class NestedStringFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedStringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
  });

  final _i1.PrismaUnion<String, _i1.Reference<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? contains;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? endsWith;

  final _i1.PrismaUnion<String, _i2.NestedStringFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'contains': contains,
        'startsWith': startsWith,
        'endsWith': endsWith,
        'not': not,
      };
}

class StringFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const StringFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
  });

  final _i1.PrismaUnion<String, _i1.Reference<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? contains;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? endsWith;

  final _i2.QueryMode? mode;

  final _i1.PrismaUnion<String, _i2.NestedStringFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'contains': contains,
        'startsWith': startsWith,
        'endsWith': endsWith,
        'mode': mode,
        'not': not,
      };
}

class NestedBoolFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedBoolFilter({
    this.equals,
    this.not,
  });

  final _i1.PrismaUnion<bool, _i1.Reference<bool>>? equals;

  final _i1.PrismaUnion<bool, _i2.NestedBoolFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'not': not,
      };
}

class BoolFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const BoolFilter({
    this.equals,
    this.not,
  });

  final _i1.PrismaUnion<bool, _i1.Reference<bool>>? equals;

  final _i1.PrismaUnion<bool, _i2.NestedBoolFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'not': not,
      };
}

class NestedDateTimeFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedDateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, _i2.NestedDateTimeFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
      };
}

class DateTimeFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const DateTimeFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, _i2.NestedDateTimeFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
      };
}

class AdminWhereInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminWhereInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<_i2.AdminWhereInput, Iterable<_i2.AdminWhereInput>>?
      AND;

  final Iterable<_i2.AdminWhereInput>? OR;

  final _i1.PrismaUnion<_i2.AdminWhereInput, Iterable<_i2.AdminWhereInput>>?
      NOT;

  final _i1.PrismaUnion<_i2.IntFilter, int>? id;

  final _i1.PrismaUnion<_i2.StringFilter, String>? firstName;

  final _i1.PrismaUnion<_i2.StringFilter, String>? lastName;

  final _i1.PrismaUnion<_i2.StringFilter, String>? email;

  final _i1.PrismaUnion<_i2.StringFilter, String>? password;

  final _i1.PrismaUnion<_i2.BoolFilter, bool>? isActive;

  final _i1.PrismaUnion<_i2.BoolFilter, bool>? isSuperAdmin;

  final _i1.PrismaUnion<_i2.DateTimeFilter, DateTime>? createdAt;

  final _i1.PrismaUnion<_i2.DateTimeFilter, DateTime>? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'AND': AND,
        'OR': OR,
        'NOT': NOT,
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminWhereUniqueInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminWhereUniqueInput({
    this.id,
    this.email,
    this.AND,
    this.OR,
    this.NOT,
    this.firstName,
    this.lastName,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;

  final String? email;

  final _i1.PrismaUnion<_i2.AdminWhereInput, Iterable<_i2.AdminWhereInput>>?
      AND;

  final Iterable<_i2.AdminWhereInput>? OR;

  final _i1.PrismaUnion<_i2.AdminWhereInput, Iterable<_i2.AdminWhereInput>>?
      NOT;

  final _i1.PrismaUnion<_i2.StringFilter, String>? firstName;

  final _i1.PrismaUnion<_i2.StringFilter, String>? lastName;

  final _i1.PrismaUnion<_i2.StringFilter, String>? password;

  final _i1.PrismaUnion<_i2.BoolFilter, bool>? isActive;

  final _i1.PrismaUnion<_i2.BoolFilter, bool>? isSuperAdmin;

  final _i1.PrismaUnion<_i2.DateTimeFilter, DateTime>? createdAt;

  final _i1.PrismaUnion<_i2.DateTimeFilter, DateTime>? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'AND': AND,
        'OR': OR,
        'NOT': NOT,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminSelect implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

enum SortOrder implements _i1.PrismaEnum {
  asc._('asc'),
  desc._('desc');

  const SortOrder._(this.name);

  @override
  final String name;
}

class AdminOrderByWithRelationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminOrderByWithRelationInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i2.SortOrder? id;

  final _i2.SortOrder? firstName;

  final _i2.SortOrder? lastName;

  final _i2.SortOrder? email;

  final _i2.SortOrder? password;

  final _i2.SortOrder? isActive;

  final _i2.SortOrder? isSuperAdmin;

  final _i2.SortOrder? createdAt;

  final _i2.SortOrder? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

enum AdminScalar<T> implements _i1.PrismaEnum, _i1.Reference<T> {
  id<int>('id', 'Admin'),
  firstName<String>('firstName', 'Admin'),
  lastName<String>('lastName', 'Admin'),
  email<String>('email', 'Admin'),
  password<String>('password', 'Admin'),
  isActive<bool>('isActive', 'Admin'),
  isSuperAdmin<bool>('isSuperAdmin', 'Admin'),
  createdAt<DateTime>('createdAt', 'Admin'),
  updatedAt<DateTime>('updatedAt', 'Admin');

  const AdminScalar(
    this.name,
    this.model,
  );

  @override
  final String name;

  @override
  final String model;
}

class AdminCreateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminCreateInput({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isActive,
    required this.isSuperAdmin,
    this.createdAt,
    required this.updatedAt,
  });

  final String firstName;

  final String lastName;

  final String email;

  final String password;

  final bool isActive;

  final bool isSuperAdmin;

  final DateTime? createdAt;

  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminUncheckedCreateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminUncheckedCreateInput({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isActive,
    required this.isSuperAdmin,
    this.createdAt,
    required this.updatedAt,
  });

  final int? id;

  final String firstName;

  final String lastName;

  final String email;

  final String password;

  final bool isActive;

  final bool isSuperAdmin;

  final DateTime? createdAt;

  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AffectedRowsOutput {
  const AffectedRowsOutput({this.count});

  factory AffectedRowsOutput.fromJson(Map json) =>
      AffectedRowsOutput(count: json['count']);

  final int? count;

  Map<String, dynamic> toJson() => {'count': count};
}

class AdminCreateManyInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminCreateManyInput({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isActive,
    required this.isSuperAdmin,
    this.createdAt,
    required this.updatedAt,
  });

  final int? id;

  final String firstName;

  final String lastName;

  final String email;

  final String password;

  final bool isActive;

  final bool isSuperAdmin;

  final DateTime? createdAt;

  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class CreateManyAdminAndReturnOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const CreateManyAdminAndReturnOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class StringFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const StringFieldUpdateOperationsInput({this.set});

  final String? set;

  @override
  Map<String, dynamic> toJson() => {'set': set};
}

class BoolFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const BoolFieldUpdateOperationsInput({this.set});

  final bool? set;

  @override
  Map<String, dynamic> toJson() => {'set': set};
}

class DateTimeFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const DateTimeFieldUpdateOperationsInput({this.set});

  final DateTime? set;

  @override
  Map<String, dynamic> toJson() => {'set': set};
}

class AdminUpdateInput implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminUpdateInput({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>?
      firstName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? lastName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? email;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? password;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isActive;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isSuperAdmin;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class IntFieldUpdateOperationsInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const IntFieldUpdateOperationsInput({
    this.set,
    this.increment,
    this.decrement,
    this.multiply,
    this.divide,
  });

  final int? set;

  final int? increment;

  final int? decrement;

  final int? multiply;

  final int? divide;

  @override
  Map<String, dynamic> toJson() => {
        'set': set,
        'increment': increment,
        'decrement': decrement,
        'multiply': multiply,
        'divide': divide,
      };
}

class AdminUncheckedUpdateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminUncheckedUpdateInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<int, _i2.IntFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>?
      firstName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? lastName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? email;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? password;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isActive;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isSuperAdmin;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminUpdateManyMutationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminUpdateManyMutationInput({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>?
      firstName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? lastName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? email;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? password;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isActive;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isSuperAdmin;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminUncheckedUpdateManyInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminUncheckedUpdateManyInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<int, _i2.IntFieldUpdateOperationsInput>? id;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>?
      firstName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? lastName;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? email;

  final _i1.PrismaUnion<String, _i2.StringFieldUpdateOperationsInput>? password;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isActive;

  final _i1.PrismaUnion<bool, _i2.BoolFieldUpdateOperationsInput>? isSuperAdmin;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      createdAt;

  final _i1.PrismaUnion<DateTime, _i2.DateTimeFieldUpdateOperationsInput>?
      updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class UpdateManyAdminAndReturnOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const UpdateManyAdminAndReturnOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminCountAggregateOutputType {
  const AdminCountAggregateOutputType({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.$all,
  });

  factory AdminCountAggregateOutputType.fromJson(Map json) =>
      AdminCountAggregateOutputType(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        isActive: json['isActive'],
        isSuperAdmin: json['isSuperAdmin'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        $all: json['_all'],
      );

  final int? id;

  final int? firstName;

  final int? lastName;

  final int? email;

  final int? password;

  final int? isActive;

  final int? isSuperAdmin;

  final int? createdAt;

  final int? updatedAt;

  final int? $all;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '_all': $all,
      };
}

class AdminAvgAggregateOutputType {
  const AdminAvgAggregateOutputType({this.id});

  factory AdminAvgAggregateOutputType.fromJson(Map json) =>
      AdminAvgAggregateOutputType(id: json['id']);

  final double? id;

  Map<String, dynamic> toJson() => {'id': id};
}

class AdminSumAggregateOutputType {
  const AdminSumAggregateOutputType({this.id});

  factory AdminSumAggregateOutputType.fromJson(Map json) =>
      AdminSumAggregateOutputType(id: json['id']);

  final int? id;

  Map<String, dynamic> toJson() => {'id': id};
}

class AdminMinAggregateOutputType {
  const AdminMinAggregateOutputType({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminMinAggregateOutputType.fromJson(Map json) =>
      AdminMinAggregateOutputType(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        isActive: json['isActive'],
        isSuperAdmin: json['isSuperAdmin'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? firstName;

  final String? lastName;

  final String? email;

  final String? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class AdminMaxAggregateOutputType {
  const AdminMaxAggregateOutputType({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory AdminMaxAggregateOutputType.fromJson(Map json) =>
      AdminMaxAggregateOutputType(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        isActive: json['isActive'],
        isSuperAdmin: json['isSuperAdmin'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
      );

  final int? id;

  final String? firstName;

  final String? lastName;

  final String? email;

  final String? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}

class AdminGroupByOutputType {
  const AdminGroupByOutputType({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory AdminGroupByOutputType.fromJson(Map json) => AdminGroupByOutputType(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        password: json['password'],
        isActive: json['isActive'],
        isSuperAdmin: json['isSuperAdmin'],
        createdAt: switch (json['createdAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['createdAt']
        },
        updatedAt: switch (json['updatedAt']) {
          DateTime value => value,
          String value => DateTime.parse(value),
          _ => json['updatedAt']
        },
        $count: json['_count'] is Map
            ? _i2.AdminCountAggregateOutputType.fromJson(json['_count'])
            : null,
        $avg: json['_avg'] is Map
            ? _i2.AdminAvgAggregateOutputType.fromJson(json['_avg'])
            : null,
        $sum: json['_sum'] is Map
            ? _i2.AdminSumAggregateOutputType.fromJson(json['_sum'])
            : null,
        $min: json['_min'] is Map
            ? _i2.AdminMinAggregateOutputType.fromJson(json['_min'])
            : null,
        $max: json['_max'] is Map
            ? _i2.AdminMaxAggregateOutputType.fromJson(json['_max'])
            : null,
      );

  final int? id;

  final String? firstName;

  final String? lastName;

  final String? email;

  final String? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final _i2.AdminCountAggregateOutputType? $count;

  final _i2.AdminAvgAggregateOutputType? $avg;

  final _i2.AdminSumAggregateOutputType? $sum;

  final _i2.AdminMinAggregateOutputType? $min;

  final _i2.AdminMaxAggregateOutputType? $max;

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '_count': $count?.toJson(),
        '_avg': $avg?.toJson(),
        '_sum': $sum?.toJson(),
        '_min': $min?.toJson(),
        '_max': $max?.toJson(),
      };
}

class AdminCountOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminCountOrderByAggregateInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i2.SortOrder? id;

  final _i2.SortOrder? firstName;

  final _i2.SortOrder? lastName;

  final _i2.SortOrder? email;

  final _i2.SortOrder? password;

  final _i2.SortOrder? isActive;

  final _i2.SortOrder? isSuperAdmin;

  final _i2.SortOrder? createdAt;

  final _i2.SortOrder? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminAvgOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminAvgOrderByAggregateInput({this.id});

  final _i2.SortOrder? id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

class AdminMaxOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminMaxOrderByAggregateInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i2.SortOrder? id;

  final _i2.SortOrder? firstName;

  final _i2.SortOrder? lastName;

  final _i2.SortOrder? email;

  final _i2.SortOrder? password;

  final _i2.SortOrder? isActive;

  final _i2.SortOrder? isSuperAdmin;

  final _i2.SortOrder? createdAt;

  final _i2.SortOrder? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminMinOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminMinOrderByAggregateInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i2.SortOrder? id;

  final _i2.SortOrder? firstName;

  final _i2.SortOrder? lastName;

  final _i2.SortOrder? email;

  final _i2.SortOrder? password;

  final _i2.SortOrder? isActive;

  final _i2.SortOrder? isSuperAdmin;

  final _i2.SortOrder? createdAt;

  final _i2.SortOrder? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminSumOrderByAggregateInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminSumOrderByAggregateInput({this.id});

  final _i2.SortOrder? id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

class AdminOrderByWithAggregationInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminOrderByWithAggregationInput({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.$count,
    this.$avg,
    this.$max,
    this.$min,
    this.$sum,
  });

  final _i2.SortOrder? id;

  final _i2.SortOrder? firstName;

  final _i2.SortOrder? lastName;

  final _i2.SortOrder? email;

  final _i2.SortOrder? password;

  final _i2.SortOrder? isActive;

  final _i2.SortOrder? isSuperAdmin;

  final _i2.SortOrder? createdAt;

  final _i2.SortOrder? updatedAt;

  final _i2.AdminCountOrderByAggregateInput? $count;

  final _i2.AdminAvgOrderByAggregateInput? $avg;

  final _i2.AdminMaxOrderByAggregateInput? $max;

  final _i2.AdminMinOrderByAggregateInput? $min;

  final _i2.AdminSumOrderByAggregateInput? $sum;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '_count': $count,
        '_avg': $avg,
        '_max': $max,
        '_min': $min,
        '_sum': $sum,
      };
}

class NestedFloatFilter implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedFloatFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
  });

  final _i1.PrismaUnion<double, _i1.Reference<double>>? equals;

  final _i1.PrismaUnion<Iterable<double>, _i1.Reference<Iterable<double>>>? $in;

  final _i1.PrismaUnion<Iterable<double>, _i1.Reference<Iterable<double>>>?
      notIn;

  final _i1.PrismaUnion<double, _i1.Reference<double>>? lt;

  final _i1.PrismaUnion<double, _i1.Reference<double>>? lte;

  final _i1.PrismaUnion<double, _i1.Reference<double>>? gt;

  final _i1.PrismaUnion<double, _i1.Reference<double>>? gte;

  final _i1.PrismaUnion<double, _i2.NestedFloatFilter>? not;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
      };
}

class NestedIntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedIntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<int, _i1.Reference<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lte;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gte;

  final _i1.PrismaUnion<int, _i2.NestedIntWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedFloatFilter? $avg;

  final _i2.NestedIntFilter? $sum;

  final _i2.NestedIntFilter? $min;

  final _i2.NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
        '_count': $count,
        '_avg': $avg,
        '_sum': $sum,
        '_min': $min,
        '_max': $max,
      };
}

class IntWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const IntWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<int, _i1.Reference<int>>? equals;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? $in;

  final _i1.PrismaUnion<Iterable<int>, _i1.Reference<Iterable<int>>>? notIn;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? lte;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gt;

  final _i1.PrismaUnion<int, _i1.Reference<int>>? gte;

  final _i1.PrismaUnion<int, _i2.NestedIntWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedFloatFilter? $avg;

  final _i2.NestedIntFilter? $sum;

  final _i2.NestedIntFilter? $min;

  final _i2.NestedIntFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
        '_count': $count,
        '_avg': $avg,
        '_sum': $sum,
        '_min': $min,
        '_max': $max,
      };
}

class NestedStringWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedStringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<String, _i1.Reference<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? contains;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? endsWith;

  final _i1.PrismaUnion<String, _i2.NestedStringWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedStringFilter? $min;

  final _i2.NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'contains': contains,
        'startsWith': startsWith,
        'endsWith': endsWith,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class StringWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const StringWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.contains,
    this.startsWith,
    this.endsWith,
    this.mode,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<String, _i1.Reference<String>>? equals;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>? $in;

  final _i1.PrismaUnion<Iterable<String>, _i1.Reference<Iterable<String>>>?
      notIn;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? lte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gt;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? gte;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? contains;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? startsWith;

  final _i1.PrismaUnion<String, _i1.Reference<String>>? endsWith;

  final _i2.QueryMode? mode;

  final _i1.PrismaUnion<String, _i2.NestedStringWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedStringFilter? $min;

  final _i2.NestedStringFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'contains': contains,
        'startsWith': startsWith,
        'endsWith': endsWith,
        'mode': mode,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class NestedBoolWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedBoolWithAggregatesFilter({
    this.equals,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<bool, _i1.Reference<bool>>? equals;

  final _i1.PrismaUnion<bool, _i2.NestedBoolWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedBoolFilter? $min;

  final _i2.NestedBoolFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class BoolWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const BoolWithAggregatesFilter({
    this.equals,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<bool, _i1.Reference<bool>>? equals;

  final _i1.PrismaUnion<bool, _i2.NestedBoolWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedBoolFilter? $min;

  final _i2.NestedBoolFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class NestedDateTimeWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const NestedDateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, _i2.NestedDateTimeWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedDateTimeFilter? $min;

  final _i2.NestedDateTimeFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class DateTimeWithAggregatesFilter
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const DateTimeWithAggregatesFilter({
    this.equals,
    this.$in,
    this.notIn,
    this.lt,
    this.lte,
    this.gt,
    this.gte,
    this.not,
    this.$count,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? equals;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      $in;

  final _i1.PrismaUnion<Iterable<DateTime>, _i1.Reference<Iterable<DateTime>>>?
      notIn;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? lte;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gt;

  final _i1.PrismaUnion<DateTime, _i1.Reference<DateTime>>? gte;

  final _i1.PrismaUnion<DateTime, _i2.NestedDateTimeWithAggregatesFilter>? not;

  final _i2.NestedIntFilter? $count;

  final _i2.NestedDateTimeFilter? $min;

  final _i2.NestedDateTimeFilter? $max;

  @override
  Map<String, dynamic> toJson() => {
        'equals': equals,
        'in': $in,
        'notIn': notIn,
        'lt': lt,
        'lte': lte,
        'gt': gt,
        'gte': gte,
        'not': not,
        '_count': $count,
        '_min': $min,
        '_max': $max,
      };
}

class AdminScalarWhereWithAggregatesInput
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminScalarWhereWithAggregatesInput({
    this.AND,
    this.OR,
    this.NOT,
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final _i1.PrismaUnion<_i2.AdminScalarWhereWithAggregatesInput,
      Iterable<_i2.AdminScalarWhereWithAggregatesInput>>? AND;

  final Iterable<_i2.AdminScalarWhereWithAggregatesInput>? OR;

  final _i1.PrismaUnion<_i2.AdminScalarWhereWithAggregatesInput,
      Iterable<_i2.AdminScalarWhereWithAggregatesInput>>? NOT;

  final _i1.PrismaUnion<_i2.IntWithAggregatesFilter, int>? id;

  final _i1.PrismaUnion<_i2.StringWithAggregatesFilter, String>? firstName;

  final _i1.PrismaUnion<_i2.StringWithAggregatesFilter, String>? lastName;

  final _i1.PrismaUnion<_i2.StringWithAggregatesFilter, String>? email;

  final _i1.PrismaUnion<_i2.StringWithAggregatesFilter, String>? password;

  final _i1.PrismaUnion<_i2.BoolWithAggregatesFilter, bool>? isActive;

  final _i1.PrismaUnion<_i2.BoolWithAggregatesFilter, bool>? isSuperAdmin;

  final _i1.PrismaUnion<_i2.DateTimeWithAggregatesFilter, DateTime>? createdAt;

  final _i1.PrismaUnion<_i2.DateTimeWithAggregatesFilter, DateTime>? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'AND': AND,
        'OR': OR,
        'NOT': NOT,
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminCountAggregateOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminCountAggregateOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.$all,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  final bool? $all;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '_all': $all,
      };
}

class AdminGroupByOutputTypeCountArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeCountArgs({this.select});

  final _i2.AdminCountAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AdminAvgAggregateOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminAvgAggregateOutputTypeSelect({this.id});

  final bool? id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

class AdminGroupByOutputTypeAvgArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeAvgArgs({this.select});

  final _i2.AdminAvgAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AdminSumAggregateOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminSumAggregateOutputTypeSelect({this.id});

  final bool? id;

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

class AdminGroupByOutputTypeSumArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeSumArgs({this.select});

  final _i2.AdminSumAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AdminMinAggregateOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminMinAggregateOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminGroupByOutputTypeMinArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeMinArgs({this.select});

  final _i2.AdminMinAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AdminMaxAggregateOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminMaxAggregateOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };
}

class AdminGroupByOutputTypeMaxArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeMaxArgs({this.select});

  final _i2.AdminMaxAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AdminGroupByOutputTypeSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AdminGroupByOutputTypeSelect({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.isActive,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  final bool? id;

  final bool? firstName;

  final bool? lastName;

  final bool? email;

  final bool? password;

  final bool? isActive;

  final bool? isSuperAdmin;

  final bool? createdAt;

  final bool? updatedAt;

  final _i1.PrismaUnion<bool, _i2.AdminGroupByOutputTypeCountArgs>? $count;

  final _i1.PrismaUnion<bool, _i2.AdminGroupByOutputTypeAvgArgs>? $avg;

  final _i1.PrismaUnion<bool, _i2.AdminGroupByOutputTypeSumArgs>? $sum;

  final _i1.PrismaUnion<bool, _i2.AdminGroupByOutputTypeMinArgs>? $min;

  final _i1.PrismaUnion<bool, _i2.AdminGroupByOutputTypeMaxArgs>? $max;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'isActive': isActive,
        'isSuperAdmin': isSuperAdmin,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        '_count': $count,
        '_avg': $avg,
        '_sum': $sum,
        '_min': $min,
        '_max': $max,
      };
}

class AggregateAdmin {
  const AggregateAdmin({
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  factory AggregateAdmin.fromJson(Map json) => AggregateAdmin(
        $count: json['_count'] is Map
            ? _i2.AdminCountAggregateOutputType.fromJson(json['_count'])
            : null,
        $avg: json['_avg'] is Map
            ? _i2.AdminAvgAggregateOutputType.fromJson(json['_avg'])
            : null,
        $sum: json['_sum'] is Map
            ? _i2.AdminSumAggregateOutputType.fromJson(json['_sum'])
            : null,
        $min: json['_min'] is Map
            ? _i2.AdminMinAggregateOutputType.fromJson(json['_min'])
            : null,
        $max: json['_max'] is Map
            ? _i2.AdminMaxAggregateOutputType.fromJson(json['_max'])
            : null,
      );

  final _i2.AdminCountAggregateOutputType? $count;

  final _i2.AdminAvgAggregateOutputType? $avg;

  final _i2.AdminSumAggregateOutputType? $sum;

  final _i2.AdminMinAggregateOutputType? $min;

  final _i2.AdminMaxAggregateOutputType? $max;

  Map<String, dynamic> toJson() => {
        '_count': $count?.toJson(),
        '_avg': $avg?.toJson(),
        '_sum': $sum?.toJson(),
        '_min': $min?.toJson(),
        '_max': $max?.toJson(),
      };
}

class AggregateAdminCountArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminCountArgs({this.select});

  final _i2.AdminCountAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AggregateAdminAvgArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminAvgArgs({this.select});

  final _i2.AdminAvgAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AggregateAdminSumArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminSumArgs({this.select});

  final _i2.AdminSumAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AggregateAdminMinArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminMinArgs({this.select});

  final _i2.AdminMinAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AggregateAdminMaxArgs
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminMaxArgs({this.select});

  final _i2.AdminMaxAggregateOutputTypeSelect? select;

  @override
  Map<String, dynamic> toJson() => {'select': select};
}

class AggregateAdminSelect
    implements _i1.JsonConvertible<Map<String, dynamic>> {
  const AggregateAdminSelect({
    this.$count,
    this.$avg,
    this.$sum,
    this.$min,
    this.$max,
  });

  final _i1.PrismaUnion<bool, _i2.AggregateAdminCountArgs>? $count;

  final _i1.PrismaUnion<bool, _i2.AggregateAdminAvgArgs>? $avg;

  final _i1.PrismaUnion<bool, _i2.AggregateAdminSumArgs>? $sum;

  final _i1.PrismaUnion<bool, _i2.AggregateAdminMinArgs>? $min;

  final _i1.PrismaUnion<bool, _i2.AggregateAdminMaxArgs>? $max;

  @override
  Map<String, dynamic> toJson() => {
        '_count': $count,
        '_avg': $avg,
        '_sum': $sum,
        '_min': $min,
        '_max': $max,
      };
}
