import 'package:sarus/src/router/router_config.dart';
import 'package:shelf/shelf.dart';

abstract class Endpoints {
  Handler get handler => router.call;

  RouterConfig get router;
}
