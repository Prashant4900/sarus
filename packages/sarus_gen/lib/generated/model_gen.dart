import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

class ModelGen extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final models = generateModels(library);

    if (models.isEmpty) return null; // Skip generation if no models found

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

    final output = StringBuffer();

    output.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');
    output.writeln();

    output.writeln('import "../$fileName.dart";');
    output.writeln();

    for (final model in models) {
      output.writeln(generateModelCode(model));
    }

    // Write the file to the generated folder
    final outputFile = File(outputPath);
    await outputFile.writeAsString(output.toString());

    // Return null to prevent build_runner from creating its own file
    return null;
  }

  String generateModelCode(ClassElement model) {
    final className = model.name;
    final variableName =
        '${className?[0].toLowerCase()}${className?.substring(1)}';

    final fields = model.fields
        .where((f) => !f.isStatic && f.isPublic)
        .map((f) => f)
        .toList();

    final buffer = StringBuffer();

    // toJson
    buffer.writeln(
      'Map<String, dynamic> \$${variableName}ToJson($className instance) {',
    );
    buffer.writeln('  return {');
    for (final field in fields) {
      buffer.writeln("    '${field.name}': instance.${field.name},");
    }
    buffer.writeln('  };');
    buffer.writeln('}');
    buffer.writeln();

    // fromJson
    buffer.writeln(
      '$className \$${variableName}FromJson(Map<String, dynamic> json) {',
    );
    buffer.writeln('  return $className(');
    for (final field in fields) {
      final typeStr = field.type.getDisplayString();
      buffer.writeln("    ${field.name}: json['${field.name}'] as $typeStr,");
    }
    buffer.writeln('  );');
    buffer.writeln('}');
    buffer.writeln();

    return buffer.toString();
  }

  /// Returns an iterable of [ClassElement] that extend `Model<T>`
  Iterable<ClassElement> generateModels(LibraryReader library) {
    return library.classes.where(
      (element) {
        final className = element.name ?? '';
        return element.allSupertypes.any(
          (supertype) => supertype.getDisplayString() == 'Model<$className>',
        );
      },
    );
  }
}
