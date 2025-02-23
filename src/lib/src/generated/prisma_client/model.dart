class User {
  const User({
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

  factory User.fromJson(Map json) => User(
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

class CreateManyUserAndReturnOutputType {
  const CreateManyUserAndReturnOutputType({
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

  factory CreateManyUserAndReturnOutputType.fromJson(Map json) =>
      CreateManyUserAndReturnOutputType(
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
