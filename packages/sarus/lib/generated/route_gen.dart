import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:sarus/sarus.dart';
import 'package:source_gen/source_gen.dart';

class RouteGenerator extends GeneratorForAnnotation<Endpoint> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    final endpointPath = annotation.read('path').stringValue;
    final endpointMiddleware = _extractMiddlewareFromAnnotation(annotation);

    final buffer = StringBuffer();

    // Create the part of directive
    buffer.writeln('// ignore_for_file: type=lint');
    buffer.writeln();

    // Generate correct function name with camelCase
    final formattedClassName = className.isNotEmpty
        ? className[0].toLowerCase() + className.substring(1)
        : className;

    // Generate the router function
    buffer.writeln(
      'RouterConfig _\$${formattedClassName}RouterConfig($className endpoints) {',
    );
    buffer.writeln('  final routerConfig = RouterConfig();');
    buffer.writeln();

    // Generate endpoint middleware extraction method if middleware exists
    if (endpointMiddleware.isNotEmpty) {
      buffer.writeln('  // Extract endpoint-level middleware');
      buffer.writeln(
        '  final endpointMiddleware = endpoints._getEndpointMiddleware();',
      );
      buffer.writeln();
    }

    // Process all methods with route annotations
    for (final method in element.methods) {
      _processMethodAnnotations(
        buffer,
        method,
        endpointPath,
        endpointMiddleware.isNotEmpty,
      );
    }

    buffer.writeln();
    buffer.writeln('  return routerConfig;');
    buffer.writeln('}');

    // Generate the middleware extraction extension if needed
    if (endpointMiddleware.isNotEmpty) {
      _generateMiddlewareExtension(buffer, className, endpointMiddleware);
    }

    // Generate individual route registration methods
    _generateRouteRegistrationMethods(buffer, element, endpointPath);

    // Format the generated code
    final formatter =
        DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
    return formatter.format(buffer.toString());
  }

  void _processMethodAnnotations(
    StringBuffer buffer,
    MethodElement method,
    String endpointPath,
    bool hasEndpointMiddleware,
  ) {
    final annotations = [
      ('get', _getAnnotationOfType<Get>(method)),
      ('post', _getAnnotationOfType<Post>(method)),
      ('put', _getAnnotationOfType<Put>(method)),
      ('delete', _getAnnotationOfType<Delete>(method)),
      ('patch', _getAnnotationOfType<Patch>(method)),
      ('options', _getAnnotationOfType<Options>(method)),
      ('head', _getAnnotationOfType<Head>(method)),
    ];

    for (final (httpMethod, annotationReader) in annotations) {
      if (annotationReader != null) {
        final methodPath = annotationReader.read('path').stringValue;
        final methodMiddleware =
            _extractMiddlewareFromAnnotation(annotationReader);

        _generateRouteRegistration(
          buffer,
          httpMethod,
          methodPath,
          endpointPath,
          method.name,
          methodMiddleware,
          hasEndpointMiddleware,
        );
      }
    }
  }

  ConstantReader? _getAnnotationOfType<T>(MethodElement method) {
    final annotations = TypeChecker.fromRuntime(T)
        .annotationsOf(method, throwOnUnresolved: false);

    if (annotations.isEmpty) {
      return null;
    }

    return ConstantReader(annotations.first);
  }

  List<String> _extractMiddlewareFromAnnotation(ConstantReader annotation) {
    try {
      final middlewareReader = annotation.read('middlewares');
      if (middlewareReader.isNull) {
        return [];
      }

      final middlewareList = middlewareReader.listValue;
      final middlewareNames = <String>[];

      for (var i = 0; i < middlewareList.length; i++) {
        // For now, we'll generate placeholder middleware references
        // In a real implementation, you'd need to resolve the actual middleware references
        middlewareNames.add('_middleware$i');
      }

      return middlewareNames;
    } catch (e) {
      // If middleware reading fails, return empty list
      return [];
    }
  }

  void _generateRouteRegistration(
    StringBuffer buffer,
    String httpMethod,
    String methodPath,
    String? endpointPath,
    String handlerName,
    List<String> methodMiddleware,
    bool hasEndpointMiddleware,
  ) {
    final basePath = (endpointPath ?? '').trim();
    final routePath = methodPath.trim();

    // Concatenate paths safely, ensuring only one slash between parts
    final fullPath = '/${[
      basePath,
      routePath,
    ].where((segment) => segment.isNotEmpty).map((s) => s.startsWith('/') ? s.substring(1) : s).join('/')}';

    // If no middleware, use simple registration
    if (methodMiddleware.isEmpty && !hasEndpointMiddleware) {
      buffer.writeln(
        "  routerConfig.$httpMethod('$fullPath', endpoints.$handlerName);",
      );
      return;
    }

    // Generate route registration with middleware
    buffer.writeln('  // Register $httpMethod $fullPath with middleware');
    buffer.writeln('  _register${_capitalize(handlerName)}Route(');
    buffer.writeln('    routerConfig,');
    buffer.writeln('    endpoints,');
    if (hasEndpointMiddleware) {
      buffer.writeln('    endpointMiddleware,');
    }
    buffer.writeln('  );');
    buffer.writeln();
  }

  void _generateRouteRegistrationMethods(
    StringBuffer buffer,
    ClassElement element,
    String endpointPath,
  ) {
    buffer.writeln();
    buffer.writeln('// Individual route registration methods');

    for (final method in element.methods) {
      final annotations = [
        ('get', _getAnnotationOfType<Get>(method)),
        ('post', _getAnnotationOfType<Post>(method)),
        ('put', _getAnnotationOfType<Put>(method)),
        ('delete', _getAnnotationOfType<Delete>(method)),
        ('patch', _getAnnotationOfType<Patch>(method)),
        ('options', _getAnnotationOfType<Options>(method)),
        ('head', _getAnnotationOfType<Head>(method)),
      ];

      for (final (httpMethod, annotationReader) in annotations) {
        if (annotationReader != null) {
          final methodPath = annotationReader.read('path').stringValue;
          final methodMiddleware =
              _extractMiddlewareFromAnnotation(annotationReader);

          if (methodMiddleware.isNotEmpty) {
            _generateIndividualRouteMethod(
              buffer,
              element.name,
              httpMethod,
              methodPath,
              endpointPath,
              method.name,
              methodMiddleware,
            );
          }
        }
      }
    }
  }

  void _generateIndividualRouteMethod(
    StringBuffer buffer,
    String className,
    String httpMethod,
    String methodPath,
    String? endpointPath,
    String handlerName,
    List<String> methodMiddleware,
  ) {
    final basePath = (endpointPath ?? '').trim();
    final routePath = methodPath.trim();

    final fullPath = '/${[
      basePath,
      routePath,
    ].where((segment) => segment.isNotEmpty).map((s) => s.startsWith('/') ? s.substring(1) : s).join('/')}';

    buffer.writeln();
    buffer.writeln('/// Register the $handlerName route with its middleware');
    buffer.writeln('void _register${_capitalize(handlerName)}Route(');
    buffer.writeln('  RouterConfig routerConfig,');
    buffer.writeln('  $className endpoints,');
    buffer.writeln('  List<Middleware> endpointMiddleware,');
    buffer.writeln(') {');

    // Generate method-level middleware
    if (methodMiddleware.isNotEmpty) {
      buffer.writeln(
        '  // Method-level middleware from @${_capitalize(httpMethod)} annotation',
      );
      buffer.writeln('  final methodMiddleware = <Middleware>[');
      for (final middleware in methodMiddleware) {
        buffer.writeln('    $middleware,');
      }
      buffer.writeln('  ];');
      buffer.writeln();
    }

    // Combine middleware
    buffer.writeln('  // Combine all middleware layers');
    buffer
        .writeln('  final allMiddleware = MiddlewareUtils.combineMiddleware(');
    buffer.writeln('    endpoint: endpointMiddleware,');
    if (methodMiddleware.isNotEmpty) {
      buffer.writeln('    route: methodMiddleware,');
    }
    buffer.writeln('  );');
    buffer.writeln();

    // Create wrapped handler
    buffer.writeln('  // Create wrapped handler with middleware');
    buffer.writeln('  Handler wrappedHandler = (Request request) async {');
    buffer.writeln('    return await endpoints.$handlerName(request);');
    buffer.writeln('  };');
    buffer.writeln();

    // Apply middleware
    buffer.writeln('  // Apply middleware');
    buffer.writeln(
      '  wrappedHandler = MiddlewareUtils.applyMiddleware(wrappedHandler, allMiddleware);',
    );
    buffer.writeln();

    // Register the route
    buffer.writeln('  // Register the route');
    buffer.writeln("  routerConfig.$httpMethod('$fullPath', wrappedHandler);");
    buffer.writeln('}');
  }

  void _generateMiddlewareExtension(
    StringBuffer buffer,
    String className,
    List<String> endpointMiddleware,
  ) {
    buffer.writeln();
    buffer.writeln(
      '/// Extension to help extract middleware from endpoint annotations',
    );
    buffer.writeln('extension _${className}Middleware on $className {');
    buffer.writeln('  List<Middleware> _getEndpointMiddleware() {');
    buffer.writeln('    // Extract middleware from @Endpoint annotation');
    if (endpointMiddleware.isNotEmpty) {
      buffer.writeln('    return <Middleware>[');
      for (final middleware in endpointMiddleware) {
        buffer.writeln('      $middleware,');
      }
      buffer.writeln('    ];');
    } else {
      buffer.writeln('    return <Middleware>[];');
    }
    buffer.writeln('  }');
    buffer.writeln('}');
  }

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
  }
}
