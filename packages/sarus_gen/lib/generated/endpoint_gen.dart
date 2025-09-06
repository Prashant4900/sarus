import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:sarus/sarus.dart' show Endpoints;
import 'package:sarus_gen/utils/extensions.dart';
import 'package:source_gen/source_gen.dart';

/// Represents the type of HTTP annotation (e.g., `@Get`, `@Post`)
/// with its optional `path` argument.
typedef HttpAnnotationInfo = ({String type, String? path});

/// Represents generated body parser code for an endpoint method,
/// along with the list of extracted arguments to be passed.
typedef RequestBodyParser = ({String code, String type});

/// A [Generator] that scans classes extending [Endpoints] and
/// generates corresponding router configuration code.
///
/// Responsibilities:
/// - Resolve model imports for DTOs used in `@Body` parameters.
/// - Generate strongly typed handlers for endpoint methods.
/// - Validate and parse request parameters (`@Body`, `@PathParam`, `@QueryParam`).
/// - Write generated code into a `generated/*.g.dart` file next to the source file.
class EndpointGen extends Generator {
  static const String _generatedFunctionPrefix = r'$';

  /// Stores model class → import path mapping,
  /// used to add correct imports for request bodies.
  final importsPaths = <String, String>{};

  /// Set of extra imports needed in generated files.
  final _imports = <String>{};

  /// Scans all files under `lib/` to collect model classes
  /// (classes extending `Model<T>`) for request body parsing.
  Future<void> resolveBodyImports(BuildStep buildStep) async {
    final inputAssets = await buildStep
        .findAssets(Glob('lib/**.dart'))
        .toList();

    for (final asset in inputAssets) {
      final library = await buildStep.resolver.libraryFor(asset);
      final reader = LibraryReader(library);

      final models = reader.classes.where(
        (element) =>
            element.supertype != null &&
            element.supertype!.getDisplayString().startsWith('Model<'),
      );

      for (final model in models) {
        importsPaths[model.name!] = model.library.uri.path;
      }
    }
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    // Collect all DTO imports required for body parsing
    await resolveBodyImports(buildStep);

    final endpoints = _collectEndpoints(library);
    if (endpoints.isEmpty) return null; // nothing to generate

    // Prepare paths for generated file
    final inputPath = buildStep.inputId.path;
    final sourceDir = path.dirname(inputPath);
    final generatedDir = path.join(sourceDir, 'generated');
    final fileName = path.basenameWithoutExtension(inputPath);
    final outputFileName = '$fileName.g.dart';
    final outputPath = path.join(generatedDir, outputFileName);

    // Ensure generated directory exists
    final generatedDirectory = Directory(generatedDir);
    if (!generatedDirectory.existsSync()) {
      await generatedDirectory.create(recursive: true);
    }

    // Generate router configs for each endpoint
    final endpointCodes = endpoints
        .map(_generateEndpointRouter)
        .toList(growable: false);

    final output = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln()
      ..writeln('import "dart:convert";')
      ..writeln('import "package:sarus/sarus.dart";')
      ..writeln()
      ..writeln('import "../$fileName.dart";')
      ..writeln();

    for (final import in _imports) {
      output.writeln('import "package:$import";');
    }

    output.writeln();
    output.writeAll(endpointCodes);

    // Write generated file
    final outputFile = File(outputPath);
    await outputFile.writeAsString(output.toString());

    // Return null so build_runner doesn't create its own file
    return null;
  }

  /// Generates request body and parameter parsing code for a method.
  ///
  /// Returns `null` if no parsing is needed.
  RequestBodyParser? _generateRequestBodyParser(MethodElement method) {
    final parameters = method.formalParameters;
    final types = <String>[];

    if (parameters.isEmpty) {
      throw Exception(
        'HTTP method ${method.name} does not have any parameters',
      );
    }

    final output = StringBuffer()
      ..writeln('      final bodyString = await req.readAsString();')
      ..writeln('      if (bodyString.isEmpty) {')
      ..writeln('        return Response.badRequest(')
      ..writeln(
        '          body: jsonEncode({"error": "Empty body", "status": 400}),',
      )
      ..writeln('        );')
      ..writeln('      }');

    for (final parameter in parameters) {
      // Handle @Body
      if (_checkAnnotation(parameter.metadata.annotations, 'Body')) {
        output.writeln(
          '      final request = ${parameter.type.getDisplayString()}.fromJson(jsonDecode(bodyString));',
        );
        types.add('request');
        _imports.add(importsPaths[parameter.type.getDisplayString()]!);
      }

      // Handle @PathParam
      if (_checkAnnotation(parameter.metadata.annotations, 'PathParam')) {
        final pathAnnotation = parameter.metadata.annotations.firstWhere(
          (annotation) =>
              annotation.computeConstantValue()?.type?.getDisplayString() ==
              'PathParam',
        );
        final name = pathAnnotation
            .computeConstantValue()
            ?.getField('name')
            ?.toStringValue();

        output
          ..writeln()
          ..writeln('      final ${name}Raw = req.params["$name"];')
          ..writeln('''
      if (${name}Raw == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing path parameter: $name", "status": 400}),
        );
      }''');

        final dataType = parameter.type.getDisplayString();
        if (dataType == 'int') {
          output.writeln('      final $name = int.parse(${name}Raw);');
        } else if (dataType == 'double') {
          output.writeln('      final $name = double.parse(${name}Raw);');
        } else if (dataType == 'bool') {
          output.writeln('      final $name = ${name}Raw == "true";');
        } else {
          output.writeln('      final $name = ${name}Raw;');
        }

        types.add(name ?? '');
      }

      // Handle @QueryParam
      if (_checkAnnotation(parameter.metadata.annotations, 'QueryParam')) {
        final queryAnnotation = parameter.metadata.annotations.firstWhere(
          (annotation) =>
              annotation.computeConstantValue()?.type?.getDisplayString() ==
              'QueryParam',
        );
        final name = queryAnnotation
            .computeConstantValue()
            ?.getField('name')
            ?.toStringValue();

        output
          ..writeln()
          ..writeln('      final $name = req.url.queryParameters["$name"];')
          ..writeln('''
      if ($name == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing query parameter: $name", "status": 400}),
        );
      }
      ''');

        types.add(name ?? '');
      }
    }

    return (code: output.toString(), type: types.join(', '));
  }

