import 'package:dart_frog/dart_frog.dart';
import 'package:src/render.dart';
import 'package:src/templates/dashboard/dashboard.dart';

Future<Response> onRequest(RequestContext context) async {
  return renderJasprComponent(context, Dashboard());
}
