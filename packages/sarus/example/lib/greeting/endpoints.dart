import 'dart:convert';

import 'package:example/greeting/middlewares.dart';
import 'package:sarus/sarus.dart';

part 'endpoints.g.dart';

@Endpoint(path: '/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  @Get()
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoint'}));
  }

  @override
  RouterConfig get router => _$greetingEndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware(greetingMiddleware)
      .addHandler(router.call);
}
