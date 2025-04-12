import 'package:example/users/router.dart';
import 'package:sarus/sarus.dart';

class AppRouter extends BaseRouter {
  AppRouter() {
    _registerRouter();
  }

  void _registerRouter() {
    registerRouter(UserRouter());
    registerRouter(ProductRouter());
  }
}
