// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

// ignore_for_file: type=lint

RouterConfig _$homeControllerRouterConfig(HomeController controller) {
  final routerConfig = RouterConfig();

  routerConfig.get('/', controller.hello);

  return routerConfig;
}

// ignore_for_file: type=lint

RouterConfig _$adminControllerRouterConfig(AdminController controller) {
  final routerConfig = RouterConfig();

  routerConfig.get('/admin', controller.hello);

  return routerConfig;
}
