import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:sarus/sarus.dart';
import 'package:source_gen/source_gen.dart';

// ============================================================================
// MAIN GENERATOR CLASS
// ============================================================================

/// A code generator that creates router configuration functions for classes
/// annotated with [Endpoint].
///
/// This generator processes endpoint classes and their methods to create
/// a router configuration function that automatically handles:
/// - HTTP method routing (GET, POST, PUT, DELETE)
/// - Path and query parameter extraction and type conversion
/// - Request body parsing and deserialization
/// - Parameter validation and error handling
///
/// ## Example Usage
///
/// ```dart
/// @Endpoint(path: '/api/users')
/// class UserEndpoints {
///   @Get(path: '/:id')
///   Future<Response> getUser(@PathParam('id') int id) async {
///     // Implementation
///   }
///
///   @Post(path: '/')
///   Future<Response> createUser(@Body() UserModel user) async {
///     // Implementation
///   }
/// }
/// ```
///
/// ## Generated Output
///
/// ```dart
/// RouterConfig _$userEndpointsRouterConfig(UserEndpoints endpoints) {
///   // Generated router configuration with type-safe parameter handling
/// }
/// ```
class RouteGenerator extends GeneratorForAnnotation<Endpoint> {
  // Constants for naming conventions
  static const String _generatedFunctionPrefix = r'_$';
  static const String _routerConfigSuffix = 'RouterConfig';

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    // Validate that the annotated element is a class
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'Generator can only be applied to classes.',
        element: element,
      );
    }

    final className = element.name;
    final endpointPath = annotation.read('path').stringValue;
    final buffer = StringBuffer();

    // Generate the router configuration function
    _generateRouterFunction(buffer, className, endpointPath, element);

    return _formatGeneratedCode(buffer.toString());
  }

  /// Generates the main router configuration function for the endpoint class.
  ///
  /// Creates a function that:
  /// 1. Instantiates a new RouterConfig
  /// 2. Processes all endpoint methods
  /// 3. Registers route handlers with appropriate parameter handling
  /// 4. Returns the configured router
  void _generateRouterFunction(
    StringBuffer buffer,
    String className,
    String endpointPath,
    ClassElement element,
  ) {
    final functionName = _generateFunctionName(className);

    // Function header with documentation
    buffer.writeln();
    buffer.writeln('/// Generated router configuration for [$className].');
    buffer.writeln(
      '/// This function creates and configures all routes defined in the endpoint class.',
    );
    buffer.writeln('RouterConfig $functionName($className endpoints) {');
    buffer.writeln('  final routerConfig = RouterConfig();');
    buffer.writeln();

    // Process all endpoint methods
    _processEndpointMethods(buffer, element, endpointPath, className);

    // Function footer
    buffer.writeln();
    buffer.writeln('  return routerConfig;');
    buffer.writeln('}');
  }

  /// Generates a camelCase function name from the class name.
  ///
  /// Examples:
  /// - `UserEndpoints` -> `_$userEndpointsRouterConfig`
  /// - `ApiController` -> `_$apiControllerRouterConfig`
  String _generateFunctionName(String className) {
    final formattedClassName = className.isNotEmpty
        ? className[0].toLowerCase() + className.substring(1)
        : className;
    return '$_generatedFunctionPrefix$formattedClassName$_routerConfigSuffix';
  }

  /// Processes all methods in the endpoint class and generates route handlers.
  ///
  /// For each method:
  /// 1. Identifies HTTP method annotations (GET, POST, PUT, DELETE)
  /// 2. Determines if the method requires parameter processing
  /// 3. Generates appropriate route handler code
  void _processEndpointMethods(
    StringBuffer buffer,
    ClassElement element,
    String endpointPath,
    String className,
  ) {
    final methodProcessor = EndpointMethodProcessor();

    for (final method in element.methods) {
      methodProcessor.processMethod(
        buffer: buffer,
        method: method,
        endpointPath: endpointPath,
        className: className,
      );
    }
  }

  /// Formats the generated code using DartFormatter.
  ///
  /// Ensures the generated code follows Dart formatting conventions.
  String _formatGeneratedCode(String code) {
    final formatter = DartFormatter(
      languageVersion: DartFormatter.latestLanguageVersion,
    );
    return formatter.format(code);
  }
}

// ============================================================================
// METHOD PROCESSING
// ============================================================================

