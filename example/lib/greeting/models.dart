import 'package:sarus/sarus.dart';

import 'generated/models.g.dart';

class UserRequest extends Model<UserRequest> {
  final String firstName;
  final String lastName;

  UserRequest({required this.firstName, required this.lastName});

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      $userRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => $userRequestToJson(this);
}
