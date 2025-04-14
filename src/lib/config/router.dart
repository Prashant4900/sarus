import 'package:example/users/controllers.dart'; // Import your controllers
import 'package:sarus/sarus.dart';

class AppRouter extends BaseRouter {
  AppRouter() {
    register(UserController(), prefix: '/op');
    register(ProfileController());
  }
}
