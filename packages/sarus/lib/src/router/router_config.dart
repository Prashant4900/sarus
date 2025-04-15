import 'dart:collection' show UnmodifiableMapView;
import 'dart:convert';

import 'package:http_methods/http_methods.dart' show isHttpMethod;
import 'package:meta/meta.dart' show sealed;
import 'package:sarus/src/router/router_entry.dart' show RouterEntry;
import 'package:shelf/shelf.dart' as shelf;

final _emptyParams = UnmodifiableMapView(<String, String>{});

extension RouterParams on shelf.Request {
  /// Get URL parameters captured by the [RouterConfig].
  /// If no parameters are captured this returns an empty map.
  ///
  /// The returned map is unmodifiable.
  Map<String, String> get params {
    final p = context['shelf_router/params'];
    if (p is Map<String, String>) {
      return UnmodifiableMapView(p);
    }
    return _emptyParams;
  }
}

/// Middleware to remove body from request.
final _removeBody = shelf.createMiddleware(
  responseHandler: (r) {
    if (r.headers.containsKey('content-length')) {
      r = r.change(headers: {'content-length': '0'});
    }
    return r.change(body: <int>[]);
  },
);

/// A shelf [RouterConfig] routes requests to handlers based on HTTP verb and route
/// pattern.
///
/// If multiple routes match the same request, the handler for the first
/// route is called.
/// If no route matches a request, a [shelf.Response.notFound] will be returned
/// instead. The default matcher can be overridden with the `notFoundHandler`
/// constructor parameter.
@sealed
class RouterConfig {
  /// Creates a new [RouterConfig] routing requests to handlers.
  ///
  /// The [notFoundHandler] will be invoked for requests where no matching route
  /// was found. By default, a simple [shelf.Response.notFound] will be used instead.
  RouterConfig({shelf.Handler notFoundHandler = _defaultNotFound})
      : _notFoundHandler = notFoundHandler;
  final List<RouterEntry> _routes = [];
  final shelf.Handler _notFoundHandler;

  /// Add [handler] for [verb] requests to [route].
  ///
  /// If [verb] is `GET` the [handler] will also be called for `HEAD` requests
  /// matching [route]. This is because handling `GET` requests without handling
  /// `HEAD` is always wrong. To explicitely implement a `HEAD` handler it must
  /// be registered before the `GET` handler.
  void add(String verb, String route, Function handler) {
    if (!isHttpMethod(verb)) {
      throw ArgumentError.value(verb, 'verb', 'expected a valid HTTP method');
    }

    if (verb.toUpperCase() == 'GET') {
      // Handling in a 'GET' request without handling a 'HEAD' request is always
      // wrong, thus, we add a default implementation that discards the body.
      _routes.add(RouterEntry('HEAD', route, handler, middleware: _removeBody));
    }
    _routes.add(RouterEntry(verb, route, handler));
  }

  /// Handle all request to [route] using [handler].
  void all(String route, Function handler) {
    _routes.add(RouterEntry('ALL', route, handler));
  }

  /// Mount a handler below a prefix.
  ///
  /// In this case prefix may not contain any parameters, nor
  void mount(String prefix, shelf.Handler handler) {
    if (!prefix.startsWith('/')) {
      throw ArgumentError.value(prefix, 'prefix', 'must start with a slash');
    }

    // first slash is always in request.handlerPath
    final path = prefix.substring(1);
    if (prefix.endsWith('/')) {
      all('$prefix<path|[^]*>', (shelf.Request request) {
        return handler(request.change(path: path));
      });
    } else {
      all(prefix, (shelf.Request request) {
        return handler(request.change(path: path));
      });
      all('$prefix/<path|[^]*>', (shelf.Request request) {
        return handler(request.change(path: '$path/'));
      });
    }
  }

  /// Route incoming requests to registered handlers.
  ///
  /// This method allows a Router instance to be a [shelf.Handler].
  Future<shelf.Response> call(shelf.Request request) async {
    // Note: this is a great place to optimize the implementation by building
    //       a trie for faster matching... left as an exercise for the reader :)
    for (final route in _routes) {
      if (route.verb != request.method.toUpperCase() && route.verb != 'ALL') {
        continue;
      }
      final params = route.match('/${request.url.path}');
      if (params != null) {
        final response = await route.invoke(request, params);
        if (response != routeNotFound) {
          return response;
        }
      }
    }
    return _notFoundHandler(request);
  }

  // Handlers for all methods

  /// Handle `GET` request to [route] using [handler].
  ///
  /// If no matching handler for `HEAD` requests is registered, such requests
  /// will also be routed to the [handler] registered here.
  void get(String route, Function handler) => add('GET', route, handler);

  /// Handle `HEAD` request to [route] using [handler].
  void head(String route, Function handler) => add('HEAD', route, handler);

  /// Handle `POST` request to [route] using [handler].
  void post(String route, Function handler) => add('POST', route, handler);

  /// Handle `PUT` request to [route] using [handler].
  void put(String route, Function handler) => add('PUT', route, handler);

  /// Handle `DELETE` request to [route] using [handler].
  void delete(String route, Function handler) => add('DELETE', route, handler);

  /// Handle `CONNECT` request to [route] using [handler].
  void connect(String route, Function handler) =>
      add('CONNECT', route, handler);

  /// Handle `OPTIONS` request to [route] using [handler].
  void options(String route, Function handler) =>
      add('OPTIONS', route, handler);

  /// Handle `TRACE` request to [route] using [handler].
  void trace(String route, Function handler) => add('TRACE', route, handler);

  /// Handle `PATCH` request to [route] using [handler].
  void patch(String route, Function handler) => add('PATCH', route, handler);

  static shelf.Response _defaultNotFound(shelf.Request request) =>
      routeNotFound;

  static final shelf.Response routeNotFound = _RouteNotFoundResponse();
}

/// Extends [shelf.Response] to allow it to be used multiple times in the
/// actual content being served.
class _RouteNotFoundResponse extends shelf.Response {
  _RouteNotFoundResponse() : super.notFound(_message);
  static const _message = 'Route not found';
  static final _messageBytes = utf8.encode(_message);

  @override
  Stream<List<int>> read() => Stream<List<int>>.value(_messageBytes);

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
