import 'dart:convert';

import 'package:hello_world/hello/middlewares.dart';
import 'package:hello_world/hello/models.dart';
import 'package:hello_world/sarus_application.g.dart';
import 'package:sarus/sarus.dart';

@Endpoint(path: '/hello')
class HelloEndpoints extends Endpoints {
  HelloEndpoints() : super();

  @Post(path: '/<id>')
  Future<Response> index(
    Request request,
    @QueryParam('name') String name,
    @PathParam('id') String id,
    @Body() UserModel user,
  ) async {
    return Response.ok(
      jsonEncode({
        'message': 'Hello, World! from $name',
        'id': id,
        'user': user.toJson(),
      }),
    );
  }

  @override
  RouterConfig get router => $helloEndpointsRouterConfig(this);

  @override
  Handler get handler =>
      const Pipeline().addMiddleware(helloMiddleware).addHandler(router.call);
}
