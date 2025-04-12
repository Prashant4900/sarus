import 'package:sarus/sarus.dart';

/// Base Router Interface
abstract class RouterInterface {
  /// Map of HTTP methods to route handlers
  Map<String, Map<String, Handler>> get routes;

  /// Configures the routes for this router
  void configureRoutes();
}

/// Feature Router base class that all feature routers should extend
class FeatureRouter implements RouterInterface {
  /// Creates a new FeatureRouter and configures its routes
  FeatureRouter() {
    configureRoutes();
  }
  @override
  final Map<String, Map<String, Handler>> routes = {};

  @override
  void configureRoutes() {
    // To be implemented by subclasses
  }

  /// Registers a new route handler for the specified HTTP method and path.
  ///
  /// Normalizes the path by ensuring it starts with '/' and removing trailing slashes.
  void addRoute(Method method, String path, Handler handler) {
    // Normalize the path
    var normalizedPath = path.startsWith('/') ? path : '/$path';
    if (normalizedPath.length > 1 && normalizedPath.endsWith('/')) {
      normalizedPath = normalizedPath.substring(0, normalizedPath.length - 1);
    }

    // Initialize the map for this method if it doesn't exist
    routes[method.name] ??= {};

    // Add the route handler with the normalized path
    routes[method.name]![normalizedPath] = handler;
  }
}
