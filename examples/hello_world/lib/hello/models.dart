import 'package:sarus/sarus.dart';

part 'models.g.dart';

@DTO()
class UserModel {
  UserModel({
    required this.firstName,
    required this.lastName,
    this.email,
    this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @JsonKey(name: 'first_name', includeIfNull: false)
  final String firstName;
  @JsonKey(name: 'last_name', includeIfNull: false)
  final String lastName;
  final String? email;
  final int? age;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
