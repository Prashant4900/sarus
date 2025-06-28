import 'package:example/greeting/endpoints.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  routes: [
    Route(endpoints: [GreetingEndpoints()]),
  ],
);
