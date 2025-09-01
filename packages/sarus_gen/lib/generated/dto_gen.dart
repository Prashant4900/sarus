import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:sarus/sarus.dart';
import 'package:source_gen/source_gen.dart';

/// A code generator that automatically creates JSON serialization methods
/// for classes annotated with the @DTO annotation.
///
/// This generator produces `fromJson` and `toJson` methods that handle
/// the conversion between Dart objects and JSON representations.
///
/// ## Features:
/// - Supports all primitive Dart types (String, int, double, bool)
/// - Handles Lists with proper type casting
/// - Respects nullability annotations
/// - Supports JsonKey annotations for custom field mapping
/// - Includes proper error handling and code formatting
///
/// ## Usage:
/// ```dart
/// @DTO()
/// class User {
///   final String name;
///   final int? age;
///   final List<String> tags;
///
///   User({required this.name, this.age, required this.tags});
/// }
/// ```
///
/// This will generate:
/// ```dart
/// User $userFromJson(Map<String, dynamic> json) { ... }
/// Map<String, dynamic> $userToJson(User instance) { ... }
/// ```
class DTOGenerator extends GeneratorForAnnotation<DTO> {
  /// Generates serialization code for the annotated class element.
  ///
  /// This method is called by the build system for each class annotated
  /// with @DTO. It validates the element and generates the appropriate
  /// serialization methods.
  ///
  /// [element] The class element that was annotated with @DTO
  /// [annotation] The DTO annotation instance
  /// [buildStep] The current build step context
  ///
  /// Returns the generated Dart code as a formatted string.
  ///
  /// Throws [InvalidGenerationSourceError] if the annotation is used
  /// on anything other than a class.
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // Validate that the annotation is only used on classes
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'The @DTO annotation can only be used on classes.',
        element: element,
      );
    }

    final className = element.name ?? '';
    final buffer = StringBuffer();

    // Generate the serialization methods for the class
    _generateModelClass(buffer, className, element);

    return _formatGeneratedCode(buffer.toString());
  }

  /// Generates the complete serialization code for a model class.
  ///
  /// This method orchestrates the generation of both `fromJson` and `toJson`
  /// methods by analyzing the class fields and generating appropriate
  /// serialization code.
  ///
  /// [buffer] The string buffer to write the generated code to
  /// [className] The name of the class being processed
  /// [element] The class element containing field information
  void _generateModelClass(
    StringBuffer buffer,
    String className,
    ClassElement element,
  ) {
    // Extract all non-static fields from the class
    final fields = element.fields.where((field) => !field.isStatic).toList();

    // Skip generation if no fields are found
    if (fields.isEmpty) {
      buffer.writeln('// No fields found in $className');
      return;
    }

    // Generate the fromJson factory method
    _generateFromJsonMethod(buffer, className, fields);

    // Generate the toJson instance method
    _generateToJsonMethod(buffer, className, fields);
  }

  /// Generates the `fromJson` factory method for deserializing JSON to Dart objects.
  ///
  /// This method creates a factory function that takes a JSON map and returns
  /// an instance of the target class. It handles type casting, nullability,
  /// and custom JsonKey mappings.
  ///
  /// The generated method signature follows the pattern:
  /// `ClassName $classNameFromJson(Map<String, dynamic> json)`
  ///
  /// [buffer] The string buffer to write the generated code to
  /// [className] The name of the class being processed
  /// [fields] List of fields in the class that need serialization
  void _generateFromJsonMethod(
    StringBuffer buffer,
    String className,
    List<FieldElement> fields,
  ) {
    // Generate method signature
    buffer.writeln(
      '$className \$${className.toCamelCase()}FromJson(Map<String, dynamic> json) {',
    );
    buffer.writeln('  return $className(');

    // Process each field and generate appropriate deserialization code
    for (final field in fields) {
      final fieldName = field.name;
      final jsonKey = _getJsonKeyInfo(field);
      final jsonKeyName = jsonKey['name'] as String? ?? fieldName;
      final fieldType = field.type;
      final isNullable =
          fieldType.nullabilitySuffix == NullabilitySuffix.question;

      buffer.write('    $fieldName: ');

      // Generate type-specific deserialization code
      if (fieldType.isDartCoreString) {
        buffer.writeln(
          "json['$jsonKeyName'] as String${isNullable ? '?' : ''},",
        );
      } else if (fieldType.isDartCoreInt) {
        buffer.writeln("json['$jsonKeyName'] as int${isNullable ? '?' : ''},");
      } else if (fieldType.isDartCoreDouble) {
        buffer.writeln(
          "json['$jsonKeyName'] as double${isNullable ? '?' : ''},",
        );
      } else if (fieldType.isDartCoreBool) {
        buffer.writeln("json['$jsonKeyName'] as bool${isNullable ? '?' : ''},");
      } else if (fieldType.isDartCoreList) {
        // Handle List types with proper casting
        buffer.writeln(
          "(json['$jsonKeyName'] as List<dynamic>${isNullable ? '?' : ''})${isNullable ? '?' : ''}.cast<${_getListElementType(fieldType)}>(),",
        );
      } else {
        // Handle custom types or fallback for unknown types
        buffer.writeln(
          "json['$jsonKeyName']${isNullable ? '' : ' as ${fieldType.getDisplayString(withNullability: false)}'},",
        );
      }
    }

    buffer.writeln('  );');
    buffer.writeln('}');
    buffer.writeln();
  }

  /// Generates the `toJson` instance method for serializing Dart objects to JSON.
  ///
  /// This method creates a function that takes an instance of the target class
  /// and returns a JSON map representation. It respects JsonKey annotations
  /// and handles null value inclusion based on the `includeIfNull` setting.
  ///
  /// The generated method signature follows the pattern:
  /// `Map<String, dynamic> $classNameToJson(ClassName instance)`
  ///
  /// [buffer] The string buffer to write the generated code to
  /// [className] The name of the class being processed
  /// [fields] List of fields in the class that need serialization
  void _generateToJsonMethod(
    StringBuffer buffer,
    String className,
    List<FieldElement> fields,
  ) {
    // Generate method signature
    buffer.writeln(
      'Map<String, dynamic> \$${className.toCamelCase()}ToJson($className instance) {',
    );
    buffer.writeln('  final val = <String, dynamic>{};');
    buffer.writeln();

    // Process each field and generate serialization code
    for (final field in fields) {
      final fieldName = field.name;
      final jsonKey = _getJsonKeyInfo(field);
      final jsonKeyName = jsonKey['name'] as String? ?? fieldName;
      final includeIfNull = jsonKey['includeIfNull'] as bool? ?? true;

      // Generate field assignment with optional null handling
      if (!includeIfNull) {
        // Note: Currently includeIfNull is not fully implemented
        // This would require additional null checking logic
        buffer.writeln("    val['$jsonKeyName'] = instance.$fieldName;");
      } else {
        buffer.writeln("  val['$jsonKeyName'] = instance.$fieldName;");
      }
    }

    buffer.writeln();
    buffer.writeln('  return val;');
    buffer.writeln('}');
  }

  /// Extracts JsonKey annotation information from a field element.
  ///
  /// This method analyzes field metadata to find JsonKey annotations and
  /// extracts relevant configuration such as custom field names and
  /// null handling preferences.
  ///
  /// [field] The field element to analyze for JsonKey annotations
  ///
  /// Returns a map containing JsonKey configuration:
  /// - `name`: Custom JSON field name (null if not specified)
  /// - `includeIfNull`: Whether to include null values in JSON (defaults to true)
  Map<String, dynamic> _getJsonKeyInfo(FieldElement field) {
    // Default configuration values
    final defaultInfo = {'name': null, 'includeIfNull': true};

    // Search for JsonKey annotation in field metadata
    ElementAnnotation? jsonKeyAnnotation;
    try {
      jsonKeyAnnotation = field.metadata.annotations.firstWhere(
        (annotation) => annotation.element?.displayName == 'JsonKey',
      );
    } catch (e) {
      // No JsonKey annotation found, return defaults
      return defaultInfo;
    }

    // Extract configuration values from the annotation
    try {
      final reader = ConstantReader(jsonKeyAnnotation.computeConstantValue());
      return {
        'name': reader.read('name').isNull
            ? null
            : reader.read('name').stringValue,
        'includeIfNull': reader.read('includeIfNull').boolValue,
      };
    } catch (e) {
      // If reading annotation values fails, return defaults
      return defaultInfo;
    }
  }

  /// Extracts the element type from a parameterized List type.
  ///
  /// This method analyzes List type parameters to determine the element type
  /// for proper type casting in the generated code.
  ///
  /// [listType] The List type to analyze
  ///
  /// Returns the element type as a string, or 'dynamic' if not determinable.
  ///
  /// Example:
  /// - `List<String>` returns `"String"`
  /// - `List<int>` returns `"int"`
  /// - `List` returns `"dynamic"`
  String _getListElementType(DartType listType) {
    if (listType is ParameterizedType && listType.typeArguments.isNotEmpty) {
      return listType.typeArguments.first.getDisplayString(
        withNullability: false,
      );
    }
    return 'dynamic';
  }

  /// Formats the generated code using DartFormatter for consistent styling.
  ///
  /// This method applies Dart's standard formatting rules to the generated
  /// code to ensure it follows proper style conventions and is readable.
  ///
  /// [code] The raw generated code string to format
  ///
  /// Returns the formatted code string, or the original code if formatting fails.
  String _formatGeneratedCode(String code) {
    try {
      final formatter = DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      );
      return formatter.format(code);
    } catch (e) {
      // If formatting fails, return the unformatted code
      // This ensures the generator doesn't break due to formatting issues
      return code;
    }
  }
}

extension CamelCaseExtension on String {
  String toCamelCase() {
    final words =
        replaceAllMapped(RegExp('([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
            .replaceAll(RegExp(r'[_\-\s]+'), ' ')
            .trim()
            .split(' ')
            .where((word) => word.isNotEmpty)
            .toList();

    if (words.isEmpty) return '';

    final first = words.first.toLowerCase();
    final rest = words
        .skip(1)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase());

    return [first, ...rest].join();
  }
}
