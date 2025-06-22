import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller('/hello')
class HelloController extends Endpoint {
  HelloController() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from HelloController'}));
  }

  @override
  RouterConfig get router => _$helloControllerRouterConfig(this);
}
