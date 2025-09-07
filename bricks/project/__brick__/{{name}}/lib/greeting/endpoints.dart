import 'dart:convert';

import 'package:sarus/sarus.dart';

import 'generated/endpoints.g.dart';
import 'middlewares.dart';

class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  static const String prefix = '/greeting';

  @Get()
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoint'}));
  }

  @override
  RouterConfig get router => $greetingEndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware(greetingMiddleware)
      .addHandler(router.call);
}
