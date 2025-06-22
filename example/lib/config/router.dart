import 'package:example/hello/controllers.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  routes: [
    Route(controller: HelloController()),
  ],
);
