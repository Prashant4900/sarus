/// Represents HTTP methods that can be used in API requests.
///
/// This enum provides a type-safe way to specify HTTP methods
/// and includes the standard REST methods: GET, POST, PUT, and DELETE.
enum Method {
  /// HTTP GET method - Used to retrieve data
  get('GET'),

  /// HTTP POST method - Used to create new resources
  post('POST'),

  /// HTTP PUT method - Used to update existing resources
  put('PUT'),

  /// HTTP DELETE method - Used to remove resources
  delete('DELETE');

  /// Creates a new [Method] instance with the given [name]
  const Method(this.name);

  /// The string representation of the HTTP method
  final String name;
}
