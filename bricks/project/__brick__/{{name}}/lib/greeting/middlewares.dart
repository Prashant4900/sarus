import 'package:sarus/sarus.dart';

final Middleware loggingMiddleware = createMiddleware(
  requestHandler: (request) {
    print('Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
