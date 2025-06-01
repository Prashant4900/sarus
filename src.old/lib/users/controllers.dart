import 'dart:convert';

import 'package:example/sarus_application.dart';
import 'package:example/users/models.dart';
import 'package:example/users/services.dart';
import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller('/users')
class UserController extends BaseController {
  UserController() : super();

  final userRepo = injector.get<UserService>();

  @Get('/hello')
  Future<Response> hello(Request request) async {
    return Response.ok(
      jsonEncode({
        'message': 'Hello from UserController',
        'timestamp': DateTime.now().toIso8601String(),
        'method': request.method,
      }),
    );
  }

  @Post('/create')
  Future<Response> createUser(Request request) async {
    final response = await request.readAsString();
    final body = jsonDecode(response) as Map<String, dynamic>;

    final firstName = body['first_name'] as String?;
    final lastName = body['last_name'] as String?;
    final email = body['email'] as String;
    final password = body['password'] as String;
    final phone = body['phone'] as String;

    final newUser = UsersInsertRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phone: phone,
      age: 3,
      createdAt: DateTime.now(),
    );

    try {
      final userId = await userRepo.insert(newUser);

      return Response.ok(jsonEncode({'user_id': userId}));
    } catch (e) {
      return Response.badRequest(body: jsonEncode({'error': e.toString()}));
    }
  }

  @Delete('/<user-id>')
  Future<Response> deleteUser(Request request, String userID) async {
    try {
      await userRepo.delete(int.tryParse(userID) ?? 0);

      return Response.ok(
        jsonEncode({'message': 'User Successfully deleted from DB.'}),
      );
    } catch (e) {
      return Response.badRequest(body: jsonEncode({'error': e.toString()}));
    }
  }

  @override
  RouterConfig get router => _$userControllerRouterConfig(this);
}
