import 'package:example/users/controllers.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  routes: [Route(controller: UserController(), name: 'Users Routes')],
);
