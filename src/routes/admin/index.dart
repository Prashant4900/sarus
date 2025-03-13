import 'package:dart_frog/dart_frog.dart';
import 'package:src/admins/services.dart';
import 'package:src/render.dart';

import '../../views/pages/admin/login.dart';
import '../../views/pages/admin/signup.dart';

Future<Response> onRequest(RequestContext context) async {
  final adminCount = await context.read<AdminServices>().count();

  if (adminCount == 0) {
    return renderJasprComponent(context, AdminSignupPage());
  } else {
    return renderJasprComponent(context, AdminLoginPage());
  }
}
