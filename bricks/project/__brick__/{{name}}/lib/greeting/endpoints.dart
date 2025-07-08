import 'dart:convert';

import 'package:sarus/sarus.dart';
import 'package:{{name}}/greeting/middlewares.dart';
import 'package:{{name}}/sarus_application.g.dart';

@Endpoint(path: '/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

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
