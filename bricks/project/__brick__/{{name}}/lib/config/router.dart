import 'package:sarus/sarus.dart';
import 'package:{{name}}/greeting/endpoints.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  routes: [
    Route(endpoints: [GreetingEndpoints()]),
  ],
);
