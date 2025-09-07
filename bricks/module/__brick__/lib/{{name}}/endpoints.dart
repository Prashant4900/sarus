import 'dart:convert';

import 'package:sarus/sarus.dart';

import 'generated/endpoints.g.dart';
import 'middlewares.dart';


class {{name.pascalCase()}}Endpoints extends Endpoints {
  {{name.pascalCase()}}Endpoints() : super();

  const String prefix = '/{{name.paramCase()}}';

  @Get()
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from {{name.pascalCase()}}Endpoint'}));
  }

  @override
  RouterConfig get router => ${{name.camelCase()}}EndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware({{name.paramCase()}}Middleware)
      .addHandler(router.call);
}
