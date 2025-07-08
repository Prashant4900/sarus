import 'dart:collection' show UnmodifiableMapView;
import 'dart:convert';
import 'dart:typed_data';

import 'package:http_methods/http_methods.dart' show isHttpMethod;
import 'package:meta/meta.dart' show sealed;
import 'package:sarus/src/router/router_entry.dart' show RouterEntry;
import 'package:shelf/shelf.dart' as shelf;

/// Pre-allocated empty parameters map to avoid repeated allocations
final UnmodifiableMapView<String, String> _emptyParams =
    UnmodifiableMapView(<String, String>{});

/// Extension to add parameter extraction functionality to shelf.Request
extension RouterParams on shelf.Request {
  /// Extract URL parameters captured by the RouterConfig during route matching.
  ///
  /// Returns an unmodifiable map containing all captured route parameters.
  /// If no parameters were captured, returns an empty map.
  ///
  /// Example:
  /// For route '/users/<id>' matching '/users/123', this returns {'id': '123'}
  Map<String, String> get params {
    final p = context['shelf_router/params'];
    if (p is Map<String, String>) {
      return UnmodifiableMapView(p);
    }
    return _emptyParams;
  }
}

/// Middleware that removes the response body and sets content-length to 0.
/// Used internally for HEAD request handling to comply with HTTP specifications.
final shelf.Middleware _removeBody = shelf.createMiddleware(
  responseHandler: (r) {
    if (r.headers.containsKey('content-length')) {
      r = r.change(headers: {'content-length': '0'});
    }
    return r.change(body: <int>[]);
  },
);

/// A HTTP request router that matches incoming requests to registered handlers
/// based on HTTP method and route patterns.
///
/// The router processes routes in registration order and returns the response
/// from the first matching route. If no routes match, returns a 404 response.
///
/// Features:
/// - Supports all standard HTTP methods (GET, POST, PUT, DELETE, etc.)
/// - Automatic HEAD request handling for GET routes
/// - Route parameter extraction (e.g., '/users/<id>')
/// - Route mounting for sub-applications
/// - Customizable 404 handling
@sealed
class RouterConfig {
  /// Creates a new RouterConfig instance.
  ///
  /// [notFoundHandler] - Custom handler for unmatched requests.
  /// Defaults to returning a simple 404 "Route not found" response.
  RouterConfig({shelf.Handler notFoundHandler = _defaultNotFound})
      : _notFoundHandler = notFoundHandler;

  /// Internal list storing all registered routes in order of registration
  final List<RouterEntry> _routes = [];

  /// Handler called when no routes match the incoming request
  final shelf.Handler _notFoundHandler;

  /// Register a handler for a specific HTTP method and route pattern.
  ///
  /// [verb] - HTTP method (GET, POST, PUT, DELETE, etc.)
  /// [route] - Route pattern supporting parameters (e.g., '/users/<id>')
  /// [handler] - Function to handle matching requests
  ///
  /// Special behavior for GET requests:
  /// - Automatically registers a HEAD handler that returns the same response
  ///   but with an empty body (HTTP specification requirement)
  void add(String verb, String route, Function handler) {
    if (!isHttpMethod(verb)) {
      throw ArgumentError.value(verb, 'verb', 'expected a valid HTTP method');
    }

    // HTTP specification requires HEAD support for all GET endpoints
    if (verb.toUpperCase() == 'GET') {
      _routes.add(RouterEntry('HEAD', route, handler, middleware: _removeBody));
    }
    _routes.add(RouterEntry(verb, route, handler));
  }

  /// Register a handler that responds to ALL HTTP methods for the given route.
  ///
  /// [route] - Route pattern supporting parameters
  /// [handler] - Function to handle requests with any HTTP method
  void all(String route, Function handler) {
    _routes.add(RouterEntry('ALL', route, handler));
  }

