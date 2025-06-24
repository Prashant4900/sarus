import 'package:sarus/sarus.dart';

Middleware {{name.paramCase()}}Middleware = createMiddleware(
  requestHandler: (request) {
    print('{{name.paramCase()}} Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
