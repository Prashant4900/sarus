import 'package:sarus/src/router/router.dart';
import 'package:shelf/shelf.dart';

abstract class BaseController {
  Handler get handler => router.call;

  Router get router;
}
