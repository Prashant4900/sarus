// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:sarus/sarus.dart';
import 'dart:convert';
import 'package:hello_world/greeting/endpoints.dart';
import 'package:hello_world/hello/endpoints.dart';
import 'package:hello_world/hello/models.dart';

/// Generated router configuration for [GreetingEndpoints].
/// This function creates and configures all routes defined in the endpoint class.
RouterConfig $greetingEndpointsRouterConfig(GreetingEndpoints endpoints) {
  final routerConfig = RouterConfig();

  routerConfig.get('/greeting', (Request req) async {
    try {
      return endpoints.index(req);
    } catch (e) {
      if (e is ArgumentError) {
        return Response.badRequest(body: e.message);
      }
      if (e is FormatException) {
        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');
      }
      rethrow;
    }
  });

  return routerConfig;
}

/// Generated router configuration for [HelloEndpoints].
/// This function creates and configures all routes defined in the endpoint class.
RouterConfig $helloEndpointsRouterConfig(HelloEndpoints endpoints) {
  final routerConfig = RouterConfig();

  routerConfig.post('/hello/<id>', (Request req) async {
    try {
      final nameRaw = req.url.queryParameters['name'];
      if (nameRaw == null) {
        throw ArgumentError('Missing required query parameter: name');
      }
      final name = nameRaw;

      final idRaw = req.params['id'];
      if (idRaw == null) {
        throw ArgumentError('Missing required path parameter: id');
      }
      final id = idRaw;

      // Extract and parse request body
      final bodyString = await req.readAsString();
      if (bodyString.isEmpty) {
        throw ArgumentError('Request body is required');
      }
      final user = (() {
        try {
          final bodyJson = jsonDecode(bodyString);
          if (bodyJson is! Map<String, dynamic>) {
            throw ArgumentError('Request body must be a JSON object');
          }
          return UserModel.fromJson(bodyJson);
        } catch (e) {
          if (e is ArgumentError) rethrow;
          throw FormatException('Failed to parse request body: $e');
        }
      })();

      return endpoints.index(req, name, id, user);
    } catch (e) {
      if (e is ArgumentError) {
        return Response.badRequest(body: e.message);
      }
      if (e is FormatException) {
        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');
      }
      rethrow;
    }
  });

  return routerConfig;
}

UserModel $userModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String?,
    age: json['age'] as int?,
  );
}

Map<String, dynamic> $userModelToJson(UserModel instance) {
  final val = <String, dynamic>{};

  val['first_name'] = instance.firstName;
  val['last_name'] = instance.lastName;
  val['email'] = instance.email;
  val['age'] = instance.age;

  return val;
}

