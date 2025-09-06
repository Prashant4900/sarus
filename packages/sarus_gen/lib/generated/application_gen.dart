import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class ApplicationGen extends Generator {
  final _imports = <String>{};

  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) async {
    final routerCode = await _generateEndpointRouter(buildStep);

    final applications = _locateApplicationEntryPoint(library);

    if (applications.isEmpty) return null;

    // Build the generated output
    final output = StringBuffer()
      ..writeln('import "package:sarus/sarus.dart";')
      ..writeln();

    for (final import in _imports) {
      output.writeln('import "package:$import";');
    }

    output.writeln(r'RouterConfig get $router {');
    output.writeln('  final router = RouterConfig();');
    output.writeln();
    output.writeln(routerCode);
    output.writeln('  return router;');
    output.writeln('}');

    return output.toString();
  }

  // String _generateEndpointRouter(LibraryReader library) {
  //   final output = StringBuffer();

  //   final endpoints = _locateEndpoints(library);

  //   for (final endpoint in endpoints) {
  //     output.writeln("  router.mount('/', ${endpoint.name}().handler);");

  //     final libraryUri = endpoint.library.uri;
  //     _imports.add(libraryUri.path);
  //   }

  //   return output.toString();
  // }

  Future<String> _generateEndpointRouter(BuildStep buildStep) async {
    final output = StringBuffer();

    final inputAssets = await buildStep
        .findAssets(Glob('lib/**.dart'))
        .toList();

    for (final asset in inputAssets) {
      final library = await buildStep.resolver.libraryFor(asset);
      final reader = LibraryReader(library);

      final endpoints = reader.classes.where(
        (element) =>
            element.supertype != null &&
            element.supertype!.getDisplayString().startsWith('Endpoints'),
      );

      for (final endpoint in endpoints) {
        _imports.add(endpoint.library.uri.path);

        output.writeln("  router.mount('/', ${endpoint.name}().handler);");
      }
    }

    return output.toString();
  }

  Iterable<ClassElement> _locateApplicationEntryPoint(LibraryReader library) {
    return library.classes.where((element) {
      return element.allSupertypes.any(
        (supertype) => supertype.getDisplayString() == 'Application',
      );
    });
  }

  // Iterable<ClassElement> _locateEndpoints(LibraryReader library) {
  //   return library.classes.where((element) {
  //     return element.allSupertypes.any(
  //       (supertype) => supertype.getDisplayString() == 'Endpoints',
  //     );
  //   });
  // }
}
