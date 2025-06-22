import 'package:sarus/sarus.dart';
import 'package:{{name}}/hello/controllers.dart';

final router = Router(routes: [
    Route(controller: HelloController()),
]);
