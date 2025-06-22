import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'endpoints.g.dart';

@Endpoint('/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(
      jsonEncode({'message': 'Hello from GreetingEndpoint'}),
    );
  }

  @override
  RouterConfig get router => _$greetingControllerRouterConfig(this);
}
