import 'package:example/home/controllers.dart';
import 'package:example/users/controllers.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  routes: [
    Route(controller: UserController(), name: 'Users Routes'),
    Route(controller: HomeController(), name: 'Home Routes'),
    Route(controller: AdminController(), name: 'Admin Routes'),
  ],
);
