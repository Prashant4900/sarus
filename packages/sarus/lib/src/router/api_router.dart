import 'dart:developer';

import 'package:sarus/sarus.dart';
import 'package:shelf/shelf.dart';

/// A simple API router for the Shelf HTTP server.
///
/// This router maps HTTP methods and paths to handler functions and
/// provides middleware for handling incoming HTTP requests.
class APIRouter {
  /// Internal storage of routes, organized by HTTP method and path.
  ///
  /// The first key is the HTTP method name (e.g., 'GET', 'POST'),
  /// and the second key is the normalized path (e.g., '/users', '/products').
  final Map<String, Map<String, Handler>> routes = {};

  /// Registers a new route handler for the specified HTTP method and path.
  ///
  /// The [method] parameter is the HTTP method to handle.
  /// The [path] parameter is the URL path to match.
  /// The [handler] parameter is the function to execute when the route is matched.
  ///
  /// Paths are normalized to always start with a '/' and never end with a '/'
  /// (except for the root path '/').
  void addRoute(Method method, String path, Handler handler) {
    // Normalize the path by ensuring it starts with '/' and has no trailing '/' (unless it's the root path)
    var normalizedPath = path.startsWith('/') ? path : '/$path';
    if (normalizedPath.length > 1 && normalizedPath.endsWith('/')) {
      normalizedPath = normalizedPath.substring(0, normalizedPath.length - 1);
    }

    // Initialize the map for this method if it doesn't exist
    routes[method.name] ??= {};

    // Add the route handler with the normalized path
    routes[method.name]![normalizedPath] = handler;
  }

  /// Returns a handler function that processes incoming HTTP requests.
  ///
  /// This handler matches the request's method and path against registered routes
  /// and executes the corresponding handler function if found.
  ///
  /// If no matching handler is found, a 404 Not Found response is returned.
  Handler get handler => (request) {
        final path = request.url.path;
        // Normalize path: ensure leading '/' and remove trailing '/' (unless it's the root path)
        var normalizedPath = path.isEmpty ? '/' : '/$path';
        if (normalizedPath.length > 1 && normalizedPath.endsWith('/')) {
          normalizedPath =
              normalizedPath.substring(0, normalizedPath.length - 1);
        }
        final method = request.method;

        log('Request: $method $normalizedPath');
        log('Available routes: $routes');

        // Get handlers for this method
        final methodHandlers = routes[method];
        if (methodHandlers == null) {
          log('No handlers registered for method: $method');
          return Response.notFound('Method not supported: $method');
        }

        // Get handler for this path
        final handler = methodHandlers[normalizedPath];
        if (handler == null) {
          log('No handler found for path: $normalizedPath');
          return Response.notFound('Not found: $normalizedPath');
        }

        // Execute the handler
        return handler(request);
      };
}
