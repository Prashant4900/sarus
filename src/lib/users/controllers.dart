import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

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

@Controller('/profiles')
class ProfileController extends BaseController {
  ProfileController() : super();

  @Get('/<username>')
  Future<Response> getProfile(Request request, String username) async {
    return Response.ok(jsonEncode({'profile': 'Profile of $username'}));
  }

  @Post('/')
  Future<Response> createProfile(Request request) async {
    // Create profile logic
    return Response.ok(jsonEncode({'status': 'profile created'}));
  }

  @override
  Router get router => _$profileControllerRouter(this);
}
