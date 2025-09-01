import 'package:sarus/sarus.dart';

import '../greeting/endpoints.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  routes: [
    Route(endpoints: [GreetingEndpoints()]),
  ],
);
