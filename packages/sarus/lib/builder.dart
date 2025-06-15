import 'package:build/build.dart';
import 'package:sarus/generated/route_gen.dart';
import 'package:source_gen/source_gen.dart';

Builder routeBuilder(BuilderOptions options) => SharedPartBuilder(
      [RouteGenerator()],
      'routes',
    );
