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
