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
    final controllerPath = annotation.read('path').stringValue;
    final buffer = StringBuffer();

    // Create the part of directive
    // buffer.writeln('// Generated code - do not modify');
    buffer.writeln('// ignore_for_file: type=lint');
    buffer.writeln();

    // Generate correct function name with camelCase
    final formattedClassName = className.isNotEmpty
        ? className[0].toLowerCase() + className.substring(1)
        : className;

    // Generate the router function
    buffer.writeln(
      'RouterConfig _\$${formattedClassName}RouterConfig($className controller) {',
    );
    buffer.writeln('  final routerConfig = RouterConfig();');
    buffer.writeln();

    // Process all methods with route annotations
    for (final method in element.methods) {
      final getAnnotation = _getAnnotationOfType<Get>(method);
      final postAnnotation = _getAnnotationOfType<Post>(method);
      final putAnnotation = _getAnnotationOfType<Put>(method);
      final deleteAnnotation = _getAnnotationOfType<Delete>(method);

      if (getAnnotation != null) {
        _generateRouteRegistration(
          buffer,
          'get',
          getAnnotation.read('path').stringValue,
          controllerPath,
          method.name,
        );
      }

      if (postAnnotation != null) {
        _generateRouteRegistration(
          buffer,
          'post',
          postAnnotation.read('path').stringValue,
          controllerPath,
          method.name,
        );
      }

      if (putAnnotation != null) {
        _generateRouteRegistration(
          buffer,
          'put',
          putAnnotation.read('path').stringValue,
          controllerPath,
          method.name,
        );
      }

      if (deleteAnnotation != null) {
        _generateRouteRegistration(
          buffer,
          'delete',
          deleteAnnotation.read('path').stringValue,
          controllerPath,
          method.name,
        );
      }
    }

    buffer.writeln();
    buffer.writeln('  return routerConfig;');
    buffer.writeln('}');

    // Format the generated code
    final formatter =
        DartFormatter(languageVersion: DartFormatter.latestLanguageVersion);
    return formatter.format(buffer.toString());
  }

  ConstantReader? _getAnnotationOfType<T>(MethodElement method) {
    final annotations = TypeChecker.fromRuntime(T)
        .annotationsOf(method, throwOnUnresolved: false);

    if (annotations.isEmpty) {
      return null;
    }

    return ConstantReader(annotations.first);
  }

  void _generateRouteRegistration(
    StringBuffer buffer,
    String httpMethod,
    String methodPath,
    String? controllerPath,
    String handlerName,
  ) {
    final basePath = (controllerPath ?? '').trim();
    final routePath = methodPath.trim();

    // Concatenate paths safely, ensuring only one slash between parts
    final fullPath = '/${[
      basePath,
      routePath,
    ].where((segment) => segment.isNotEmpty).map((s) => s.startsWith('/') ? s.substring(1) : s).join('/')}';

    buffer.writeln(
      "  routerConfig.$httpMethod('$fullPath', controller.$handlerName);",
    );
  }
}
