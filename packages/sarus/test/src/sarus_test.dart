import 'dart:async';
import 'dart:developer';

import 'package:shelf/shelf.dart' as shelf;

// Original RouterEntry implementation
class OriginalRouterEntry {
  factory OriginalRouterEntry(
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
        patternBuffer.write('(${match[3] ?? '[^/]+'})');
      }
    }

    final routePattern = RegExp('^$patternBuffer\$');

    return OriginalRouterEntry._(
      verb,
      route,
      handler,
      middleware,
      routePattern,
      params,
    );
  }

  OriginalRouterEntry._(
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
    if (match == null) {
      return null;
    }

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
      ]) as shelf.Response;
    })(modifiedRequest);
  }
}

// Optimized RouterEntry implementation
class OptimizedRouterEntry {
  factory OptimizedRouterEntry(
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
        patternBuffer.write('(${match[3] ?? '[^/]+'})');
      }
    }

    final routePattern = RegExp('^$patternBuffer\$');

    final hasParams = params.isNotEmpty;
    final isShelfHandler = handler is shelf.Handler;
    final fixedParams =
        hasParams ? List<String>.filled(params.length, '') : null;

    return OptimizedRouterEntry._(
      verb,
      route,
      handler,
      middleware,
      routePattern,
      params,
      hasParams,
      isShelfHandler,
      fixedParams,
    );
  }

  OptimizedRouterEntry._(
    this.verb,
    this.route,
    this._handler,
    this._middleware,
    this._routePattern,
    this._params,
    this._hasParams,
    this._isShelfHandler,
    this._fixedParams,
  );

  static final RegExp _parser = RegExp(r'([^<]*)(?:<([^>|]+)(?:\|([^>]*))?>)?');

  final String verb;
  final String route;
  final Function _handler;
  final shelf.Middleware _middleware;
  final RegExp _routePattern;
  final List<String> _params;
  final bool _hasParams;
  final bool _isShelfHandler;
  final List<String>? _fixedParams;

  List<String> get params => _params.toList();

  Map<String, String>? match(String path) {
    final match = _routePattern.firstMatch(path);
    if (match == null) {
      return null;
    }

    if (!_hasParams) {
      return const <String, String>{};
    }

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
      if (_isShelfHandler || !_hasParams) {
        return await _handler(request) as shelf.Response;
      }

      final paramValues = _fixedParams!;
      for (var i = 0; i < _params.length; i++) {
        paramValues[i] = params[_params[i]]!;
      }

      return await Function.apply(_handler, [
        request,
        ...paramValues,
      ]) as shelf.Response;
    })(modifiedRequest);
  }
}

// Benchmark utilities
class BenchmarkResult {
  BenchmarkResult(this.name, this.iterations, this.totalMicroseconds)
      : avgMicroseconds = totalMicroseconds / iterations;
  final String name;
  final int iterations;
  final int totalMicroseconds;
  final double avgMicroseconds;

  @override
  String toString() {
    return '$name: ${avgMicroseconds.toStringAsFixed(2)}μs avg ($iterations iterations)';
  }
}

Future<BenchmarkResult> benchmark(String name, Function fn,
    {int iterations = 100000}) async {
  // Warmup
  for (var i = 0; i < 1000; i++) {
    await fn();
  }

  // Actual benchmark
  final stopwatch = Stopwatch()..start();
  for (var i = 0; i < iterations; i++) {
    await fn();
  }
  stopwatch.stop();

  return BenchmarkResult(name, iterations, stopwatch.elapsedMicroseconds);
}

