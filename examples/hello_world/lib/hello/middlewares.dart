import 'package:sarus/sarus.dart';

Middleware helloMiddleware = createMiddleware(
  requestHandler: (request) {
    print('Hello Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
