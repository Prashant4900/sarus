import 'dart:async';

import 'package:shelf/shelf.dart' as shelf;

/// Validates if a regular expression pattern is non-capturing.
///
/// Non-capturing groups use (?:...) syntax and don't create numbered capture groups.
/// This is important for route parameters to avoid conflicts with our own capturing groups.
///
/// Returns true if the regexp doesn't create any capture groups.
bool _isNoCapture(String regexp) {
  // Create a test regex that wraps the input pattern
  // Match against empty string and count captured groups
  return RegExp('^(?:$regexp)|.*\$').firstMatch('')!.groupCount == 0;
}

/// Represents a single route entry in the router.
///
/// A RouterEntry encapsulates:
/// - HTTP method matching (GET, POST, etc.)
/// - URL pattern matching with parameter extraction
/// - Handler function invocation
/// - Middleware application
///
/// Example route patterns:
/// - '/users' - matches exactly '/users'
/// - '/users/<id>' - matches '/users/123' and captures id='123'
/// - '/files/<path|.*>' - matches '/files/docs/readme.txt' with custom regex
class RouterEntry {
  /// Creates a new RouterEntry by parsing the route pattern.
  ///
  /// [verb] - HTTP method (GET, POST, etc.) or 'ALL' for any method
  /// [route] - URL pattern with optional parameters in <param> or <param|regex> format
  /// [handler] - Function to handle matching requests
  /// [middleware] - Optional middleware to apply to this specific route
  ///
  /// Route pattern syntax:
  /// - Static segments: '/users/profile'
  /// - Parameters: '/users/<id>' (matches non-slash characters)
  /// - Custom patterns: '/files/<path|.*>' (matches any characters including slashes)
  ///
  /// Throws [ArgumentError] if:
  /// - Route doesn't start with '/'
  /// - Parameter regex uses capturing groups
  factory RouterEntry(
    String verb,
    String route,
    Function handler, {
    shelf.Middleware? middleware,
  }) {
    // Default to no-op middleware if none provided
    middleware = middleware ?? ((shelf.Handler fn) => fn);

    // Validate route format
    if (!route.startsWith('/')) {
      throw ArgumentError.value(
        route,
        'route',
        'expected route to start with a slash',
      );
    }

    // Parse route pattern and extract parameters
    final params = <String>[];
    final patternBuffer = StringBuffer();

    // Process each segment of the route pattern
    for (final match in _parser.allMatches(route)) {
      // Add literal text (escaped for regex)
      patternBuffer.write(RegExp.escape(match[1]!));

      // Process parameter if present
      if (match[2] != null) {
        params.add(match[2]!); // Parameter name

        // Validate custom regex doesn't use capturing groups
        if (match[3] != null && !_isNoCapture(match[3]!)) {
          throw ArgumentError.value(
            route,
            'route',
            'expression for "${match[2]}" is capturing',
          );
        }

        // Add parameter regex pattern (default: match non-slash characters)
        patternBuffer.write('(${match[3] ?? '[^/]+'})');
      }
    }

    // Create final regex pattern for route matching
    final routePattern = RegExp('^$patternBuffer\$');

    return RouterEntry._(
      verb,
      route,
      handler,
      middleware,
      routePattern,
      params,
    );
  }

  /// Private constructor used by factory constructor.
  /// Creates RouterEntry with pre-processed values.
  RouterEntry._(
    this.verb,
    this.route,
    this._handler,
    this._middleware,
    this._routePattern,
    this._params,
  );

  /// Regular expression for parsing route patterns.
  ///
  /// Matches:
  /// - Group 1: Literal text before parameter
  /// - Group 2: Parameter name (optional)
  /// - Group 3: Custom regex pattern (optional)
  ///
  /// Example: '/users/<id|\\d+>/posts' matches:
  /// - '/users/' (literal), 'id' (param), '\\d+' (custom regex)
  /// - '/posts' (literal), null, null
  static final RegExp _parser = RegExp(r'([^<]*)(?:<([^>|]+)(?:\|([^>]*))?>)?');

  /// HTTP method this route handles (GET, POST, etc.) or 'ALL'
  final String verb;

  /// Original route pattern string
  final String route;

  /// Handler function to invoke for matching requests
  final Function _handler;

  /// Middleware to apply to this route
  final shelf.Middleware _middleware;

  /// Compiled regular expression for matching request paths.
  /// Contains capture groups for extracting parameter values.
  final RegExp _routePattern;

  /// Ordered list of parameter names in the route pattern.
  /// Corresponds to capture groups in _routePattern.
  final List<String> _params;

  /// Returns a copy of parameter names for this route.
  /// Useful for introspection and debugging.
  List<String> get params => _params.toList();

  /// Attempts to match the given path against this route's pattern.
  ///
  /// Returns a map of parameter names to their captured values if the path matches.
  /// Returns null if the path doesn't match this route.
  ///
  /// Example:
  /// Route: '/users/<id>/posts/<postId>'
  /// Path: '/users/123/posts/456'
  /// Returns: {'id': '123', 'postId': '456'}
  Map<String, String>? match(String path) {
    // Test if path matches the compiled route pattern
    final match = _routePattern.firstMatch(path);
    if (match == null) {
      return null;
    }

    // Extract parameter values from regex capture groups
    final params = <String, String>{};
    for (var i = 0; i < _params.length; i++) {
      // Skip group 0 (full match), use groups 1+ for parameters
      params[_params[i]] = match[i + 1]!;
    }
    return params;
  }

  /// Invokes the handler function for this route.
  ///
  /// This method:
  /// 1. Adds route parameters to the request context
  /// 2. Applies route-specific middleware
  /// 3. Calls the handler with appropriate arguments
  /// 4. Returns the handler's response
  ///
  /// Handler functions can be:
  /// - shelf.Handler: (Request) -> Response
  /// - Parameterized: (Request, param1, param2, ...) -> Response
  Future<shelf.Response> invoke(
    shelf.Request request,
    Map<String, String> params,
  ) async {
    // Add parameters to request context for RouterParams extension
    final modifiedRequest = request.change(
      context: {'shelf_router/params': params},
    );

    // Apply middleware and invoke handler
    return await _middleware((request) async {
      // Handle simple shelf.Handler or routes without parameters
      if (_handler is shelf.Handler || _params.isEmpty) {
        return await _handler(request) as shelf.Response;
      }

      // Handle parameterized handlers by passing parameters as individual arguments
      return await Function.apply(_handler, [
            request,
            ..._params.map((paramName) => params[paramName]),
          ])
          as shelf.Response;
    })(modifiedRequest);
  }
}