// Test scenarios
Future<void> main() async {
  log('RouterEntry Performance Benchmark');
  log('===================================\n');

  // Test handlers
  Future<shelf.Response> simpleHandler(shelf.Request req) async =>
      shelf.Response.ok('OK');
  Future<shelf.Response> paramHandler(
          shelf.Request req, String id, String name) async =>
      shelf.Response.ok('ID: $id, Name: $name');

  // Create test routes
  final originalSimple = OriginalRouterEntry('GET', '/simple', simpleHandler);
  final optimizedSimple = OptimizedRouterEntry('GET', '/simple', simpleHandler);

  final originalParam =
      OriginalRouterEntry('GET', '/users/<id>/posts/<name>', paramHandler);
  final optimizedParam =
      OptimizedRouterEntry('GET', '/users/<id>/posts/<name>', paramHandler);

  // Create test request
  final request = shelf.Request('GET', Uri.parse('http://localhost/test'));

  log('1. Route Matching (Simple Route - No Parameters)');
  log('-' * 50);

  final originalSimpleMatch =
      await benchmark('Original Simple Match', () async {
    originalSimple.match('/simple');
  });

  final optimizedSimpleMatch =
      await benchmark('Optimized Simple Match', () async {
    optimizedSimple.match('/simple');
  });

  log(originalSimpleMatch.toString());
  log(optimizedSimpleMatch.toString());

  final simpleMatchImprovement = (originalSimpleMatch.avgMicroseconds -
          optimizedSimpleMatch.avgMicroseconds) /
      originalSimpleMatch.avgMicroseconds *
      100;
  log('Improvement: ${simpleMatchImprovement.toStringAsFixed(1)}%\n');

  log('2. Route Matching (Parameterized Route)');
  log('-' * 50);

  final originalParamMatch = await benchmark('Original Param Match', () async {
    originalParam.match('/users/123/posts/hello');
  });

  final optimizedParamMatch =
      await benchmark('Optimized Param Match', () async {
    optimizedParam.match('/users/123/posts/hello');
  });

  log(originalParamMatch.toString());
  log(optimizedParamMatch.toString());

  final paramMatchImprovement = (originalParamMatch.avgMicroseconds -
          optimizedParamMatch.avgMicroseconds) /
      originalParamMatch.avgMicroseconds *
      100;
  print('Improvement: ${paramMatchImprovement.toStringAsFixed(1)}%\n');

  print('3. Route Invocation (Simple Handler)');
  print('-' * 50);

  final originalSimpleInvoke =
      await benchmark('Original Simple Invoke', () async {
    await originalSimple.invoke(request, {});
  });

  final optimizedSimpleInvoke =
      await benchmark('Optimized Simple Invoke', () async {
    await optimizedSimple.invoke(request, {});
  });

  print(originalSimpleInvoke);
  print(optimizedSimpleInvoke);

  final simpleInvokeImprovement = (originalSimpleInvoke.avgMicroseconds -
          optimizedSimpleInvoke.avgMicroseconds) /
      originalSimpleInvoke.avgMicroseconds *
      100;
  print('Improvement: ${simpleInvokeImprovement.toStringAsFixed(1)}%\n');

  print('4. Route Invocation (Parameterized Handler)');
  print('-' * 50);

  final params = {'id': '123', 'name': 'hello'};

  final originalParamInvoke =
      await benchmark('Original Param Invoke', () async {
    await originalParam.invoke(request, params);
  });

  final optimizedParamInvoke =
      await benchmark('Optimized Param Invoke', () async {
    await optimizedParam.invoke(request, params);
  });

  print(originalParamInvoke);
  print(optimizedParamInvoke);

  final paramInvokeImprovement = (originalParamInvoke.avgMicroseconds -
          optimizedParamInvoke.avgMicroseconds) /
      originalParamInvoke.avgMicroseconds *
      100;
  print('Improvement: ${paramInvokeImprovement.toStringAsFixed(1)}%\n');

  print('5. Overall Performance Summary');
  print('-' * 50);
  print(
      'Simple Route Matching: ${simpleMatchImprovement.toStringAsFixed(1)}% faster');
  print(
      'Parameterized Route Matching: ${paramMatchImprovement.toStringAsFixed(1)}% faster');
  print(
      'Simple Handler Invocation: ${simpleInvokeImprovement.toStringAsFixed(1)}% faster');
  print(
      'Parameterized Handler Invocation: ${paramInvokeImprovement.toStringAsFixed(1)}% faster');

  final avgImprovement = (simpleMatchImprovement +
          paramMatchImprovement +
          simpleInvokeImprovement +
          paramInvokeImprovement) /
      4;
  print(
      '\nAverage Performance Improvement: ${avgImprovement.toStringAsFixed(1)}%');
}
