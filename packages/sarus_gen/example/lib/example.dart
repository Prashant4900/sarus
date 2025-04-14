import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'example.g.dart';

@Controller('/users')
class UserController extends BaseController {
  UserController() : super();

  @Get('/<name>')
  Future<Response> sayHello(Request request, String name) async {
    return Response.ok(jsonEncode({'message': 'Hello $name'}));
  }

  @Post('/')
  Future<Response> createUser(Request request) async {
    // Create user logic
    return Response.ok(jsonEncode({'status': 'created'}));
  }

  @override
  Router get router => _$userControllerRouter(this);
}
