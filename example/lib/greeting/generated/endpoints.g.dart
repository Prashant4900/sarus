// GENERATED CODE - DO NOT MODIFY BY HAND

import "dart:convert";
import "package:sarus/sarus.dart";

import "../endpoints.dart";

import "package:example/greeting/models.dart";

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

  routerConfig.get('/greeting/hello', (Request req) async {
    try {

      final message = req.url.queryParameters["message"];
      if (message == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing query parameter: message", "status": 400}),
        );
      }
      

      return endpoints.hello(req, message);
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

  routerConfig.post('/greeting/hello/<id>', (Request req) async {
    try {
      final bodyString = await req.readAsString();
      if (bodyString.isEmpty) {
        return Response.badRequest(
          body: jsonEncode({"error": "Empty body", "status": 400}),
        );
      }
      final request = UserRequest.fromJson(jsonDecode(bodyString));

      final idRaw = req.params["id"];
      if (idRaw == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing path parameter: id", "status": 400}),
        );
      }
      final id = double.parse(idRaw);

      final name = req.url.queryParameters["name"];
      if (name == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing query parameter: name", "status": 400}),
        );
      }
      

      return endpoints.createGreeting(req, request, id, name);
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
