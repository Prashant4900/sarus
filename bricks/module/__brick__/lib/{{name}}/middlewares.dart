import 'package:sarus/sarus.dart';

Middleware {{name.paramCase()}}Middleware = createMiddleware(
  requestHandler: (request) {
    print('{{name.pascalCase()}} Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
