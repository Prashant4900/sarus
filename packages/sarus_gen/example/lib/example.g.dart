// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

Router _$userControllerRouter(UserController controller) {
  final router = Router();

  router.get('/users/<name>', controller.sayHello);
  router.post('/users/', controller.createUser);

  return router;
}
