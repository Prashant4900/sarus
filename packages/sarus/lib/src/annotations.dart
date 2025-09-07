part of '_internal.dart';

/// The base annotation for all HTTP method annotations (`@Get`, `@Post`, etc).
///
/// Used internally by the code generator to extract metadata from methods.
///
/// You can optionally provide a `path`, which is appended to the
/// enclosing `@Endpoint()` class path.
///
/// Example:
/// ```dart
/// @Get(path: '/details')
/// Future<Response> getDetails(Request req) async => ...
/// ```
abstract class HttpRoute {
  const HttpRoute({this.path = ''});

  /// Optional subpath for this method-level route.
  final String path;
}

/// Annotation to define an HTTP GET route.
///
/// Marks a method as a handler for GET requests within an `@Endpoint()` class.
///
/// Example:
/// ```dart
/// @Get()
/// Future<Response> index(Request req) async => ...
/// ```
///
/// You can optionally specify a subpath:
/// ```dart
/// @Get(path: '/details')
/// Future<Response> details(Request req) async => ...
/// ```
class Get extends HttpRoute {
  // const Get();
  const Get({super.path});
}

/// Annotation to define an HTTP POST route.
///
/// Used for handling POST requests in an endpoint class.
///
/// Example:
/// ```dart
/// @Post()
/// Future<Response> create(Request req) async => ...
/// ```
class Post extends HttpRoute {
  const Post({super.path});
}

/// Annotation to define an HTTP PUT route.
///
/// Used for update operations in RESTful design.
///
/// Example:
/// ```dart
/// @Put(path: '/update/:id')
/// Future<Response> update(Request req) async => ...
/// ```
class Put extends HttpRoute {
  const Put({super.path});
}

/// Annotation to define an HTTP DELETE route.
///
/// Commonly used for delete operations:
///
/// Example:
/// ```dart
/// @Delete(path: '/:id')
/// Future<Response> delete(Request req) async => ...
/// ```
class Delete extends HttpRoute {
  const Delete({super.path});
}

/// Annotation to define an HTTP PATCH route.
///
/// Marks a method as a handler for PATCH requests within an `@Endpoint()` class.
///
/// Example:
/// ```dart
/// @Patch()
/// Future<Response> patch(Request req) async => ...
/// ```
class Patch extends HttpRoute {
  const Patch({super.path});
}

/// Annotation to define an HTTP HEAD route.
///
/// Marks a method as a handler for HEAD requests within an `@Endpoint()` class.
///
/// Example:
/// ```dart
/// @Head()
/// Future<Response> head(Request req) async => ...
/// ```
class Head extends HttpRoute {
  const Head({super.path});
}

/// Annotation to define an HTTP OPTIONS route.
///
/// Marks a method as a handler for OPTIONS requests within an `@Endpoint()` class.
///
/// Example:
/// ```dart
/// @Options()
/// Future<Response> options(Request req) async => ...
/// ```
class Options extends HttpRoute {
  const Options({super.path});
}

/// Annotation to define a base path for a group of HTTP routes.
///
/// Applied to a class that extends `Endpoints`, this sets the base
/// URI path prefix for all annotated methods within the class.
///
/// Example:
/// ```dart
/// @Endpoint(path: '/users')
/// class UserEndpoints extends Endpoints {
///   @Get()
///   Future<Response> list(Request req) => ...
///
///   @Post(path: '/create')
///   Future<Response> create(Request req) => ...
/// }
/// ```
///
/// This would generate:
/// - GET `/users`
/// - POST `/users/create`
class Endpoint {
  const Endpoint({this.path = ''});

  /// Base path prefix for the endpoint class.
  final String path;
}

/// Annotation to define a query parameter for an HTTP route.
///
/// Used to extract query parameters from the request URL.
/// Example:
/// ```dart
/// @Get(path: '/search')
/// Future<Response> search(Request req, @QueryParam('q') String query) async => ...
/// ```
class QueryParam {
  const QueryParam(this.name, {this.defaultValue});

  /// The name of the query parameter.
  final String name;

  /// Optional default value if the parameter is not provided.
  final String? defaultValue;
}

/// Annotation to define a path parameter for an HTTP route.
///
/// Used to extract path parameters from the request URL.
///
/// Example:
/// ```dart
/// @Get(path: '/users/<id>')
/// Future<Response> getUser(Request req, @PathParam('id') String userId) async => ...
/// ```
class PathParam {
  const PathParam(this.name, {this.defaultValue});

  /// The name of the path parameter.
  final String name;

  final String? defaultValue;
}

