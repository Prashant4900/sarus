import 'dart:io';

/// An abstract class that defines the contract for a Sarus application.
///
/// Every Sarus application must define how to:
/// - **Initialize** the application with necessary setup/configuration
/// - **Start** the server and begin listening for incoming requests
///
/// This pattern allows for clean separation between setup and server startup,
/// and encourages testability and scalability for larger apps.
abstract class Application {
  /// Initializes the application.
  ///
  /// This is where you should load environment variables, register services,
  /// initialize dependencies, configure databases, etc.
  ///
  /// Called **before** the server starts.
  Future<void> setup();

  /// Starts the HTTP server.
  ///
  /// This should bind the HTTP server to a specific address and port, and
  /// attach a request handler (typically using `shelf`).
  ///
  /// Returns the started [HttpServer] instance.
  Future<HttpServer> run();
}
