import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:sarus_gen/utils/extensions.dart';
import 'package:source_gen/source_gen.dart';

/// Represents the type of HTTP annotation (e.g., Get, Post) and optional path.
typedef HttpAnnotationInfo = ({String type, String? path});

typedef RequestBodyParser = ({String code, String type});

/// A source_gen [Generator] that generates router configurations
/// for classes extending `Endpoints`.
class EndpointGen extends Generator {
  static const String _generatedFunctionPrefix = r'$';

  /// Flag indicating if body parsing is required.
  bool hasBodyAnnotation = true;

  final importsPaths = <String, String>{};

  final _imports = <String>{};

  Future<void> resolveBodyImports(BuildStep buildStep) async {
    // Find all Dart files in the lib directory for processing
    final inputAssets = await buildStep
        .findAssets(Glob('lib/**.dart'))
        .toList();

    for (final assets in inputAssets) {
      final library = await buildStep.resolver.libraryFor(assets);
      final reader = LibraryReader(library);
      final models = reader.classes.where((element) {
        return element.supertype != null &&
            element.supertype!.getDisplayString().startsWith('Model<');
      });

      for (final model in models) {
        final modelClassName = model.name ?? '';
        final path = model.library.uri.path;
        // print(modelClassName);
        // print(path);
        importsPaths[modelClassName] = path;
      }
    }
  }

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    await resolveBodyImports(buildStep);

    final endpoints = _collectEndpoints(library);
    if (endpoints.isEmpty) return null; // Skip generation if no endpoints found

    // Get the source file path
    final inputPath = buildStep.inputId.path;

    // Create the generated folder path
    final sourceDir = path.dirname(inputPath);
    final generatedDir = path.join(sourceDir, 'generated');
    final fileName = path.basenameWithoutExtension(inputPath);
    final outputFileName = '$fileName.g.dart';
    final outputPath = path.join(generatedDir, outputFileName);

    // Create the generated directory if it doesn't exist
    final generatedDirectory = Directory(generatedDir);
    if (!generatedDirectory.existsSync()) {
      await generatedDirectory.create(recursive: true);
    }

    final endpointCodes = <String>[];
    for (final endpoint in endpoints) {
      endpointCodes.add(_generateEndpointRouter(endpoint));
    }

    final output = StringBuffer();

    output.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    if (hasBodyAnnotation) {
      output.writeln();
      output.writeln('import "dart:convert";');
    }
    output.writeln();
    output.writeln('import "package:sarus/sarus.dart";');
    output.writeln();
    output.writeln('import "../$fileName.dart";');
    output.writeln();
    for (final import in _imports) {
      output.write('import "package:$import";');
    }
    output.writeln();
    output.writeln();

    output.writeAll(endpointCodes);

    // Write the file to the generated folder
    final outputFile = File(outputPath);
    await outputFile.writeAsString(output.toString());

    // Return null to prevent build_runner from creating its own file
    return null;
  }

  /// Generates the request body parsing code for a method.
  ///
  /// Returns `null` if no body parsing is required.
  RequestBodyParser? _generateRequestBodyParser(MethodElement method) {
    final parameters = method.formalParameters;
    final types = <String>[];

    if (parameters.isEmpty) {
      throw Exception(
        'HTTP method ${method.name} does not have any parameters',
      );
    }

    final output = StringBuffer();
    output.writeln('      final bodyString = await req.readAsString();');
    output.writeln('      if (bodyString.isEmpty) {');
    output.writeln('        return Response.badRequest(');
    output.writeln(
      '          body: jsonEncode({"error": "Empty body", "status": 400}),',
    );
    output.writeln('        );');
    output.writeln('      }');

    for (final parameter in parameters) {
      if (_checkAnnotation(parameter.metadata.annotations, 'Body')) {
        // if (parameter.type.getDisplayString() != 'Request') {
        output.writeln(
          '      final request = ${parameter.type.getDisplayString()}.fromJson(jsonDecode(bodyString));',
        );

        types.add('request');

        _imports.add(importsPaths[parameter.type.getDisplayString()]!);
      }

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

        output.writeln();
        output.writeln(
          '      final ${name}Raw = req.params["$name"];',
        );
        output.writeln('''
      if (${name}Raw == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing path parameter: $name", "status": 400}),
        );
      }''');

        final dataType = parameter.type.getDisplayString();

        if (dataType == 'int') {
          output.writeln(
            '      final $name = int.parse(${name}Raw);',
          );
        } else if (dataType == 'double') {
          output.writeln(
            '      final $name = double.parse(${name}Raw);',
          );
        } else if (dataType == 'bool') {
          output.writeln(
            '      final $name = ${name}Raw == "true";',
          );
        } else {
          output.writeln(
            '      final $name = ${name}Raw;',
          );
        }

        types.add(
          pathAnnotation
                  .computeConstantValue()
                  ?.getField('name')
                  ?.toStringValue() ??
              '',
        );
      }

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

        output.writeln();
        output.writeln(
          '      final $name = req.url.queryParameters["$name"];',
        );
        output.writeln('''
      if ($name == null) {
        return Response.badRequest(
          body: jsonEncode({"error": "Missing query parameter: $name", "status": 400}),
        );
      }
      ''');

        types.add(
          queryAnnotation
                  .computeConstantValue()
                  ?.getField('name')
                  ?.toStringValue() ??
              '',
        );
      }
    }

    return (code: output.toString(), type: types.join(', '));
  }

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

    output.writeln('/// Generated router configuration for [$className].');
    output.writeln(
      '/// This function creates and configures all routes defined in the endpoint class.',
    );
    output.writeln(
      'RouterConfig $_generatedFunctionPrefix${className?.toLowerCamelCase()}RouterConfig($className endpoints) {',
    );
    output.writeln('  final routerConfig = RouterConfig();');
    output.writeln();

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
          // ✅ Build full route path correctly
          var fullPath = subPath == null ? prefixValue : prefixValue + subPath;
          if (fullPath.isEmpty) fullPath = '/'; // fallback

          final methodName = method.name;

          output.writeln(
            "  routerConfig.$httpMethod('$fullPath', (Request req) async {",
          );
          output.writeln('    try {');

          final requestBodyResponse = _generateRequestBodyParser(method);
          if (requestBodyResponse?.code != null) {
            output.writeln(requestBodyResponse?.code ?? '');
            if (requestBodyResponse?.type.isEmpty != true) {
              output.writeln(
                '      return endpoints.$methodName(req, ${requestBodyResponse?.type});',
              );
            } else {
              output.writeln('      return endpoints.$methodName(req);');
            }
          } else {
            output.writeln('      return endpoints.$methodName(req);');
          }

          output.writeln('    } catch (e) {');
          output.writeln('      if (e is ArgumentError) {');
          output.writeln(
            '        return Response.badRequest(body: e.message);',
          );
          output.writeln('      }');
          output.writeln('      if (e is FormatException) {');
          output.writeln(
            r"        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');",
          );
          output.writeln('      }');
          output.writeln('      rethrow;');
          output.writeln('    }');
          output.writeln('  });');
          output.writeln();
        }
      }
    }

    output.writeln('  return routerConfig;');
    output.writeln('}');

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

  /// Returns an iterable of [ClassElement] that extend `Endpoints`.
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
