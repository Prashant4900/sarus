import 'package:dart_frog/dart_frog.dart';
import 'package:{{name}}/pages/home.dart';
import 'package:{{name}}/render.dart';

Future<Response> onRequest(RequestContext context) {
  return renderJasprComponent(context, const Home());
}
