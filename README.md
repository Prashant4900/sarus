[![Dart Frog Logo][logo_white]][sarus_link_dark]
[![Dart Frog Logo][logo_black]][sarus_link_light]

[![ci][ci_badge]][ci_link]
[![coverage][coverage_badge]][ci_link]
[![style: very good analysis][sarus_badge]][sarus_link]
[![License: MIT][license_badge]][license_link]
[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

Sarus — Minimalistic. Modular. The backend Dart has been waiting for.

Developed with 💙 by [Sarus][sarus_link] 🦄

## Documentation 📝

For official documentation, please visit https://dartfrog.vgv.dev.

## Packages 📦

| Package                                                                                                         | Pub                                                                                                                    |
| --------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| [sarus](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog)                       | [![pub package](https://img.shields.io/pub/v/dart_frog.svg)](https://pub.dev/packages/dart_frog)                       |
| [sarus_gen](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_gen)               | [![pub package](https://img.shields.io/pub/v/dart_frog_gen.svg)](https://pub.dev/packages/dart_frog_gen)               |
| [sarus_cli](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_cli)               | [![pub package](https://img.shields.io/pub/v/dart_frog_cli.svg)](https://pub.dev/packages/dart_frog_cli)               |
| [stormberry](https://github.com/verygoodopensource/dart_frog/tree/main/packages/dart_frog_web_socket) | [![pub package](https://img.shields.io/pub/v/dart_frog_web_socket.svg)](https://pub.dev/packages/dart_frog_web_socket) |


## Quick Start 🚀

### Prerequisites 📝

In order to use Dart Frog you must have the [Dart SDK][dart_installation_link] installed on your machine.

### Installing 🧑‍💻

```sh
# 📦 Install the sarus cli from pub.dev
dart pub global activate sarus_cli
```

### Creating a Project ✨

Use the `sarus create` command to create a new project.

```sh
# 🚀 Create a new project called "my_project"
sarus create my_project
```

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

### Create New Routes and Middleware 🛣️

To add new routes and middleware to your project, use the `dart_frog new` command.

```sh
# 🛣️ Create a new route "/hello/world"
dart_frog new route "/hello/world"

# 🛣️ Create a new middleware for the route "/hello/world"
dart_frog new middleware "/hello/world"
```

## Goals 🎯

Dart Frog is built on top of [shelf](https://pub.dev/packages/shelf) and [mason](https://pub.dev/packages/mason) and is inspired by many tools including [remix.run](https://remix.run), [next.js](https://nextjs.org), and [express.js](https://expressjs.com).

The goal of Dart Frog is to help developers effectively build backends in Dart. Currently, Dart Frog is focused on optimizing the process of building backends which aggregate, compose, and normalize data from multiple sources.

Dart Frog provides a simple core with a small API surface area in order to reduce the learning curve and ramp-up time for developers. In addition, Dart Frog is intended to help Flutter/Dart developers maximize their productivity by having a unified tech stack that enables sharing tooling, models, and more!



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