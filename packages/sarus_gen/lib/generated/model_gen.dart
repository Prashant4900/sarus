import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as path;
import 'package:sarus/sarus.dart' show JsonKey;
import 'package:source_gen/source_gen.dart';

/// A source_gen [Generator] that generates `toJson` and `fromJson`
/// serialization functions for classes extending `Model<T>`.
///
/// Supports [JsonKey] annotation for customizing field names
/// and null-handling in generated JSON.
class ModelGen extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    // Collect models from the current library
    final models = _collectModels(library);
    if (models.isEmpty) return null; // Skip if no models found

    // Input file path (e.g., lib/models/user.dart)
    final inputPath = buildStep.inputId.path;

    // Build the output file path (e.g., lib/models/generated/user.g.dart)
    final sourceDir = path.dirname(inputPath);
    final generatedDir = path.join(sourceDir, 'generated');
    final fileName = path.basenameWithoutExtension(inputPath);
    final outputFileName = '$fileName.g.dart';
    final outputPath = path.join(generatedDir, outputFileName);

    // Ensure the `generated/` directory exists
    final generatedDirectory = Directory(generatedDir);
    if (!generatedDirectory.existsSync()) {
      await generatedDirectory.create(recursive: true);
    }

    // Build the generated output
    final output = StringBuffer()
      ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND')
      ..writeln()
      ..writeln('import "../$fileName.dart";')
      ..writeln();

    // Add serializers for each model class
    for (final model in models) {
      output.writeln(_generateModelSerializer(model));
    }

    // Write the generated file
    final outputFile = File(outputPath);
    await outputFile.writeAsString(output.toString());

    // Return null to avoid build_runner writing its own file
    return null;
  }

  /// Generates both `toJson` and `fromJson` functions for a given [model].
  ///
  /// Respects [JsonKey] annotations on fields.
  String _generateModelSerializer(ClassElement model) {
    final className = model.name;
    final variableName =
        '${className?[0].toLowerCase()}${className?.substring(1)}';

    // Collect only non-static, public fields
    final fields = model.fields.where((f) => !f.isStatic && f.isPublic);

    final buffer = StringBuffer();

    // Generate toJson
    buffer.writeln(
      'Map<String, dynamic> \$${variableName}ToJson($className instance) {',
    );
    buffer.writeln('  final val = <String, dynamic>{};');

    for (final field in fields) {
      final annotation = _readJsonKey(field);
      final jsonKey = annotation.name ?? field.name;
      final includeIfNull = annotation.includeIfNull;
      final isNullable =
          field.type.nullabilitySuffix.name == 'question'; // `?` check

      if (isNullable && !includeIfNull) {
        // Nullable field with includeIfNull = false → conditional
        buffer.writeln(
          "  if (instance.${field.name} != null) { val['$jsonKey'] = instance.${field.name}; }",
        );
      } else {
        // Always included (non-nullable OR includeIfNull = true)
        buffer.writeln("  val['$jsonKey'] = instance.${field.name};");
      }
    }

    buffer.writeln('  return val;');
    buffer.writeln('}\n');

    // Generate fromJson
    buffer.writeln(
      '$className \$${variableName}FromJson(Map<String, dynamic> json) {',
    );
    buffer.writeln('  return $className(');

    for (final field in fields) {
      final annotation = _readJsonKey(field);
      final jsonKey = annotation.name ?? field.name;
      final typeStr = field.type.getDisplayString();

      buffer.writeln(
        "    ${field.name}: json['$jsonKey'] as $typeStr,",
      );
    }

    buffer.writeln('  );');
    buffer.writeln('}\n');

    return buffer.toString();
  }

  /// Collects all classes in the library that extend `Model<T>`.
  Iterable<ClassElement> _collectModels(LibraryReader library) {
    return library.classes.where((element) {
      final className = element.name ?? '';
      return element.allSupertypes.any(
        (supertype) => supertype.getDisplayString() == 'Model<$className>',
      );
    });
  }

  /// Reads a [JsonKey] annotation from a field, or returns defaults.
  ({String? name, bool includeIfNull}) _readJsonKey(FieldElement field) {
    for (final annotation in field.metadata.annotations) {
      final constantValue = annotation.computeConstantValue();
      if (constantValue?.type?.getDisplayString() == 'JsonKey') {
        final name = constantValue?.getField('name')?.toStringValue();
        final includeIfNull =
            constantValue?.getField('includeIfNull')?.toBoolValue() ?? false;
        return (name: name, includeIfNull: includeIfNull);
      }
    }
    return (name: null, includeIfNull: false);
  }
}