/// Handles the processing of individual endpoint methods.
///
/// This class is responsible for:
/// - Detecting HTTP method annotations
/// - Determining parameter processing requirements
/// - Generating appropriate route handlers
class EndpointMethodProcessor {
  /// Processes a single method and generates its route handler.
  void processMethod({
    required StringBuffer buffer,
    required MethodElement method,
    required String endpointPath,
    required String className,
  }) {
    final routeAnnotations = _getRouteAnnotations(method);

    for (final entry in routeAnnotations.entries) {
      if (entry.value != null) {
        final routePath = entry.value!.read('path').stringValue;

        if (_methodRequiresParameterProcessing(method)) {
          _generateParameterizedRouteHandler(
            buffer: buffer,
            httpMethod: entry.key,
            routePath: routePath,
            endpointPath: endpointPath,
            method: method,
            className: className,
          );
        } else {
          _generateSimpleRouteRegistration(
            buffer,
            entry.key,
            routePath,
            endpointPath,
            method.name,
          );
        }
      }
    }
  }

  /// Gets all route annotations for a method.
  ///
  /// Returns a map of HTTP method names to their corresponding annotations.
  Map<String, ConstantReader?> _getRouteAnnotations(MethodElement method) {
    return {
      'get': _getAnnotationOfType<Get>(method),
      'post': _getAnnotationOfType<Post>(method),
      'put': _getAnnotationOfType<Put>(method),
      'delete': _getAnnotationOfType<Delete>(method),
    };
  }

  /// Checks if a method requires parameter processing.
  ///
  /// Returns true if the method has any of:
  /// - @PathParam annotated parameters
  /// - @QueryParam annotated parameters
  /// - @Body annotated parameters
  /// - Request type parameters
  bool _methodRequiresParameterProcessing(MethodElement method) {
    return method.parameters.any(
      (param) =>
          _getAnnotationOfType<PathParam>(param) != null ||
          _getAnnotationOfType<QueryParam>(param) != null ||
          _getAnnotationOfType<Body>(param) != null ||
          param.type.getDisplayString(withNullability: false) == 'Request',
    );
  }

  /// Generates a simple route registration for methods without parameters.
  ///
  /// Creates a direct method call without parameter processing.
  void _generateSimpleRouteRegistration(
    StringBuffer buffer,
    String httpMethod,
    String methodPath,
    String? endpointPath,
    String handlerName,
  ) {
    final fullPath = PathBuilder.buildFullPath(endpointPath, methodPath);
    buffer.writeln(
      "  routerConfig.$httpMethod('$fullPath', endpoints.$handlerName);",
    );
  }

  /// Generates a parameterized route handler for methods with parameter annotations.
  ///
  /// Creates a wrapper function that:
  /// 1. Extracts parameters from the request
  /// 2. Validates and converts parameter types
  /// 3. Calls the original method with processed parameters
  /// 4. Handles errors appropriately
  void _generateParameterizedRouteHandler({
    required StringBuffer buffer,
    required String httpMethod,
    required String routePath,
    required String? endpointPath,
    required MethodElement method,
    required String className,
  }) {
    final fullPath = PathBuilder.buildFullPath(endpointPath, routePath);
    final routeHandlerGenerator = RouteHandlerGenerator();

    final routeHandler = routeHandlerGenerator.generateRouteHandler(
      method: method,
      fullPath: fullPath,
      httpMethod: httpMethod,
    );

    buffer.writeln(routeHandler);
  }

  /// Gets an annotation of a specific type from an element.
  ConstantReader? _getAnnotationOfType<T>(Element element) {
    final annotations = TypeChecker.fromRuntime(T)
        .annotationsOf(element, throwOnUnresolved: false);

    return annotations.isEmpty ? null : ConstantReader(annotations.first);
  }
}

// ============================================================================
// ROUTE HANDLER GENERATION
// ============================================================================

