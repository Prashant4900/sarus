// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

// ignore_for_file: type=lint

RouterConfig _$userControllerRouter(UserController controller) {
  final router = RouterConfig();

  router.post('/users/create', controller.createUser);
  router.delete('/users/<user-id>', controller.deleteUser);

  return router;
}
