import 'dart:developer';

import 'package:sarus/sarus.dart';
import 'package:shelf/shelf.dart';

/// A [BaseRouter] that can register multiple APIRouters
class BaseRouter {
  /// List of registered APIRouters
  final List<APIRouter> _routers = [];

  /// Register an APIRouter instance with the main router
  void registerRouter(APIRouter router) {
    _routers.add(router);
    log('Registered router with routes: ${router.routes}');
  }

  /// The main handler function that will be passed to the Pipeline
  Handler get handler => (request) {
        final path = request.url.path;
        // Normalize path: ensure leading '/' and remove trailing '/' (unless it's the root path)
        var normalizedPath = path.isEmpty ? '/' : '/$path';
        if (normalizedPath.length > 1 && normalizedPath.endsWith('/')) {
          normalizedPath =
              normalizedPath.substring(0, normalizedPath.length - 1);
        }
        final method = request.method;

        log('BaseRouter handling request: $method $normalizedPath');

        // Try each router in order
        for (final router in _routers) {
          final methodHandlers = router.routes[method];
          if (methodHandlers != null) {
            final handler = methodHandlers[normalizedPath];
            if (handler != null) {
              // Found a matching handler, execute it
              log('Found handler in router: ${router.hashCode}');
              return handler(request);
            }
          }
        }

        // No matching handler found in any router
        log('No handler found for: $method $normalizedPath');
        return Response.notFound('Not found: $normalizedPath');
      };
}
