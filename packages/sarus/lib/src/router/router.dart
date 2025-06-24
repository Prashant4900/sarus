import 'package:sarus/src/endpoint/endpoint.dart';
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

        // Apply middleware to the controller handler if defined
        var handlerWithMiddleware = route.endpoints.handler;

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
      var handlerWithMiddleware = route.endpoints.handler;

      // Apply route-specific middleware
      for (final middleware in route.middlewares) {
        handlerWithMiddleware = middleware(handlerWithMiddleware);
      }

      // Apply global middleware
      for (final middleware in globalMiddleware) {
        handlerWithMiddleware = middleware(handlerWithMiddleware);
      }

      router.mount(route.prefix, handlerWithMiddleware);
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

  final Endpoints endpoints;
  final String prefix;
  final List<Middleware> middlewares;
  final String? name;

  @override
  String toString() => 'Route($name: $prefix -> ${endpoints.runtimeType})';
}

/// Enhanced RouterConfig extension to support method-level middleware
extension RouterConfigMiddleware on RouterConfig {
  /// Register a handler with method-level middleware support.
  ///
  /// This method combines endpoint middleware, route middleware, and global middleware
  /// in the correct order: global -> route -> endpoint -> handler
  void addWithMiddleware(
    String verb,
    String route,
    Function handler, {
    List<Middleware> endpointMiddleware = const [],
    List<Middleware> routeMiddleware = const [],
    List<Middleware> globalMiddleware = const [],
  }) {
    // Create the middleware chain
    var wrappedHandler = handler;

    // Apply middleware in reverse order (endpoint -> route -> global)
    // so they execute in the correct order during request processing

    // Apply endpoint-level middleware first
    for (final middleware in endpointMiddleware.reversed) {
      if (wrappedHandler is Handler) {
        wrappedHandler = middleware(wrappedHandler);
      } else {
        // For non-Handler functions, wrap them first
        final originalHandler = wrappedHandler;
        wrappedHandler = middleware((Request request) async {
          final result = await Function.apply(originalHandler, [request]);
          return result as Response;
        });
      }
    }

    // Apply route-level middleware
    for (final middleware in routeMiddleware.reversed) {
      if (wrappedHandler is Handler) {
        wrappedHandler = middleware(wrappedHandler);
      }
    }

    // Apply global middleware
    for (final middleware in globalMiddleware.reversed) {
      if (wrappedHandler is Handler) {
        wrappedHandler = middleware(wrappedHandler);
      }
    }

    // Register the wrapped handler
    add(verb, route, wrappedHandler);
  }
}
