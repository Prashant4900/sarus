import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.age,
    required this.createdAt,
    this.phone,
    this.updatedAt,
    this.lastLoginAt,
  });

  final int id;
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final bool isActive;
  final int age;
  final String? phone;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? lastLoginAt;

  @override
  List<Object?> get props => [
    id,
    email,
    password,
    firstName,
    lastName,
    isActive,
    age,
    phone,
    createdAt,
    updatedAt,
    lastLoginAt,
  ];
}
