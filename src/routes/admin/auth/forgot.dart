import 'package:dart_frog/dart_frog.dart';
import 'package:src/render.dart';
import 'package:src/templates/admin/forgot.dart';

Future<Response> onRequest(RequestContext context) async {
  return renderJasprComponent(context, ForgotPasswordAdminPage());
}
