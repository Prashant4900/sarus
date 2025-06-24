/// Base annotation for all HTTP methods
abstract class HttpRoute {
  const HttpRoute({this.path = ''});

  final String path;
}

/// GET route annotation
class Get extends HttpRoute {
  const Get();
}

/// POST route annotation
class Post extends HttpRoute {
  const Post();
}

/// PUT route annotation
class Put extends HttpRoute {
  const Put();
}

/// DELETE route annotation
class Delete extends HttpRoute {
  const Delete();
}

/// Endpoint annotation to define base path
class Endpoint {
  const Endpoint({this.path = ''});

  final String path;
}
