import 'package:sarus/src/controller/base_controller.dart';
import 'package:sarus/src/router/router.dart';
import 'package:shelf/shelf.dart';

abstract class BaseRouter {
  final Router router = Router();

  // Abstract method to get the handler
  Handler get handler => router.call;

  void register(BaseController controller, {String prefix = '/'}) {
    router.mount(prefix, controller.handler);
  }
}
