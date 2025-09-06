import 'dart:convert';

import 'package:sarus/sarus.dart';

import 'generated/endpoints.g.dart';
import 'middlewares.dart';
import 'models.dart';

class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  static const String prefix = '/greeting';

  @Get()
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoint'}));
  }

  @Get(path: '/hello')
  Future<Response> hello(
    Request request,
    @QueryParam('message') String? message,
  ) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoint'}));
  }

  @Post(path: '/hello/<id>')
  Future<Response> helloPost(
    Request request,
    @Body() UserRequest userRequest,
    @PathParam('id') double id,
    @QueryParam('name') String? name,
  ) async {
    try {
      return Response.ok(
        jsonEncode({'message': 'Hello from GreetingEndpoint'}),
      );
    } catch (e) {
      return Response.badRequest(body: {'error': e.toString()});
    }
  }

  @override
  RouterConfig get router => $greetingEndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware(greetingMiddleware)
      .addHandler(router.call);
}