/// Generates route handler functions with parameter processing.
///
/// This class creates the wrapper functions that handle:
/// - Parameter extraction from requests
/// - Type conversion and validation
/// - Error handling and response formatting
class RouteHandlerGenerator {
  /// Generates a complete route handler with parameter extraction and validation.
  ///
  /// The generated handler:
  /// 1. Wraps the original method in a try-catch block
  /// 2. Extracts and validates parameters
  /// 3. Calls the original method with processed parameters
  /// 4. Handles common error types (ArgumentError, FormatException)
  String generateRouteHandler({
    required MethodElement method,
    required String fullPath,
    required String httpMethod,
  }) {
    final buffer = StringBuffer();
    final parameterExtractor = ParameterExtractor();
    final extractionResult = parameterExtractor.generateExtractionCode(method);

    // Generate route handler with error handling
    buffer.writeln(
      "  routerConfig.$httpMethod('$fullPath', (Request req) async {",
    );
    buffer.writeln('    try {');

    // Add parameter extraction code
    buffer.writeln(extractionResult.code);

    // Call the original method with extracted parameters
    buffer.writeln(
      '      return endpoints.${method.name}(${extractionResult.callArgs.join(', ')});',
    );

    // Error handling
    buffer.writeln('    } catch (e) {');
    buffer.writeln('      if (e is ArgumentError) {');
    buffer.writeln('        return Response.badRequest(body: e.message);');
    buffer.writeln('      }');
    buffer.writeln('      if (e is FormatException) {');
    buffer.writeln(
      r"        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');",
    );
    buffer.writeln('      }');
    buffer.writeln('      rethrow;');
    buffer.writeln('    }');
    buffer.writeln('  });');
    buffer.writeln();

    return buffer.toString();
  }
}

// ============================================================================
// PARAMETER EXTRACTION
// ============================================================================

/// Handles parameter extraction and type conversion for route handlers.
///
/// This class processes method parameters and generates code to:
/// - Extract values from path parameters, query parameters, and request body
/// - Convert string values to appropriate types (int, double, bool, etc.)
/// - Handle nullable parameters and default values
/// - Validate required parameters
class ParameterExtractor {
  /// Generates parameter extraction code for all parameters in a method.
  ///
  /// Returns an [ExtractionResult] containing:
  /// - The complete extraction code
  /// - The list of call arguments for the method invocation
  ExtractionResult generateExtractionCode(MethodElement method) {
    final buffer = StringBuffer();
    final callArgs = <String>[];

    for (final param in method.parameters) {
      final result = _processParameter(param);
      if (result.extractionCode.isNotEmpty) {
        buffer.writeln(result.extractionCode);
      }
      callArgs.add(result.callArg);
    }

    return ExtractionResult(
      code: buffer.toString(),
      callArgs: callArgs,
    );
  }

  /// Processes a single parameter and generates its extraction code.
  ///
  /// Handles different parameter types:
  /// - @PathParam: Extracts from URL path segments
  /// - @QueryParam: Extracts from URL query parameters
  /// - @Body: Extracts and deserializes from request body
  /// - Request: Passes the request object directly
  /// - Unannotated: Passes null
  ParameterResult _processParameter(ParameterElement param) {
    final pathParam = _getAnnotationOfType<PathParam>(param);
    final queryParam = _getAnnotationOfType<QueryParam>(param);
    final bodyParam = _getAnnotationOfType<Body>(param);

    // Handle Request type parameters
    if (param.type.getDisplayString(withNullability: false) == 'Request') {
      return const ParameterResult(extractionCode: '', callArg: 'req');
    }

    // Handle path parameters
    if (pathParam != null) {
      return _generateParameterExtraction(param, pathParam, isPath: true);
    }

    // Handle query parameters
    if (queryParam != null) {
      return _generateParameterExtraction(param, queryParam, isPath: false);
    }

    // Handle body parameters
    if (bodyParam != null) {
      return _generateBodyExtraction(param);
    }

    // No annotation, pass null
    return const ParameterResult(extractionCode: '', callArg: 'null');
  }

  /// Generates parameter extraction code for @PathParam and @QueryParam annotated parameters.
  ///
  /// Creates code that:
  /// 1. Extracts the raw string value from path or query
  /// 2. Validates required parameters
  /// 3. Converts the string to the appropriate type
  /// 4. Handles nullable parameters and default values
  ParameterResult _generateParameterExtraction(
    ParameterElement param,
    ConstantReader annotation, {
    required bool isPath,
  }) {
    final name = annotation.read('name').stringValue;
    final defaultVal = annotation.peek('defaultValue')?.stringValue;
    final isNullable = param.type.nullabilitySuffix.name == 'question';
    final paramType = param.type.getDisplayString(withNullability: false);

    final typeConverter = TypeConverter();
    final extractionCode = typeConverter.generateExtractionCode(
      paramName: param.name,
      sourceName: name,
      paramType: paramType,
      isNullable: isNullable,
      defaultValue: defaultVal,
      isPath: isPath,
    );

    return ParameterResult(
      extractionCode: extractionCode,
      callArg: param.name,
    );
  }