  /// Checks if an annotation list contains the given annotation type.
  bool _checkAnnotation(
    List<ElementAnnotation> annotations,
    String annotation,
  ) {
    for (final annotationType in annotations) {
      if (annotationType.computeConstantValue()?.type?.getDisplayString() ==
          annotation) {
        return true;
      }
    }
    return false;
  }

  /// Generates the router configuration code for a given endpoint class.
  String _generateEndpointRouter(ClassElement endpoint) {
    final output = StringBuffer();
    final className = endpoint.name;
    final prefixField = endpoint.getField('prefix');
    final prefixValue =
        prefixField?.computeConstantValue()?.toStringValue() ?? '';

    output
      ..writeln('/// Generated router configuration for [$className].')
      ..writeln(
        '/// This function creates and configures all routes defined in the endpoint class.',
      )
      ..writeln(
        'RouterConfig $_generatedFunctionPrefix${className?.toLowerCamelCase()}RouterConfig($className endpoints) {',
      )
      ..writeln('  final routerConfig = RouterConfig();')
      ..writeln();

    for (final method in endpoint.methods) {
      for (final annotation in method.metadata.annotations) {
        final annotationType = _parseHttpAnnotation(annotation);

        final typeName = annotationType.type;
        final subPath = annotationType.path;

        String? httpMethod;
        if (typeName == 'Get') httpMethod = 'get';
        if (typeName == 'Post') httpMethod = 'post';
        if (typeName == 'Put') httpMethod = 'put';
        if (typeName == 'Delete') httpMethod = 'delete';
        if (typeName == 'Patch') httpMethod = 'patch';
        if (typeName == 'Head') httpMethod = 'head';
        if (typeName == 'Options') httpMethod = 'options';

        if (httpMethod != null) {
          // Build full route path
          var fullPath = subPath == null ? prefixValue : prefixValue + subPath;
          if (fullPath.isEmpty) fullPath = '/';

          final methodName = method.name;

          output
            ..writeln(
              "  routerConfig.$httpMethod('$fullPath', (Request req) async {",
            )
            ..writeln('    try {');

          final requestBodyResponse = _generateRequestBodyParser(method);
          if (requestBodyResponse?.code != null) {
            output.writeln(requestBodyResponse?.code ?? '');
            if (requestBodyResponse?.type.isNotEmpty ?? false) {
              output.writeln(
                '      return endpoints.$methodName(req, ${requestBodyResponse?.type});',
              );
            } else {
              output.writeln('      return endpoints.$methodName(req);');
            }
          } else {
            output.writeln('      return endpoints.$methodName(req);');
          }

          output
            ..writeln('    } catch (e) {')
            ..writeln('      if (e is ArgumentError) {')
            ..writeln('        return Response.badRequest(body: e.message);')
            ..writeln('      }')
            ..writeln('      if (e is FormatException) {')
            ..writeln(
              r"        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');",
            )
            ..writeln('      }')
            ..writeln('      rethrow;')
            ..writeln('    }')
            ..writeln('  });')
            ..writeln();
        }
      }
    }

    output
      ..writeln('  return routerConfig;')
      ..writeln('}');

    return output.toString();
  }

  /// Extracts HTTP annotation information (type and path).
  HttpAnnotationInfo _parseHttpAnnotation(ElementAnnotation annotation) {
    final type = annotation.computeConstantValue()?.type?.getDisplayString();
    final path = annotation
        .computeConstantValue()
        ?.constructorInvocation
        ?.namedArguments['path']
        ?.toStringValue();

    return (path: path, type: type!);
  }

  /// Finds all classes in the library that extend [Endpoints].
  Iterable<ClassElement> _collectEndpoints(LibraryReader library) {
    return library.classes.where(
      (element) {
        return element.allSupertypes.any(
          (supertype) => supertype.getDisplayString() == 'Endpoints',
        );
      },
    );
  }
}
