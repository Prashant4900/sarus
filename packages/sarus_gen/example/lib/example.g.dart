// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

RouterConfig _$userControllerRouter(UserController controller) {
  final router = RouterConfig();

  router.get('/users/<name>', controller.sayHello);
  router.post('/users/', controller.createUser);

  return router;
}
