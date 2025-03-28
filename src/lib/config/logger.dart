// import 'package:dart_frog/dart_frog.dart';
import 'package:shelf/shelf.dart' as shelf;

class Logger {
  static void info(String message) {
    shelf.logRequests(logger: (_, __) {
      print("object: $message");
    });
  }
}
