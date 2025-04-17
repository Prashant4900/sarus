import 'dart:io';

class Configuration {
  const Configuration();
}

abstract class Application {
  Future<HttpServer> run();

  Future<void> setup();

  Future<void> close();
}
