import 'package:sarus/sarus.dart';

import '../greeting/endpoints.dart';

final router = Router(
  routes: [
    Route(endpoints: [GreetingEndpoints()]),
  ],
);
