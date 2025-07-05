// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'endpoints.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

/// Generated router configuration for [GreetingEndpoints].
/// This function creates and configures all routes defined in the endpoint class.
RouterConfig _$greetingEndpointsRouterConfig(GreetingEndpoints endpoints) {
  final routerConfig = RouterConfig();

  routerConfig.get('/greeting', (Request req) async {
    try {
      return endpoints.index(req);
    } catch (e) {
      if (e is ArgumentError) {
        return Response.badRequest(body: e.message);
      }
      if (e is FormatException) {
        return Response.badRequest(body: 'Invalid JSON format: ${e.message}');
      }
      rethrow;
    }
  });

  return routerConfig;
}