  /// Generates body extraction code for @Body annotated parameters.
  ///
  /// Creates code that:
  /// 1. Reads the request body as a string
  /// 2. Parses the JSON content
  /// 3. Validates the JSON structure
  /// 4. Deserializes to the target type using fromJson
  /// 5. Handles nullable body parameters
  ParameterResult _generateBodyExtraction(ParameterElement param) {
    final isNullable = param.type.nullabilitySuffix.name == 'question';
    final paramType = param.type.getDisplayString(withNullability: false);
    final buffer = StringBuffer();

    buffer.writeln('      // Extract and parse request body');
    buffer.writeln('      final bodyString = await req.readAsString();');

    if (isNullable) {
      _generateNullableBodyExtraction(buffer, param.name, paramType);
    } else {
      _generateRequiredBodyExtraction(buffer, param.name, paramType);
    }

    return ParameterResult(
      extractionCode: buffer.toString(),
      callArg: param.name,
    );
  }

  /// Generates extraction code for nullable body parameters.
  void _generateNullableBodyExtraction(
    StringBuffer buffer,
    String paramName,
    String paramType,
  ) {
    buffer.writeln(
      '      final $paramName = bodyString.isEmpty ? null : (() {',
    );
    buffer.writeln('        try {');
    buffer.writeln('          final bodyJson = jsonDecode(bodyString);');
    buffer.writeln('          if (bodyJson is! Map<String, dynamic>) {');
    buffer.writeln(
      "            throw ArgumentError('Request body must be a JSON object');",
    );
    buffer.writeln('          }');
    buffer.writeln('          return $paramType.fromJson(bodyJson);');
    buffer.writeln('        } catch (e) {');
    buffer.writeln('          if (e is ArgumentError) rethrow;');
    buffer.writeln(
      r"          throw FormatException('Failed to parse request body: $e');",
    );
    buffer.writeln('        }');
    buffer.writeln('      })();');
  }

  /// Generates extraction code for required body parameters.
  void _generateRequiredBodyExtraction(
    StringBuffer buffer,
    String paramName,
    String paramType,
  ) {
    buffer.writeln('      if (bodyString.isEmpty) {');
    buffer.writeln("        throw ArgumentError('Request body is required');");
    buffer.writeln('      }');
    buffer.writeln('      final $paramName = (() {');
    buffer.writeln('        try {');
    buffer.writeln('          final bodyJson = jsonDecode(bodyString);');
    buffer.writeln('          if (bodyJson is! Map<String, dynamic>) {');
    buffer.writeln(
      "            throw ArgumentError('Request body must be a JSON object');",
    );
    buffer.writeln('          }');
    buffer.writeln('          return $paramType.fromJson(bodyJson);');
    buffer.writeln('        } catch (e) {');
    buffer.writeln('          if (e is ArgumentError) rethrow;');
    buffer.writeln(
      r"          throw FormatException('Failed to parse request body: $e');",
    );
    buffer.writeln('        }');
    buffer.writeln('      })();');
  }

  /// Gets an annotation of a specific type from an element.
  ConstantReader? _getAnnotationOfType<T>(Element element) {
    final annotations = TypeChecker.fromRuntime(T)
        .annotationsOf(element, throwOnUnresolved: false);

    return annotations.isEmpty ? null : ConstantReader(annotations.first);
  }
}

// ============================================================================
// TYPE CONVERSION
// ============================================================================

/// Handles type conversion for different parameter types.
///
/// This class generates code to convert string values from HTTP requests
/// to the appropriate Dart types, including:
/// - String (direct assignment)
/// - int (with validation)
/// - double (with validation)
/// - bool (with flexible parsing)
/// - Custom types (defaults to string handling)
class TypeConverter {
  /// Generates type conversion code for a parameter.
  ///
  /// Creates code that:
  /// 1. Extracts the raw string value
  /// 2. Validates required parameters
  /// 3. Converts to the target type
  /// 4. Handles nullable parameters and default values
  /// 5. Provides meaningful error messages
  String generateExtractionCode({
    required String paramName,
    required String sourceName,
    required String paramType,
    required bool isNullable,
    required String? defaultValue,
    required bool isPath,
  }) {
    final buffer = StringBuffer();
    final source = isPath
        ? "req.params['$sourceName']"
        : "req.url.queryParameters['$sourceName']";
    final paramLocation = isPath ? 'path parameter' : 'query parameter';

    // Extract raw value
    buffer.writeln('      final ${paramName}Raw = $source;');

    // Validate required parameters
    if (!isNullable) {
      buffer.writeln('      if (${paramName}Raw == null) {');
      buffer.writeln(
        "        throw ArgumentError('Missing required $paramLocation: $sourceName');",
      );
      buffer.writeln('      }');
    }

    // Generate type-specific conversion
    _generateTypeConversion(
      buffer,
      paramName,
      paramType,
      isNullable,
      defaultValue,
      paramLocation,
      sourceName,
    );

    return buffer.toString();
  }

