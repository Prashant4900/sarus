import 'package:dart_frog/dart_frog.dart';
import 'package:{{name}}/render.dart';

/// The jaspr middleware responsible for serving all additional assets
/// from web/ needed by the rendered components, mainly the compiled .js files.
final jasprMiddleware = serveJasprApp();

/// Provides the middleware to dart_frog.
Handler middleware(Handler handler) {
  return handler.use(jasprMiddleware);
}
