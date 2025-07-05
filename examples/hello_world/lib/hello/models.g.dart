// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// DTOGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String?,
    age: json['age'] as int?,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  val['first_name'] = instance.firstName;
  val['last_name'] = instance.lastName;
  val['email'] = instance.email;
  val['age'] = instance.age;

  return val;
}
