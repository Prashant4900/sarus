import 'package:shelf/shelf.dart';

/// Base annotation for all HTTP methods
abstract class HttpRoute {
  const HttpRoute({this.path = '', this.middlewares = const []});

  final String path;
  final List<Middleware> middlewares;
}

/// GET route annotation
class Get extends HttpRoute {
  const Get({
    super.path,
    super.middlewares,
  });
}

/// POST route annotation
class Post extends HttpRoute {
  const Post({
    super.path,
    super.middlewares,
  });
}

/// PUT route annotation
class Put extends HttpRoute {
  const Put({
    super.path,
    super.middlewares,
  });
}

/// DELETE route annotation
class Delete extends HttpRoute {
  const Delete({
    super.path,
    super.middlewares,
  });
}

/// PATCH route annotation
class Patch extends HttpRoute {
  const Patch({
    super.path,
    super.middlewares,
  });
}

/// OPTIONS route annotation
class Options extends HttpRoute {
  const Options({
    super.path,
    super.middlewares,
  });
}

/// HEAD route annotation
class Head extends HttpRoute {
  const Head({
    super.path,
    super.middlewares,
  });
}

/// Endpoint annotation to define base path and middleware
class Endpoint {
  const Endpoint({
    this.path = '',
    this.middlewares = const [],
  });

  final String path;
  final List<Middleware> middlewares;
}

/// Route metadata class to hold information about a specific route
/// This is used internally by the code generator
class RouteMetadata {
  const RouteMetadata({
    required this.method,
    required this.path,
    required this.handlerName,
    required this.middlewares,
    this.parameters = const [],
  });

  final String method;
  final String path;
  final String handlerName;
  final List<Middleware> middlewares;
  final List<String> parameters;

  @override
  String toString() => 'RouteMetadata($method $path -> $handlerName)';
}

/// Middleware composition utilities
class MiddlewareUtils {
  /// Combines multiple middleware lists in the correct order
  /// Order: global -> route -> endpoint
  static List<Middleware> combineMiddleware({
    List<Middleware> global = const [],
    List<Middleware> route = const [],
    List<Middleware> endpoint = const [],
  }) {
    return [
      ...global,
      ...route,
      ...endpoint,
    ];
  }

  /// Applies a list of middleware to a handler in the correct order
  static Handler applyMiddleware(
    Handler handler,
    List<Middleware> middlewares,
  ) {
    return middlewares.fold(handler, (h, middleware) => middleware(h));
  }

  /// Creates a middleware that logs request information
  static Middleware createLoggingMiddleware({String? prefix}) {
    return createMiddleware(
      requestHandler: (Request request) {
        final logPrefix = prefix != null ? '[$prefix] ' : '';
        print('$logPrefix${request.method} ${request.requestedUri}');
        return null; // Continue to next middleware/handler
      },
    );
  }

  /// Creates a CORS middleware
  static Middleware createCorsMiddleware({
    String origin = '*',
    String methods = 'GET, POST, PUT, DELETE, PATCH, OPTIONS',
    String headers = 'Content-Type, Authorization',
  }) {
    return createMiddleware(
      responseHandler: (Response response) {
        return response.change(
          headers: {
            'Access-Control-Allow-Origin': origin,
            'Access-Control-Allow-Methods': methods,
            'Access-Control-Allow-Headers': headers,
            ...response.headers,
          },
        );
      },
    );
  }

  /// Creates an authentication middleware
  static Middleware createAuthMiddleware({
    required bool Function(Request request) isAuthenticated,
    Response Function(Request request)? onUnauthorized,
  }) {
    return createMiddleware(
      requestHandler: (Request request) {
        if (!isAuthenticated(request)) {
          return onUnauthorized?.call(request) ??
              Response.forbidden('Unauthorized');
        }
        return null; // Continue to next middleware/handler
      },
    );
  }
}