  /// Generates type-specific conversion code.
  ///
  /// Delegates to specific conversion methods based on the parameter type.
  void _generateTypeConversion(
    StringBuffer buffer,
    String paramName,
    String paramType,
    bool isNullable,
    String? defaultValue,
    String paramLocation,
    String sourceName,
  ) {
    switch (paramType) {
      case 'String':
        _generateStringConversion(buffer, paramName, isNullable, defaultValue);
      case 'int':
        _generateIntConversion(
          buffer,
          paramName,
          isNullable,
          defaultValue,
          paramLocation,
          sourceName,
        );
      case 'double':
        _generateDoubleConversion(
          buffer,
          paramName,
          isNullable,
          defaultValue,
          paramLocation,
          sourceName,
        );
      case 'bool':
        _generateBoolConversion(
          buffer,
          paramName,
          isNullable,
          defaultValue,
          paramLocation,
          sourceName,
        );
      default:
        // Default to string conversion for unknown types
        _generateStringConversion(buffer, paramName, isNullable, defaultValue);
    }
  }

  /// Generates string conversion code.
  ///
  /// For string parameters, no conversion is needed, just assignment
  /// with optional default value handling.
  void _generateStringConversion(
    StringBuffer buffer,
    String paramName,
    bool isNullable,
    String? defaultValue,
  ) {
    final defaultPart = defaultValue != null ? " ?? '$defaultValue'" : '';
    buffer.writeln(
      '      final $paramName = ${paramName}Raw$defaultPart;',
    );
  }

  /// Generates integer conversion code.
  ///
  /// Uses int.tryParse() for safe conversion with validation.
  /// Handles nullable and non-nullable cases differently.
  void _generateIntConversion(
    StringBuffer buffer,
    String paramName,
    bool isNullable,
    String? defaultValue,
    String paramLocation,
    String sourceName,
  ) {
    if (isNullable) {
      buffer.writeln(
        '      final $paramName = ${paramName}Raw != null ? int.tryParse(${paramName}Raw) : null;',
      );
      // Add validation for nullable parameters with default values
      if (defaultValue != null) {
        buffer.writeln(
          '      if ($paramName == null && ${paramName}Raw != null) {',
        );
        buffer.writeln(
          "        throw ArgumentError('Invalid integer value for $paramLocation $sourceName: \$${paramName}Raw');",
        );
        buffer.writeln('      }');
      }
    } else {
      buffer.writeln(
        '      final ${paramName}Parsed = int.tryParse(${paramName}Raw);',
      );
      buffer.writeln('      if (${paramName}Parsed == null) {');
      buffer.writeln(
        "        throw ArgumentError('Invalid integer value for $paramLocation $sourceName: \$${paramName}Raw');",
      );
      buffer.writeln('      }');

      final defaultPart = defaultValue != null ? ' ?? $defaultValue' : '';
      buffer.writeln(
        '      final $paramName = ${paramName}Parsed$defaultPart;',
      );
    }
  }

  /// Generates double conversion code.
  ///
  /// Uses double.tryParse() for safe conversion with validation.
  /// Similar structure to integer conversion.
  void _generateDoubleConversion(
    StringBuffer buffer,
    String paramName,
    bool isNullable,
    String? defaultValue,
    String paramLocation,
    String sourceName,
  ) {
    if (isNullable) {
      buffer.writeln(
        '      final $paramName = ${paramName}Raw != null ? double.tryParse(${paramName}Raw) : null;',
      );
      if (defaultValue != null) {
        buffer.writeln(
          '      if ($paramName == null && ${paramName}Raw != null) {',
        );
        buffer.writeln(
          "        throw ArgumentError('Invalid double value for $paramLocation $sourceName: \$${paramName}Raw');",
        );
        buffer.writeln('      }');
      }
    } else {
      buffer.writeln(
        '      final ${paramName}Parsed = double.tryParse(${paramName}Raw);',
      );
      buffer.writeln('      if (${paramName}Parsed == null) {');
      buffer.writeln(
        "        throw ArgumentError('Invalid double value for $paramLocation $sourceName: \$${paramName}Raw');",
      );
      buffer.writeln('      }');

      final defaultPart = defaultValue != null ? ' ?? $defaultValue' : '';
      buffer.writeln(
        '      final $paramName = ${paramName}Parsed$defaultPart;',
      );
    }
  }

