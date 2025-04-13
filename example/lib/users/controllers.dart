import 'dart:convert';

import 'package:example/users/services.dart';
import 'package:sarus/sarus.dart';

class UserControllers {
  UserControllers(this._service);

  final UserServices _service;

  Future<Response> getUserById(Request request) async {
    final userId = request.url.queryParameters['id'];

    final user = await _service.getUserById(int.parse(userId!));

    return Response.ok(
      jsonEncode({
        'id': user!.id,
        'first_name': user.firstName,
        'last_name': user.lastName,
      }),
    );
  }
}
