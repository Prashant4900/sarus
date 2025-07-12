import 'package:sarus/src/core/endpoint.dart';
import 'package:sarus/src/router/router_config.dart';
import 'package:shelf/shelf.dart';

// /// Cache for compiled middleware chains to avoid recompilation
// final Map<String, Handler> _middlewareCache = <String, Handler>{};

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

  /// Pre-compiled global middleware pipeline for reuse
  late final Pipeline _globalPipeline = _buildGlobalPipeline();

  /// Build the global middleware pipeline once
  Pipeline _buildGlobalPipeline() {
    var pipeline = const Pipeline();
    for (final middleware in globalMiddleware) {
      pipeline = pipeline.addMiddleware(middleware);
    }
    return pipeline;
  }

  // /// Create a cache key for middleware combination
  // String _createMiddlewareKey(List<Middleware> routeMiddlewares) {
  //   final routeKeys = routeMiddlewares.map((m) => m.hashCode).join(',');
  //   final globalKeys = globalMiddleware.map((m) => m.hashCode).join(',');
  //   return '$routeKeys|$globalKeys';
  // }

  /// Build middleware pipeline with caching
  Handler _buildMiddlewarePipeline(
    Handler baseHandler,
    List<Middleware> routeMiddlewares,
  ) {
    // If no middleware, return base handler
    if (routeMiddlewares.isEmpty && globalMiddleware.isEmpty) {
      return baseHandler;
    }

    // For simple cases with only global middleware
    if (routeMiddlewares.isEmpty) {
      return _globalPipeline.addHandler(baseHandler);
    }

    // Build combined pipeline
    var pipeline = const Pipeline();

    // Add route-specific middleware first
    for (final middleware in routeMiddlewares) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    // Add global middleware
    for (final middleware in globalMiddleware) {
      pipeline = pipeline.addMiddleware(middleware);
    }

    return pipeline.addHandler(baseHandler);
  }

  /// Registers all controllers defined in [routes].
  void registerEndpoints() {
    // Pre-validate all routes first
    _validateRoutes();

    for (final route in routes) {
      _registerRoute(route);
    }
  }

  /// Validate all routes before registration
  void _validateRoutes() {
    for (final route in routes) {
      if (!route.prefix.startsWith('/')) {
        throw ArgumentError(
          'Route prefix must start with a forward slash: ${route.prefix}',
        );
      }
    }
  }

  /// Register a single route with optimized middleware handling
  void _registerRoute(Route route) {
    try {
      for (final endpoint in route.endpoints) {
        // Build middleware pipeline for this endpoint
        final handlerWithMiddleware = _buildMiddlewarePipeline(
          endpoint.handler,
          route.middlewares,
        );

        // Mount the controller with its middleware
        router.mount(route.prefix, handlerWithMiddleware);
      }
    } catch (e) {
      // Add context to the error for better debugging
      throw Exception(
          'Failed to register route ${route.name ?? route.prefix}: $e');
    }
  }

  /// Returns the handler for this router.
  Handler get handler => _wrapWithErrorLogging(router.call);

  /// Wraps the router handler with error logging.
  Handler _wrapWithErrorLogging(Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } catch (e) {
        // In production, you might want to log this error
        // print('Router error for ${request.method} ${request.url}: $e');
        rethrow;
      }
    };
  }

  /// Convenience method to add a new route to this router after initialization.
  /// Returns the router instance for method chaining.
  void addRoute(Route route) {
    // Validate the route before adding
    if (!route.prefix.startsWith('/')) {
      throw ArgumentError(
        'Route prefix must start with a forward slash: ${route.prefix}',
      );
    }

    routes.add(route);
    _registerRoute(route);
  }

  /// Bulk add multiple routes efficiently
  void addRoutes(List<Route> newRoutes) {
    // Validate all routes first
    for (final route in newRoutes) {
      if (!route.prefix.startsWith('/')) {
        throw ArgumentError(
          'Route prefix must start with a forward slash: ${route.prefix}',
        );
      }
    }

    // Add all routes
    routes.addAll(newRoutes);

    // Register all routes
    for (final route in newRoutes) {
      _registerRoute(route);
    }
  }

  /// Get route information for debugging
  List<String> get routeInfo {
    return routes
        .map((r) => '${r.prefix} -> ${r.endpoints.length} endpoints')
        .toList();
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

  /// Lazy-computed hash for efficient comparison
  late final int _hashCode = Object.hash(
    Object.hashAll(endpoints),
    prefix,
    Object.hashAll(middlewares),
    name,
  );

  @override
  int get hashCode => _hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Route) return false;
    return prefix == other.prefix &&
        name == other.name &&
        _listEquals(endpoints, other.endpoints) &&
        _listEquals(middlewares, other.middlewares);
  }

  /// Helper method to compare lists
  bool _listEquals<T>(List<T> a, List<T> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  String toString() => 'Route($name: $prefix -> ${endpoints.length} endpoints)';
}