  /// Generates boolean conversion code.
  ///
  /// Uses the parseBool() utility function for flexible boolean parsing.
  /// Supports multiple boolean representations.
  void _generateBoolConversion(
    StringBuffer buffer,
    String paramName,
    bool isNullable,
    String? defaultValue,
    String paramLocation,
    String sourceName,
  ) {
    if (isNullable) {
      buffer.writeln(
        '      final $paramName = ${paramName}Raw != null ? parseBool(${paramName}Raw) : null;',
      );
      if (defaultValue != null) {
        buffer.writeln(
          '      if ($paramName == null && ${paramName}Raw != null) {',
        );
        buffer.writeln(
          "        throw ArgumentError('Invalid boolean value for $paramLocation $sourceName: \${${paramName}Raw}');",
        );
        buffer.writeln('      }');
      }
    } else {
      buffer.writeln(
        '      final ${paramName}Parsed = parseBool(${paramName}Raw);',
      );
      buffer.writeln('      if (${paramName}Parsed == null) {');
      buffer.writeln(
        "        throw ArgumentError('Invalid boolean value for $paramLocation $sourceName: \${${paramName}Raw}');",
      );
      buffer.writeln('      }');

      final defaultPart = defaultValue != null ? ' ?? $defaultValue' : '';
      buffer.writeln(
        '      final $paramName = ${paramName}Parsed$defaultPart;',
      );
    }
  }
}

// ============================================================================
// UTILITY CLASSES
// ============================================================================

/// Utility class for building URL paths.
///
/// Handles the combination of endpoint paths and method paths,
/// ensuring proper formatting and avoiding double slashes.
class PathBuilder {
  /// Builds the full path by combining endpoint path and method path.
  ///
  /// Examples:
  /// - `('/api/users', '/:id')` -> `'/api/users/:id'`
  /// - `('/api', '/users')` -> `'/api/users'`
  /// - `('', '/users')` -> `'/users'`
  static String buildFullPath(String? endpointPath, String methodPath) {
    final basePath = (endpointPath ?? '').trim();
    final routePath = methodPath.trim();

    final segments = [basePath, routePath]
        .where((segment) => segment.isNotEmpty)
        .map((s) => s.startsWith('/') ? s.substring(1) : s);

    return '/${segments.join('/')}';
  }
}

// ============================================================================
// DATA CLASSES
// ============================================================================

/// Result of parameter extraction code generation.
///
/// Contains the generated code and the list of call arguments
/// needed to invoke the original method.
class ExtractionResult {
  const ExtractionResult({
    required this.code,
    required this.callArgs,
  });

  /// The generated parameter extraction code.
  final String code;

  /// The list of argument names to pass to the method call.
  final List<String> callArgs;
}

/// Result of processing a single parameter.
///
/// Contains the extraction code for one parameter and the
/// corresponding call argument.
class ParameterResult {
  const ParameterResult({
    required this.extractionCode,
    required this.callArg,
  });

  /// The extraction code for this parameter.
  final String extractionCode;

  /// The call argument for this parameter.
  final String callArg;
}

// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/// Parses a string value to a boolean with flexible input handling.
///
/// ## Supported Boolean Representations
///
/// **True values:**
/// - `'true'` (case insensitive)
/// - `'1'`
/// - `'yes'` (case insensitive)
/// - `'on'` (case insensitive)
///
/// **False values:**
/// - `'false'` (case insensitive)
/// - `'0'`
/// - `'no'` (case insensitive)
/// - `'off'` (case insensitive)
///
/// ## Return Value
/// - Returns `true` for true values
/// - Returns `false` for false values
/// - Returns `null` if the value cannot be parsed
///
/// ## Examples
/// ```dart
/// parseBool('true')  // true
/// parseBool('1')     // true
/// parseBool('yes')   // true
/// parseBool('false') // false
/// parseBool('0')     // false
/// parseBool('no')    // false
/// parseBool('maybe') // null
/// ```
bool? parseBool(String value) {
  final lower = value.toLowerCase();
  switch (lower) {
    case 'true':
    case '1':
    case 'yes':
    case 'on':
      return true;
    case 'false':
    case '0':
    case 'no':
    case 'off':
      return false;
    default:
      return null;
  }
}
