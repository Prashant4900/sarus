import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:sarus/generated/dto_gen.dart';
import 'package:sarus/sarus.dart';
import 'package:source_gen/source_gen.dart';

/// A code generation builder for the Sarus framework that generates application code
/// by scanning for annotated classes and generating corresponding router and DTO code.
///
/// This builder processes files containing @Endpoint and @DTO annotations and generates
/// a single output file `lib/sarus_application.g.dart` containing all the generated code.
class SarusApplicationBuilder implements Builder {
  /// Defines the build extensions mapping.
  ///
  /// Maps the package root to the generated output file location.
  /// The generated file will be created at `lib/sarus_application.g.dart`.
  @override
  final buildExtensions = const {
    r'$package$': ['lib/sarus_application.g.dart'],
  };

  /// Main build method that orchestrates the code generation process.
  ///
  /// This method:
  /// 1. Creates the output file header
  /// 2. Adds necessary imports
  /// 3. Scans all Dart files for annotations
  /// 4. Generates code for @Endpoint and @DTO annotated elements
  /// 5. Writes the final generated code to the output file
  ///
  /// [buildStep] The current build step providing access to assets and resolver
  @override
  Future<void> build(BuildStep buildStep) async {
    final output = StringBuffer();

    // Write file header with generation warning
    output.writeln('// GENERATED CODE - DO NOT MODIFY BY HAND');

    // Always include the base Sarus import as it's required for generated code
    output.writeln("import 'package:sarus/sarus.dart';");

    // Add imports for files containing annotated classes
    await writeAnnotatedImports(buildStep, output);

    // Find all Dart files in the lib directory for processing
    final inputAssets =
        await buildStep.findAssets(Glob('lib/**.dart')).toList();

    // Process each Dart file to find and generate code for annotated elements
    for (final input in inputAssets) {
      final library = await buildStep.resolver.libraryFor(input);
      final reader = LibraryReader(library);

      // Process all @Endpoint annotated elements
      for (final element
          in reader.annotatedWith(const TypeChecker.fromRuntime(Endpoint))) {
        final routerCode = RouteGenerator().generateForAnnotatedElement(
          element.element,
          element.annotation,
          buildStep,
        );
        output.writeln(routerCode);
      }

      // Process all @DTO annotated elements
      for (final element
          in reader.annotatedWith(const TypeChecker.fromRuntime(DTO))) {
        final dtoCode = DTOGenerator().generateForAnnotatedElement(
          element.element,
          element.annotation,
          buildStep,
        );
        output.writeln(dtoCode);
      }
    }

    // Write the complete generated code to the output file
    final assetId =
        AssetId(buildStep.inputId.package, 'lib/sarus_application.g.dart');
    await buildStep.writeAsString(assetId, output.toString());
  }

  /// Scans all Dart files and generates import statements for files containing
  /// @Endpoint or @DTO annotations.
  ///
  /// This method also conditionally adds the `dart:convert` import if any DTO
  /// annotations are found, as DTOs typically require JSON serialization.
  ///
  /// [buildStep] The current build step for asset discovery
  /// [output] The string buffer to write import statements to
  Future<void> writeAnnotatedImports(
    BuildStep buildStep,
    StringBuffer output,
  ) async {
    // Find all Dart files in the lib directory
    final inputAssets =
        await buildStep.findAssets(Glob('lib/**.dart')).toList();

    // Use a Set to avoid duplicate imports
    final imports = <String>{};
    var hasDTO = false;

    // Scan each file for relevant annotations
    for (final input in inputAssets) {
      final library = await buildStep.resolver.libraryFor(input);
      final reader = LibraryReader(library);

      // Check if the file contains @Endpoint annotations
      final hasEndpoint = reader
          .annotatedWith(const TypeChecker.fromRuntime(Endpoint))
          .isNotEmpty;

      // Check if the file contains @DTO annotations
      final hasDTOHere =
          reader.annotatedWith(const TypeChecker.fromRuntime(DTO)).isNotEmpty;

      // Add import for files containing either annotation type
      if (hasEndpoint || hasDTOHere) {
        imports.add("import '${input.uri}';");
      }

      // Track if any DTO annotations were found across all files
      if (hasDTOHere) {
        hasDTO = true;
      }
    }

    // Add dart:convert import if DTOs are present (needed for JSON operations)
    if (hasDTO) {
      output.writeln("import 'dart:convert';");
    }

    // Write all collected imports in sorted order for consistency
    for (final import in imports.toList()..sort()) {
      output.writeln(import);
    }

    // Add blank line after imports section for better readability
    output.writeln();
  }
}
