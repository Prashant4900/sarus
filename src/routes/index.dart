import 'package:dart_frog/dart_frog.dart';
import 'package:src/pages/home.dart';
import 'package:src/render.dart';

Future<Response> onRequest(RequestContext context) {
  return renderJasprComponent(context, const Home());
}
