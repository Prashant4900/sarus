// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// Generator: ApplicationGen
// **************************************************************************

import "package:example/greeting/endpoints.dart";
import "package:sarus/sarus.dart";

RouterConfig get $router {
  final router = RouterConfig();

  router.mount('/', GreetingEndpoints().handler);

  return router;
}
