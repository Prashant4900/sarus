import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Endpoint('/{{name.paramCase()}}')
class {{name.pascalCase()}}Endpoints extends Endpoints {
  {{name.pascalCase()}}Controller() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from {{name.pascalCase()}}Endpoint'}));
  }

  @override
  RouterConfig get router => _${{name.camelCase()}}EndpointsRouterConfig(this);
}
