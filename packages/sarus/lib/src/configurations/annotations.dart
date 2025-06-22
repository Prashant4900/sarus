import 'dart:io';

abstract class Application {
  Future<HttpServer> run();

  Future<void> setup();
}
