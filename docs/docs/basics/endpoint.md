---
sidebar_position: 2
---

# Endpoint

A `@Endpoint()` in Sarus defines a class that handles HTTP routes. It's one of the core building blocks of the framework.

The value passed to `@Endpoint(path: '/greeting')` defines a route prefix applied to all methods in that class. For example:

```ts
import 'dart:convert';

import 'package:example/greeting/middlewares.dart';
import 'package:sarus/sarus.dart';

part '../tutorial-basics/endpoints.g.dart';

@Endpoint(path: '/greeting')
class GreetingEndpoints extends Endpoints {
  GreetingEndpoints() : super();

  @Get(path: '/message')
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

This will map to `/greeting/message` in the HTTP server.

**Note: The base path `/greeting` applies to all methods inside.**

## HTTP Method Handlers

Sarus supports the following method decorators:

- `@Get()`
- `@Post()`
- `@Put()`
- `@Delete()`
- `@Patch()`
- `@Head()`
- `@Options()`