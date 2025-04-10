import 'package:example/users/router.dart';
import 'package:sarus/sarus.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

void main() async {
  // Create the main router
  final router = BaseRouter();

  // Create and configure a second API router
  final userRouter = UserRouter();

  // Register both routers with the main router
  router.registerRouter(userRouter);

  print("User Router routes: ${userRouter.routes}");

  // Use the main router's handler in the pipeline
  var handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router.handler);

  var server = await shelf_io.serve(handler, 'localhost', 8080);

  // Enable content compression
  server.autoCompress = true;

  print('Serving at http://${server.address.host}:${server.port}');
}
