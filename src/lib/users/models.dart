import 'package:sarus/sarus.dart';

part 'models.schema.dart';

@Model(
  tableName: 'users',
  indexes: [
    TableIndex(name: 'email', unique: true, columns: ['email']),
    TableIndex(name: 'phone', unique: true, columns: ['phone']),
  ],
)
abstract class Users {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String? get firstName;

  String? get lastName;

  String get email;

  String get password;

  String get phone;

  int get age;

  DateTime get createdAt;

  DateTime? get updatedAt;

  List<Address> get addresses;
}

@Model(tableName: 'address')
abstract class Address {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  bool get isDefault;

  String get addressLine1;

  String get addressLine2;

  String get city;

  String get state;

  String get country;

  String get zipCode;

  DateTime get createdAt;

  DateTime? get updatedAt;
}
