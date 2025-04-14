// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controllers.dart';

// **************************************************************************
// RouteGenerator
// **************************************************************************

// ignore_for_file: type=lint

Router _$userControllerRouter(UserController controller) {
  final router = Router();

  router.get('/users/<name>', controller.sayHello);
  router.post('/users/', controller.createUser);

  return router;
}

Router _$profileControllerRouter(ProfileController controller) {
  final router = Router();

  router.get('/profiles/<username>', controller.getProfile);
  router.post('/profiles/', controller.createProfile);

  return router;
}
