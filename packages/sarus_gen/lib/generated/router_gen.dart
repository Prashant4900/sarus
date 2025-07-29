import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:glob/glob.dart';

/// A code generator that automatically discovers and registers Route classes
/// in the Sarus framework.
///
/// This generator scans all Dart files in the `lib/` directory to find classes
/// that extend `Route`, then generates a consolidated `$routes` list that can
/// be used for automatic route registration.
///
/// Features:
/// - Discovers all non-abstract Route classes
/// - Generates proper import statements
/// - Creates a sorted list of route instances
/// - Handles build errors gracefully
/// - Formats output code automatically
class RouterGenerator {
  /// File patterns to exclude from scanning
  static const _excludedFilePatterns = {
    '.g.dart',
    '.freezed.dart',
    '.gr.dart',
  };

  /// The name of the target superclass to search for
  static const _routeClassName = 'Route';

  /// The name of the generated routes list variable
  static const _routesListName = r'$routes';

  /// Glob pattern for finding Dart files in lib/
  static const _libGlobPattern = 'lib/**.dart';

  /// Set of unique import paths for discovered route classes
  final Set<String> _imports = <String>{};

  /// Generates the complete router code including imports and routes list.
  ///
  /// Scans all Dart files under `lib/` directory and discovers classes
  /// that extend `Route`. Returns formatted Dart code containing all
  /// necessary imports and the `$routes` list.
  ///
  /// [buildStep] - The current build step from build_runner
  ///
  /// Returns a formatted string containing the generated code
  Future<String> generateRouterCode(BuildStep buildStep) async {
    final routes = await _discoverRoutes(buildStep);
    return _generateFormattedCode(routes);
  }

  /// Discovers all Route classes in the project.
  ///
  /// Scans through all Dart files in the lib/ directory and identifies
  /// classes that extend the Route class (excluding abstract classes).
  ///
  /// Returns a sorted list of discovered route information
  Future<List<RouteInfo>> _discoverRoutes(BuildStep buildStep) async {
    final routes = <RouteInfo>[];
    final dartFiles = buildStep.findAssets(Glob(_libGlobPattern));

    await for (final assetId in dartFiles) {
      if (_shouldSkipFile(assetId)) continue;

      final discoveredRoutes = await _analyzeFile(buildStep, assetId);
      routes.addAll(discoveredRoutes);
    }

    // Sort routes alphabetically for consistent output
    routes.sort((a, b) => a.className.compareTo(b.className));
    return routes;
  }

  /// Checks if a file should be skipped during analysis.
  ///
  /// Returns true for generated files and other files that should be excluded
  bool _shouldSkipFile(AssetId assetId) {
    return _excludedFilePatterns.any(
      (pattern) => assetId.path.endsWith(pattern),
    );
  }

  /// Analyzes a single Dart file for Route classes.
  ///
  /// Attempts to resolve the library and extract all classes that extend Route.
  /// Handles analysis errors gracefully by returning an empty list.
  ///
  /// Returns a list of RouteInfo objects found in the file
  Future<List<RouteInfo>> _analyzeFile(
    BuildStep buildStep,
    AssetId assetId,
  ) async {
    try {
      final library = await buildStep.resolver.libraryFor(assetId);
      final routes = <RouteInfo>[];

      for (final element in library.topLevelElements) {
        if (_isRouteClass(element)) {
          routes.add(RouteInfo(className: element.name!));
        }
      }

      // Only add import if we actually found Route classes in this file
      if (routes.isNotEmpty) {
        _imports.add(_buildImportPath(assetId));
      }

      return routes;
    } catch (_) {
      // Ignore files that can't be analyzed (e.g., syntax errors)
      return <RouteInfo>[];
    }
  }

  /// Determines if a class element is a valid Route class.
  ///
  /// A valid Route class must:
  /// - Be a class element
  /// - Not be abstract
  /// - Extend the Route class
  bool _isRouteClass(Element element) {
    if (element is! ClassElement || element.isAbstract) {
      return false;
    }

    return element.allSupertypes.any(
      (type) => type.element.name == _routeClassName,
    );
  }

  /// Builds the import path for a given asset.
  ///
  /// Converts an AssetId to a proper package import path.
  /// Example: lib/routes/user_route.dart -> package:myapp/routes/user_route.dart
  String _buildImportPath(AssetId assetId) {
    final package = assetId.package;
    final relativePath = assetId.path.replaceFirst('lib/', '');
    return 'package:$package/$relativePath';
  }

  /// Generates the complete formatted code output.
  ///
  /// Creates import statements and the routes list, then formats
  /// the entire output using dart_style.
  String _generateFormattedCode(List<RouteInfo> routes) {
    final codeBuffer = StringBuffer();

    // Generate routes list
    _writeRoutesList(codeBuffer, routes);

    return _formatCode(codeBuffer.toString());
  }

  /// Writes all necessary import statements to the buffer.
  ///
  /// Includes the Sarus framework import and all discovered route files,
  /// sorted alphabetically for consistency.
  void _writeImports(StringBuffer buffer) {
    final sortedImports = _imports.toList()..sort();

    for (final import in sortedImports) {
      buffer.writeln("import '$import';");
    }

    if (sortedImports.isNotEmpty) {
      buffer.writeln(); // Add spacing after imports
    }
  }

  /// Writes the routes list declaration to the buffer.
  ///
  /// Creates either an empty list (if no routes found) or a populated
  /// list with all discovered route instances.
  void _writeRoutesList(StringBuffer buffer, List<RouteInfo> routes) {
    buffer.writeln('final List<Route> $_routesListName = [');

    if (routes.isNotEmpty) {
      for (final route in routes) {
        buffer.writeln('  ${route.className}(),');
      }
    }

    buffer.writeln('];');
  }

  /// Formats the generated Dart code using dart_style.
  ///
  /// Attempts to format the code with the latest language version.
  /// Returns the original code if formatting fails.
  String _formatCode(String code) {
    try {
      final formatter = DartFormatter(
        languageVersion: DartFormatter.latestLanguageVersion,
      );
      return formatter.format(code);
    } catch (_) {
      // Return unformatted code as fallback
      return code;
    }
  }

  /// Gets all collected import statements.
  ///
  /// Returns a formatted string containing all import statements
  /// needed for the discovered routes.
  ///
  /// Note: This method is kept for backward compatibility but
  /// [generateRouterCode] should be preferred as it provides
  /// the complete generated code.
  @Deprecated('Use generateRouterCode() instead for complete code generation')
  String getImports() {
    final buffer = StringBuffer();
    _writeImports(buffer);
    return buffer.toString();
  }
}

/// Immutable data class representing information about a discovered Route class.
///
/// Contains metadata about a Route class that was found during the
/// code generation process.
class RouteInfo {
  /// Creates a new RouteInfo instance.
  ///
  /// [className] - The name of the Route class
  const RouteInfo({required this.className});

  /// The name of the discovered Route class
  final String className;

  @override
  String toString() => 'RouteInfo(className: $className)';
}
