// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

// ignore_for_file: type=lint

RouterConfig _$userControllerRouterConfig(UserController controller) {
  final routerConfig = RouterConfig();

  routerConfig.post('/users/create', controller.createUser);
  routerConfig.delete('/users/<user-id>', controller.deleteUser);

  return routerConfig;
}
