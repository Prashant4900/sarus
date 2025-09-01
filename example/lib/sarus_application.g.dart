// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:sarus/sarus.dart';

import 'greeting/endpoints.dart';

/// Generated router configuration for [GreetingEndpoints].
/// This function creates and configures all routes defined in the endpoint class.
RouterConfig $greetingEndpointsRouterConfig(GreetingEndpoints endpoints) {
  final routerConfig = RouterConfig();

  routerConfig.get('/greeting', endpoints.index);

  return routerConfig;
}
