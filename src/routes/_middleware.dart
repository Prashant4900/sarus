import 'package:dart_frog/dart_frog.dart';
import 'package:src/admins/services.dart';
import 'package:src/render.dart';

/// The jaspr middleware responsible for serving all additional assets
/// from web/ needed by the rendered components, mainly the compiled .js files.
final jasprMiddleware = serveJasprApp();

/// Provides the middleware to dart_frog.
Handler middleware(Handler handler) {
  return handler
      .use(provider<AdminServices>((_) => AdminServices()))
      .use(jasprMiddleware);
}
