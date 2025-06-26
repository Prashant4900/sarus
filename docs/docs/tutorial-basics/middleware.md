---
sidebar_position: 3
---

# Middleware

Middleware in Sarus builds on top of the Shelf pipeline allows you to execute code before and after a request is processed. You can modify the inbound request and outbound responses, provide dependencies, and more!

## Creating Middleware

```ts title="middleware.dart"
import 'package:sarus/sarus.dart';

final Middleware greetingMiddleware = createMiddleware(
  requestHandler: (request) {
    print('Greeting Request: ${request.method} ${request.requestedUri}');
    return null;
  },
);
```
