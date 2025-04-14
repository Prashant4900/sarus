/// Represents HTTP methods that can be used in API requests.
///
/// This enum provides a type-safe way to specify HTTP methods
/// and includes the standard REST methods: GET, POST, PUT, DELETE,
/// as well as other less commonly used HTTP verbs.
enum HttpMethod {
  /// HTTP GET method - Used to retrieve data
  get('GET'),

  /// HTTP POST method - Used to create new resources
  post('POST'),

  /// HTTP PUT method - Used to update existing resources
  put('PUT'),

  /// HTTP PATCH method - Used to apply partial modifications to a resource
  patch('PATCH'),

  /// HTTP DELETE method - Used to remove resources
  delete('DELETE'),

  /// HTTP HEAD method - Similar to GET, but does not return the response body.
  /// Commonly used to check resource metadata or headers.
  head('HEAD'),

  /// Represents a wildcard method that matches any HTTP verb.
  /// Typically used in scenarios such as middleware or route interception.
  all('ALL'),

  /// HTTP CONNECT method - Used to establish a tunnel to the server,
  /// typically for SSL-encrypted communication through a proxy.
  connect('CONNECT'),

  /// HTTP TRACE method - Echoes the received request to assist with
  /// diagnostic and debugging processes.
  trace('TRACE'),

  /// HTTP OPTIONS method - Used to describe the communication options
  /// available for a target resource, often used in CORS preflight requests.
  options('OPTIONS');

  /// Creates a new [HttpMethod] instance with the given [name].
  const HttpMethod(this.name);

  /// The string representation of the HTTP method.
  final String name;
}
