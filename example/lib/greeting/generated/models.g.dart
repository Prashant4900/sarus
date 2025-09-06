// GENERATED CODE - DO NOT MODIFY BY HAND

import "../models.dart";

Map<String, dynamic> $userRequestToJson(UserRequest instance) {
  return {
    'firstName': instance.firstName,
    'lastName': instance.lastName,
  };
}

UserRequest $userRequestFromJson(Map<String, dynamic> json) {
  return UserRequest(
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
  );
}


