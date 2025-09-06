import 'dart:convert';

import 'package:sarus/sarus.dart';

import 'generated/endpoints.g.dart';
import 'middlewares.dart';
import 'models.dart';

/// Example endpoint definition for greeting-related routes.
///
/// Demonstrates how to use `@Get`, `@Post`, and parameter
/// annotations like `@Body`, `@PathParam`, and `@QueryParam`.
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints();

  /// All routes under this endpoint will be prefixed with `/greeting`.
  static const String prefix = '/greeting';

  @Get()
  Future<Response> index(Request req) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoints'}));
  }

  @Get(path: '/hello')
  Future<Response> hello(
    Request req,
    @QueryParam('message') String? message,
  ) async {
    return Response.ok(
      jsonEncode({'message': 'Hello, ${message ?? "world"}!'}),
    );
  }

  @Post(path: '/hello/<id>')
  Future<Response> createGreeting(
    Request req,
    @Body() UserRequest userRequest,
    @PathParam('id') double id,
    @QueryParam('name') String? name,
  ) async {
    try {
      return Response.ok(
        jsonEncode({'id': id, 'name': name, 'payload': userRequest.toJson()}),
      );
    } catch (e) {
      return Response.badRequest(body: jsonEncode({'error': e.toString()}));
    }
  }

  @override
  RouterConfig get router => $greetingEndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware(greetingMiddleware)
      .addHandler(router.call);
}
