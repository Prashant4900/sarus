import 'package:hello_world/sarus_application.g.dart';
import 'package:sarus/sarus.dart';

@DTO()
class UserModel {
  UserModel({
    required this.firstName,
    required this.lastName,
    this.email,
    this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      $userModelFromJson(json);

  @JsonKey(name: 'first_name', includeIfNull: false)
  final String firstName;
  @JsonKey(name: 'last_name', includeIfNull: false)
  final String lastName;
  final String? email;
  final int? age;

  Map<String, dynamic> toJson() => $userModelToJson(this);
}
