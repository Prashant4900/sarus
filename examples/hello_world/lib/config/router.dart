import 'package:hello_world/greeting/endpoints.dart';
import 'package:hello_world/hello/endpoints.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  routes: [
    Route(
      endpoints: [GreetingEndpoints()],
    ),
    Route(
      endpoints: [HelloEndpoints()],
    ),
  ],
);
