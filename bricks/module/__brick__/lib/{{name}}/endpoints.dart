import 'dart:convert';

import 'package:sarus/sarus.dart';

import '../sarus_application.g.dart';
import './middlewares.dart';

@Endpoint(path: '/{{name.paramCase()}}')
class {{name.pascalCase()}}Endpoints extends Endpoints {
  {{name.pascalCase()}}Endpoints() : super();

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
