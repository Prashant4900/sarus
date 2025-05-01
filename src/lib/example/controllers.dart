import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller('/users')
class UserController extends BaseController {
  UserController() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from UserController'}));
  }

  @override
  RouterConfig get router => _$userControllerRouterConfig(this);
}
