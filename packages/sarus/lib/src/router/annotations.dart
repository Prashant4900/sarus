/// Base annotation for all HTTP methods
abstract class HttpRoute {
  const HttpRoute(this.path);
  final String path;
}

/// GET route annotation
class Get extends HttpRoute {
  const Get(super.path);
}

/// POST route annotation
class Post extends HttpRoute {
  const Post(super.path);
}

/// PUT route annotation
class Put extends HttpRoute {
  const Put(super.path);
}

/// DELETE route annotation
class Delete extends HttpRoute {
  const Delete(super.path);
}

/// Controller annotation to define base path
class Controller {
  const Controller([this.path = '']);
  final String path;
}
