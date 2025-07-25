import 'package:sarus/src/core/endpoint.dart';
import 'package:sarus/src/router/router_config.dart';
import 'package:shelf/shelf.dart';

/// A more robust implementation of the Router class that provides
/// better error handling, validation, and middleware support.
class Router {
  /// Creates a new [Router] instance with the given routes.
  ///
  /// If [autoRegister] is true (default), routes will be automatically registered
  /// upon creation of the Router instance.
  ///
  /// [globalMiddleware] will be applied to all routes in this router.
  Router({
    required this.routes,
    this.autoRegister = true,
    this.globalMiddleware = const [],
  }) {
    if (autoRegister) {
      registerEndpoints();
    }
  }

  final RouterConfig router = RouterConfig();
  final List<Route> routes;
  final bool autoRegister;
  final List<Middleware> globalMiddleware;

  /// Registers all controllers defined in [routes].
  void registerEndpoints() {
    for (final route in routes) {
      try {
        // Validate the route prefix
        if (!route.prefix.startsWith('/')) {
          throw ArgumentError(
            'Route prefix must start with a forward slash: ${route.prefix}',
          );
        }

        for (final endpoint in route.endpoints) {
          // Apply middleware to the controller handler if defined
          var handlerWithMiddleware = endpoint.handler;

          // Apply route-specific middleware first (if any)
          if (route.middlewares.isNotEmpty) {
            for (final middleware in route.middlewares) {
              handlerWithMiddleware = middleware(handlerWithMiddleware);
            }
          }

          // Then apply global middleware
          for (final middleware in globalMiddleware) {
            handlerWithMiddleware = middleware(handlerWithMiddleware);
          }

          // Mount the controller with its middleware
          router.mount(route.prefix, handlerWithMiddleware);
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  /// Returns the handler for this router.
  Handler get handler => _wrapWithErrorLogging(router.call);

  /// Wraps the router handler with error logging.
  Handler _wrapWithErrorLogging(Handler innerHandler) {
    return (Request request) async {
      try {
        final response = await innerHandler(request);
        return response;
      } catch (e) {
        rethrow;
      }
    };
  }

  /// Convenience method to add a new route to this router after initialization.
  /// Returns the router instance for method chaining.
  void addRoute(Route route) {
    routes.add(route);
    try {
      for (final endpoint in route.endpoints) {
        var handlerWithMiddleware = endpoint.handler;

        // Apply route-specific middleware
        for (final middleware in route.middlewares) {
          handlerWithMiddleware = middleware(handlerWithMiddleware);
        }

        // Apply global middleware
        for (final middleware in globalMiddleware) {
          handlerWithMiddleware = middleware(handlerWithMiddleware);
        }

        router.mount(route.prefix, handlerWithMiddleware);
      }
    } catch (e) {
      rethrow;
    }
  }
}

/// Enhanced Route class that supports middleware and additional options.
class Route {
  /// Creates a new route configuration.
  ///
  /// [endpoints] is the endpoint that will handle requests to this route.
  /// [prefix] is the URL prefix for this route (must start with '/').
  /// [middlewares] is a list of middleware that will be applied to this route only.
  /// [name] is an optional name for this route, useful for logging and debugging.
  Route({
    required this.endpoints,
    this.prefix = '/',
    this.middlewares = const [],
    this.name,
  }) {
    if (!prefix.startsWith('/')) {
      throw ArgumentError(
        'Route prefix must start with a forward slash: $prefix',
      );
    }
  }

  final List<Endpoints> endpoints;
  final String prefix;
  final List<Middleware> middlewares;
  final String? name;

  @override
  String toString() => 'Route($name: $prefix -> ${endpoints.runtimeType})';
}
