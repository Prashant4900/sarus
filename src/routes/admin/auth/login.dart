import 'package:dart_frog/dart_frog.dart';
import 'package:src/render.dart';
import 'package:src/templates/admin/login.dart';

Future<Response> onRequest(RequestContext context) async {
  return renderJasprComponent(context, LoginAdminPage());
}
