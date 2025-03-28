// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, implicit_dynamic_list_literal

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


import '../routes/index.dart' as index;
import '../routes/about.dart' as about;
import '../routes/admin/profile.dart' as admin_profile;
import '../routes/admin/index.dart' as admin_index;
import '../routes/admin/auth/register.dart' as admin_auth_register;
import '../routes/admin/auth/login.dart' as admin_auth_login;
import '../routes/admin/auth/forgot.dart' as admin_auth_forgot;

import '../routes/_middleware.dart' as middleware;
import '../routes/admin/_middleware.dart' as admin_middleware;

void main() async {
  final address = InternetAddress.tryParse('') ?? InternetAddress.anyIPv6;
  final port = int.tryParse(Platform.environment['PORT'] ?? '8080') ?? 8080;
  hotReload(() => createServer(address, port));
}

Future<HttpServer> createServer(InternetAddress address, int port) {
  final handler = Cascade().add(buildRootHandler()).handler;
  return serve(handler, address, port);
}

Handler buildRootHandler() {
  final pipeline = const Pipeline().addMiddleware(middleware.middleware);
  final router = Router()
    ..mount('/admin/auth', (context) => buildAdminAuthHandler()(context))
    ..mount('/admin', (context) => buildAdminHandler()(context))
    ..mount('/', (context) => buildHandler()(context));
  return pipeline.addHandler(router);
}

Handler buildAdminAuthHandler() {
  final pipeline = const Pipeline().addMiddleware(admin_middleware.middleware);
  final router = Router()
    ..all('/register', (context) => admin_auth_register.onRequest(context,))..all('/login', (context) => admin_auth_login.onRequest(context,))..all('/forgot', (context) => admin_auth_forgot.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildAdminHandler() {
  final pipeline = const Pipeline().addMiddleware(admin_middleware.middleware);
  final router = Router()
    ..all('/profile', (context) => admin_profile.onRequest(context,))..all('/', (context) => admin_index.onRequest(context,));
  return pipeline.addHandler(router);
}

Handler buildHandler() {
  final pipeline = const Pipeline();
  final router = Router()
    ..all('/', (context) => index.onRequest(context,))..all('/about', (context) => about.onRequest(context,));
  return pipeline.addHandler(router);
}

