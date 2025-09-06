part of '_internal.dart';

/// Pre-allocated empty parameters map to avoid repeated allocations
final UnmodifiableMapView<String, String> _emptyParams = UnmodifiableMapView(
  <String, String>{},
);

/// Extension to add parameter extraction functionality to shelf.Request
extension RouterParams on shelf.Request {
  Map<String, String> get params {
    final p = context['shelf_router/params'];
    if (p is Map<String, String>) {
      return UnmodifiableMapView(p);
    }
    return _emptyParams;
  }
}

/// Middleware that removes the response body and sets content-length to 0.
final shelf.Middleware _removeBody = shelf.createMiddleware(
  responseHandler: (r) {
    if (r.headers.containsKey('content-length')) {
      r = r.change(headers: {'content-length': '0'});
    }
    return r.change(body: <int>[]);
  },
);

/// A HTTP request router that matches incoming requests to registered handlers.
@sealed
class RouterConfig {
  RouterConfig({shelf.Handler notFoundHandler = _defaultNotFound})
    : _notFoundHandler = notFoundHandler;

  final List<_RouterEntry> _routes = [];
  final shelf.Handler _notFoundHandler;

  void add(String verb, String route, Function handler) {
    if (!isHttpMethod(verb)) {
      throw ArgumentError.value(verb, 'verb', 'expected a valid HTTP method');
    }
    if (verb.toUpperCase() == 'GET') {
      _routes.add(
        _RouterEntry('HEAD', route, handler, middleware: _removeBody),
      );
    }
    _routes.add(_RouterEntry(verb, route, handler));
  }

  void all(String route, Function handler) {
    _routes.add(_RouterEntry('ALL', route, handler));
  }

  void mount(String prefix, shelf.Handler handler) {
    if (!prefix.startsWith('/')) {
      throw ArgumentError.value(prefix, 'prefix', 'must start with a slash');
    }
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

  Future<shelf.Response> call(shelf.Request request) async {
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

  void get(String route, Function handler) => add('GET', route, handler);
  void head(String route, Function handler) => add('HEAD', route, handler);
  void post(String route, Function handler) => add('POST', route, handler);
  void put(String route, Function handler) => add('PUT', route, handler);
  void delete(String route, Function handler) => add('DELETE', route, handler);
  void connect(String route, Function handler) =>
      add('CONNECT', route, handler);
  void options(String route, Function handler) =>
      add('OPTIONS', route, handler);
  void trace(String route, Function handler) => add('TRACE', route, handler);
  void patch(String route, Function handler) => add('PATCH', route, handler);

  static shelf.Response _defaultNotFound(shelf.Request request) =>
      routeNotFound;

  static final shelf.Response routeNotFound = _RouteNotFoundResponse();
}

/// Custom 404 response reused multiple times.
class _RouteNotFoundResponse extends shelf.Response {
  _RouteNotFoundResponse() : super.notFound(_message);

  static const _message = 'Route not found';
  static final Uint8List _messageBytes = utf8.encode(_message);

  @override
  Stream<List<int>> read() => Stream<List<int>>.value(_messageBytes);

  @override
  shelf.Response change({
    Map<String, Object?>? headers,
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

/// Helper: Validate regex for non-capturing.
bool _isNoCapture(String regexp) {
  return RegExp('^(?:$regexp)|.*\$').firstMatch('')!.groupCount == 0;
}

/// Represents a single route entry in the router.
class _RouterEntry {
  factory _RouterEntry(
    String verb,
    String route,
    Function handler, {
    shelf.Middleware? middleware,
  }) {
    middleware = middleware ?? ((shelf.Handler fn) => fn);
    if (!route.startsWith('/')) {
      throw ArgumentError.value(
        route,
        'route',
        'expected route to start with a slash',
      );
    }
    final params = <String>[];
    final patternBuffer = StringBuffer();
    for (final match in _parser.allMatches(route)) {
      patternBuffer.write(RegExp.escape(match[1]!));
      if (match[2] != null) {
        params.add(match[2]!);
        if (match[3] != null && !_isNoCapture(match[3]!)) {
          throw ArgumentError.value(
            route,
            'route',
            'expression for "${match[2]}" is capturing',
          );
        }
        patternBuffer.write('(${match[3] ?? '[^/]+'})');
      }
    }
    final routePattern = RegExp('^$patternBuffer\$');
    return _RouterEntry._(
      verb,
      route,
      handler,
      middleware,
      routePattern,
      params,
    );
  }

  _RouterEntry._(
    this.verb,
    this.route,
    this._handler,
    this._middleware,
    this._routePattern,
    this._params,
  );

  static final RegExp _parser = RegExp(r'([^<]*)(?:<([^>|]+)(?:\|([^>]*))?>)?');

  final String verb;
  final String route;
  final Function _handler;
  final shelf.Middleware _middleware;
  final RegExp _routePattern;
  final List<String> _params;

  List<String> get params => _params.toList();

  Map<String, String>? match(String path) {
    final match = _routePattern.firstMatch(path);
    if (match == null) return null;
    final params = <String, String>{};
    for (var i = 0; i < _params.length; i++) {
      params[_params[i]] = match[i + 1]!;
    }
    return params;
  }

  Future<shelf.Response> invoke(
    shelf.Request request,
    Map<String, String> params,
  ) async {
    final modifiedRequest = request.change(
      context: {'shelf_router/params': params},
    );
    return await _middleware((request) async {
      if (_handler is shelf.Handler || _params.isEmpty) {
        return await _handler(request) as shelf.Response;
      }
      return await Function.apply(_handler, [
            request,
            ..._params.map((paramName) => params[paramName]),
          ])
          as shelf.Response;
    })(modifiedRequest);
  }
}

/// Higher-level Router API with route + middleware support.
class Router {
  Router({
    required this.endpoints,
  }) {
    registerEndpoints();
  }

  final List<Endpoints> endpoints;

  final RouterConfig router = RouterConfig();

  void registerEndpoints() {
    for (final route in endpoints) {
      final handlerWithMiddleware = route.handler;

      router.mount('/', handlerWithMiddleware);
    }
  }

  Handler get handler => _wrapWithErrorLogging(router.call);

  Handler _wrapWithErrorLogging(Handler innerHandler) {
    return (Request request) async {
      try {
        return await innerHandler(request);
      } catch (e) {
        rethrow;
      }
    };
  }
}
