---
sidebar_position: 1
---

# Project Structure

Understanding the default project structure in Sarus is key to maintaining clean and scalable applications. Below is an overview of how a typical Sarus project is organized.

```bash title="Project Structure"
my_sarus_project/
├── bin/
│   └── main.dart               # Entry point for your server (main file)
├── lib/
│   ├── config/                   # Application configuration files (e.g., routings, settings)
│   ├── greeting/                 # Your application module (endpoints, middlewares, etc)
│   └── sarus_application.dart    # Generated file by vaden_class_scanner
└── pubspec.yaml                  # Project dependency manager
```

## Project

### Entrypoint

This is the main entry point of your application. It loads the sarus_application.dart and starts the HTTP server:

```jsx title="bin/main.dart"
import 'package:example/sarus_application.dart';

void main(List<String> args) async {
  // Create an instance of the SarusApplication
  final application = SarusApplication();

  // Set up the application
  await application.setup();

  // Start the server
  final server = await application.run();

  // Enable content compression
  server.autoCompress = true;

  print('Server listening on port ${server.port}');
}
```

### Application

This is the main application for sarus project.

```jsx title="lib/sarus_application.dart"
import 'dart:io';

import 'package:example/config/router.dart';
import 'package:sarus/sarus.dart';

class SarusApplication implements Application {
  @override
  Future<HttpServer> run() async {
    try {
      final handler = const Pipeline().addHandler(router.handler);

      return await serve(handler, InternetAddress.anyIPv4, 8080);
    } catch (e) {
      print('Error starting server: $e');
      rethrow;
    }
  }

  @override
  Future<void> setup() async {
    try {} catch (e) {
      print('Failed to setup dependencies injection: $e');
    }
  }
}
```

### Router

This is the main router file for sarus project.

```jsx title="lib/config/router.dart"
import 'package:example/greeting/endpoints.dart';
import 'package:sarus/sarus.dart';

final router = Router(
  globalMiddleware: [logRequests()],
  routes: [Route(endpoints: GreetingEndpoints())],
);
```

## Modules

### Endpoint

This is a endpoint file which helps to define the routes for your application.

```jsx title="lib/greeting/endpoint.dart"
import 'dart:convert';

import 'package:example/greeting/middlewares.dart';
import 'package:sarus/sarus.dart';

part 'endpoints.g.dart';

@Endpoint(path: '/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  @Get()
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from GreetingEndpoint'}));
  }

  @override
  RouterConfig get router => _$greetingEndpointsRouterConfig(this);

  @override
  Handler get handler => const Pipeline()
      .addMiddleware(greetingMiddleware)
      .addHandler(router.call);
}
```

### Middleware

This is a middleware file which helps to define the middlewares for your application.

```jsx title="lib/greeting/middleware.dart"
import 'package:sarus/sarus.dart';

final Middleware greetingMiddleware = createMiddleware(
  requestHandler: (request) {
    print('Greeting Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
```