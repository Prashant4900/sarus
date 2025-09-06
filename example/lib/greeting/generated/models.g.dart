// GENERATED CODE - DO NOT MODIFY BY HAND

import "../models.dart";

Map<String, dynamic> $userRequestToJson(UserRequest instance) {
  final val = <String, dynamic>{};
  if (instance.firstName != null) { val['first_name'] = instance.firstName; }
  val['lastName'] = instance.lastName;
  return val;
}

UserRequest $userRequestFromJson(Map<String, dynamic> json) {
  return UserRequest(
    firstName: json['first_name'] as String?,
    lastName: json['lastName'] as String,
  );
}