/// Annotation to define a request body for an HTTP route.
//////
/// Used to extract the body of a request, typically for POST or PUT methods.
////// Example:
/// ```dart
/// @Post(path: '/create')
/// Future<Response> createUser(Request req, @Body User user) async => ...
/// ```
class Body {
  const Body();
}

/// An annotation for customizing how individual fields are serialized
/// to and from JSON.
///
/// This annotation can be applied to class fields to control their
/// JSON serialization behavior, including custom field names and
/// null value handling.
///
/// ## Usage:
/// ```dart
/// @DTO()
/// class User {
///   final String name;
///
///   @JsonKey(name: 'user_id')
///   final int id;
///
///   @JsonKey(name: 'email_address', includeIfNull: true)
///   final String? email;
///
///   @JsonKey(includeIfNull: false)
///   final String? nickname;
///
///   User({required this.name, required this.id, this.email, this.nickname});
/// }
/// ```
///
/// This will generate JSON serialization that:
/// - Maps the `id` field to `user_id` in JSON
/// - Maps the `email` field to `email_address` in JSON
/// - Includes the `email` field even when null
/// - Excludes the `nickname` field when null
///
/// ## Examples:
///
/// ### Custom Field Names:
/// ```dart
/// @JsonKey(name: 'created_at')
/// final DateTime createdAt;
/// ```
/// Maps `createdAt` property to `created_at` in JSON.
///
/// ### Null Handling:
/// ```dart
/// @JsonKey(includeIfNull: false)
/// final String? optionalField;
/// ```
/// Excludes the field from JSON when its value is null.
///
/// ### Combined Usage:
/// ```dart
/// @JsonKey(name: 'phone_number', includeIfNull: false)
/// final String? phoneNumber;
/// ```
/// Uses custom field name and excludes when null.
class JsonKey {
  /// Creates a new JsonKey annotation with optional customization.
  ///
  /// [name] The custom field name to use in JSON serialization.
  /// If not provided, the original field name will be used.
  ///
  /// [includeIfNull] Whether to include this field in JSON output
  /// when its value is null. Defaults to `false`, meaning null
  /// values will be excluded from the JSON output.
  ///
  /// ## Examples:
  /// ```dart
  /// // Use custom field name
  /// @JsonKey(name: 'user_id')
  /// final int id;
  ///
  /// // Exclude when null
  /// @JsonKey(includeIfNull: false)
  /// final String? nickname;
  ///
  /// // Include when null (explicit)
  /// @JsonKey(includeIfNull: true)
  /// final String? email;
  ///
  /// // Custom name and exclude when null
  /// @JsonKey(name: 'phone_number', includeIfNull: false)
  /// final String? phoneNumber;
  /// ```
  const JsonKey({
    this.name,
    this.includeIfNull = false,
  });

  /// The custom field name to use in JSON serialization.
  ///
  /// When this is provided, the JSON key will use this name instead
  /// of the original field name. This is useful for adapting to
  /// different naming conventions (e.g., snake_case in JSON vs
  /// camelCase in Dart).
  ///
  /// If `null`, the original field name will be used.
  ///
  /// ## Examples:
  /// ```dart
  /// @JsonKey(name: 'first_name')
  /// final String firstName; // JSON: {"first_name": "John"}
  ///
  /// @JsonKey(name: 'created_at')
  /// final DateTime createdAt; // JSON: {"created_at": "2023-01-01T00:00:00Z"}
  /// ```
  final String? name;

  /// Whether to include this field in JSON output when its value is null.
  ///
  /// When `false` (default), null values will be excluded from the
  /// generated JSON. When `true`, null values will be explicitly
  /// included in the JSON output.
  ///
  /// ## Default Behavior:
  /// By default, this is set to `false` to reduce JSON payload size
  /// and avoid unnecessary null values in the output.
  ///
  /// ## Examples:
  /// ```dart
  /// @JsonKey(includeIfNull: false)
  /// final String? nickname;
  /// // When nickname is null: field is excluded from JSON
  /// // When nickname is "Bob": {"nickname": "Bob"}
  ///
  /// @JsonKey(includeIfNull: true)
  /// final String? email;
  /// // When email is null: {"email": null}
  /// // When email is "user@example.com": {"email": "user@example.com"}
  /// ```
  ///
  /// ## Use Cases:
  /// - Set to `false` for optional fields that don't need to appear in JSON
  /// - Set to `true` when the API expects explicit null values
  /// - Set to `true` for fields that must always be present in JSON schema
  final bool includeIfNull;
}
