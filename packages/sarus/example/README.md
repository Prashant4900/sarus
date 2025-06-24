# Example

To explore the full example you can check the official repository at [sarus_example]()

```dart
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