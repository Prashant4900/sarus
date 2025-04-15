import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

/// Check if the [regexp] is non-capturing.
bool _isNoCapture(String regexp) {
  // Construct a new regular expression matching anything containing regexp,
  // then match with empty-string and count number of groups.
  return RegExp('^(?:$regexp)|.*\$').firstMatch('')!.groupCount == 0;
}

/// Entry in the router.
///
/// This class implements the logic for matching the path pattern.
class RouterEntry {
  factory RouterEntry(
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
    for (final m in _parser.allMatches(route)) {
      patternBuffer.write(RegExp.escape(m[1]!));
      if (m[2] != null) {
        params.add(m[2]!);
        if (m[3] != null && !_isNoCapture(m[3]!)) {
          throw ArgumentError.value(
            route,
            'route',
            'expression for "${m[2]}" is capturing',
          );
        }
        patternBuffer.write('(${m[3] ?? '[^/]+'})');
      }
    }
    final routePattern = RegExp('^$patternBuffer\$');

    return RouterEntry._(
      verb,
      route,
      handler,
      middleware,
      routePattern,
      params,
    );
  } // exposed for using generator.

  RouterEntry._(
    this.verb,
    this.route,
    this._handler,
    this._middleware,
    this._routePattern,
    this._params,
  );

  /// Pattern for parsing the route pattern
  static final RegExp _parser = RegExp(r'([^<]*)(?:<([^>|]+)(?:\|([^>]*))?>)?');

  final String verb;
  final String route;
  final Function _handler;
  final shelf.Middleware _middleware;

  /// Expression that the request path must match.
  ///
  /// This also captures any parameters in the route pattern.
  final RegExp _routePattern;

  /// Names for the parameters in the route pattern.
  final List<String> _params;

  /// List of parameter names in the route pattern.
  List<String> get params => _params.toList();

  /// Returns a map from parameter name to value, if the path matches the
  /// route pattern. Otherwise returns null.
  Map<String, String>? match(String path) {
    // Check if path matches the route pattern
    final m = _routePattern.firstMatch(path);
    if (m == null) {
      return null;
    }
    // Construct map from parameter name to matched value
    final params = <String, String>{};
    for (var i = 0; i < _params.length; i++) {
      // first group is always the full match, we ignore this group.
      params[_params[i]] = m[i + 1]!;
    }
    return params;
  }

  // invoke handler with given request and params
  Future<shelf.Response> invoke(
    shelf.Request request,
    Map<String, String> params,
  ) async {
    final modifiedRequest =
        request.change(context: {'shelf_router/params': params});

    return await _middleware((request) async {
      if (_handler is shelf.Handler || _params.isEmpty) {
        // ignore: avoid_dynamic_calls
        return await _handler(request) as shelf.Response;
      }
      return await Function.apply(_handler, [
        request,
        ..._params.map((n) => params[n]),
      ]) as shelf.Response;
    })(modifiedRequest);
  }
}
