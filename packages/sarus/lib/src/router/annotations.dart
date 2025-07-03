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
  const Get();
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
  const Post();
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
  const Put();
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
  const Delete();
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
