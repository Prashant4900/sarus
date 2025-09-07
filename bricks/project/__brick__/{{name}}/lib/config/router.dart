import 'package:sarus/sarus.dart';

import '../greeting/endpoints.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  endpoints: [
    Route(endpoints: [GreetingEndpoints()]),
  ],
);
