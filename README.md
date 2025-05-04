[![Sarus Logo][logo_white]][sarus_link_light]
[![Sarus Logo][logo_black]][sarus_link_dark]

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![style: very good analysis][sarus_badge]][sarus_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Sarus — Minimalistic. Modular. The backend Dart has been waiting for.

Developed with 💙 by [Sarus][sarus_link] 🦄

<!-- ## Documentation 📝

For official documentation, please visit https://dartfrog.vgv.dev.

## Packages 📦

| Package                                                                                                         | Pub                                                                                                                    |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| [sarus](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog)                           | [![pub package](https://img.shields.io/pub/v/dart_frog.svg)](https://pub.dev/packages/dart_frog)                       |
| [sarus_gen](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_gen)                   | [![pub package](https://img.shields.io/pub/v/dart_frog_gen.svg)](https://pub.dev/packages/dart_frog_gen)               |
| [sarus_cli](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_cli)                   | [![pub package](https://img.shields.io/pub/v/dart_frog_cli.svg)](https://pub.dev/packages/dart_frog_cli)               |
| [stormberry](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_web_socket)           | [![pub package](https://img.shields.io/pub/v/dart_frog_web_socket.svg)](https://pub.dev/packages/dart_frog_web_socket) | -->


## Quick Start 🚀

### Prerequisites 📝

In order to use Dart Frog you must have the [Dart SDK][dart_installation_link] installed on your machine.

### Installing 🧑‍💻

```sh
# 📦 Install the sarus cli from github
dart pub global activate --source git https://github.com/Prashant4900/sarus.git --git-path packages/sarus_cli
```

### Creating a Project ✨

Use the `sarus create` command to create a new project.

```sh
# 🚀 Create a new project called "my_project"
sarus create my_project
```

### Configure Database

Configure your PostgreSQL database connection using environment variables, or remove this section if your project doesn’t require a database.

```dart
class Database {
  final _conn = Connection.open(
    Endpoint(
      host: Platform.environment['DB_HOST'] ?? 'localhost',
      database: Platform.environment['DB_NAME'] ?? 'postgres',
      username: Platform.environment['DB_USER'] ?? 'postgres',
      password: Platform.environment['DB_PASS'] ?? 'admin',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  Future<Connection> getConnection() async => _conn;

  Future<void> close() async {
    final res = await _conn;
    await res.close();
  }
}
```

### Create Model

```dart
import 'package:sarus/sarus.dart';

part 'models.schema.dart';

// Create the models
@Model(tableName: 'admins')
abstract class Admin {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String? get firstName;

  String? get lastName;

  String get email;

  String get password;
}
```

### Note: 
- Primary key should have AutoIncrement annotation.
- Sometimes auto generated not works as expected so for that please comment part 'models.schema.dart' first then generate the code and for more details you can follow the official [stormberry](https://pub.dev/packages/stormberry) documentation.

### Start the Dev Server 🏁

Next, open the newly created project and start the dev server via:

```sh
# 🏁 Start the dev server
dart run --enable-vm-service lib/main.dart
```

💡 **Tip**: By default port `8080` is used. A custom port can be used via the `--port` option.

### Start a Production Server 📦

Start a production server which includes a `DockerFile` so that you can deploy anywhere:

Or you can try locally
```sh
# 📦 Start a Production Server
dart run bin/server.dart
```


<!-- Variables -->

[dart_installation_link]: https://dart.dev/get-dart
[ci_badge]: https://github.com/VeryGoodOpenSource/dart_frog/actions/workflows/main.yaml/badge.svg
[ci_link]: https://github.com/VeryGoodOpenSource/dart_frog/actions/workflows/main.yaml
[coverage_badge]: https://raw.githubusercontent.com/VeryGoodOpenSource/dart_frog/main/packages/dart_frog/coverage_badge.svg
[sarus_link_dark]: https://github.com/Prashant4900/sarus.git#gh-dark-mode-only
[sarus_link_light]: https://github.com/Prashant4900/sarus.git#gh-light-mode-only
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[logo_black]: https://raw.githubusercontent.com/Prashant4900/sarus/refs/heads/main/assets/logo-text-light.png#gh-dark-mode-only
[logo_white]: https://raw.githubusercontent.com/Prashant4900/sarus/refs/heads/main/assets/logo-text.png#gh-light-mode-only
[sarus_badge]: https://raw.githubusercontent.com/Prashant4900/sarus/f23b7c3071198e487ccd43b40a827734aa282331/assets/style-sarus.svg
[sarus_link]: https://fluttertemplate.com/