  /// Mount a sub-handler under a URL prefix.
  ///
  /// This allows composing applications by mounting sub-routers or handlers
  /// under specific path prefixes.
  ///
  /// [prefix] - URL prefix (must start with '/')
  /// [handler] - Handler to process requests under this prefix
  ///
  /// Examples:
  /// - mount('/api', apiRouter) - All /api/* requests go to apiRouter
  /// - mount('/static', staticFileHandler) - Serve static files under /static
  void mount(String prefix, shelf.Handler handler) {
    if (!prefix.startsWith('/')) {
      throw ArgumentError.value(prefix, 'prefix', 'must start with a slash');
    }

    // Remove leading slash since it's included in request.handlerPath
    final path = prefix.substring(1);

    if (prefix.endsWith('/')) {
      // Handle prefix ending with slash
      all('$prefix<path|[^]*>', (shelf.Request request) {
        return handler(request.change(path: path));
      });
    } else {
      // Handle exact prefix match
      all(prefix, (shelf.Request request) {
        return handler(request.change(path: path));
      });
      // Handle prefix with additional path segments
      all('$prefix/<path|[^]*>', (shelf.Request request) {
        return handler(request.change(path: '$path/'));
      });
    }
  }

  /// Main request handler - routes incoming requests to registered handlers.
  ///
  /// This method makes RouterConfig instances usable as shelf.Handler.
  /// It iterates through registered routes in order and returns the response
  /// from the first matching route.
  ///
  /// Returns 404 response if no routes match.
  Future<shelf.Response> call(shelf.Request request) async {
    // Iterate through routes in registration order
    for (final route in _routes) {
      // Check if HTTP method matches (or route accepts ALL methods)
      if (route.verb != request.method.toUpperCase() && route.verb != 'ALL') {
        continue;
      }

      // Attempt to match the route pattern against request path
      final params = route.match('/${request.url.path}');
      if (params != null) {
        // Route matched - invoke the handler
        final response = await route.invoke(request, params);
        if (response != routeNotFound) {
          return response;
        }
      }
    }

    // No routes matched - return 404
    return _notFoundHandler(request);
  }

  // ============================================================================
  // HTTP Method Convenience Handlers
  //
  // These methods provide a convenient API for registering handlers for
  // specific HTTP methods. They are thin wrappers around the add() method.
  // ============================================================================

  /// Register handler for GET requests.
  /// Also automatically handles HEAD requests (returns same response with empty body).
  void get(String route, Function handler) => add('GET', route, handler);

  /// Register handler for HEAD requests.
  void head(String route, Function handler) => add('HEAD', route, handler);

  /// Register handler for POST requests.
  void post(String route, Function handler) => add('POST', route, handler);

  /// Register handler for PUT requests.
  void put(String route, Function handler) => add('PUT', route, handler);

  /// Register handler for DELETE requests.
  void delete(String route, Function handler) => add('DELETE', route, handler);

  /// Register handler for CONNECT requests.
  void connect(String route, Function handler) =>
      add('CONNECT', route, handler);

  /// Register handler for OPTIONS requests.
  void options(String route, Function handler) =>
      add('OPTIONS', route, handler);

  /// Register handler for TRACE requests.
  void trace(String route, Function handler) => add('TRACE', route, handler);

  /// Register handler for PATCH requests.
  void patch(String route, Function handler) => add('PATCH', route, handler);

  /// Default 404 handler - returns the standard route not found response
  static shelf.Response _defaultNotFound(shelf.Request request) =>
      routeNotFound;

  /// Standard 404 response used throughout the router
  static final shelf.Response routeNotFound = _RouteNotFoundResponse();
}

/// Custom 404 response implementation that can be reused multiple times.
///
/// Extends shelf.Response to provide a reusable "Route not found" response
/// that doesn't consume the response stream on first read.
class _RouteNotFoundResponse extends shelf.Response {
  _RouteNotFoundResponse() : super.notFound(_message);

  static const _message = 'Route not found';
  static final Uint8List _messageBytes = utf8.encode(_message);

  /// Override read() to return a fresh stream each time
  /// This allows the response to be used multiple times
  @override
  Stream<List<int>> read() => Stream<List<int>>.value(_messageBytes);

  /// Override change() to maintain the default message when body is not specified
  @override
  shelf.Response change({
    Map<String, /* String | List<String> */ Object?>? headers,
    Map<String, Object?>? context,
    Object? body,
  }) {
    return super.change(
      headers: headers,
      context: context,
      body: body ?? _message,
    );
  }
}
