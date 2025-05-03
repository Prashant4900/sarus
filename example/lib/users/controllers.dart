import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller('/users')
class UsersController extends BaseController {
  UsersController() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from UsersController'}));
  }

  @override
  RouterConfig get router => _$usersControllerRouterConfig(this);
}

// @Controller('/admin')
// class AdminController extends BaseController {
//   @Get('')
//   Future<Response> index(Request request) async {
//     return Response.ok(jsonEncode({'message': 'Hello from AdminController'}));
//   }

//   @override
//   RouterConfig get router => _$adminControllerRouterConfig(this);
// }
