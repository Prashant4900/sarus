import 'dart:convert';
import 'dart:io';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller()
class HomeController extends BaseController {
  @Get('/')
  Future<Response> hello(Request request) async {
    final indexPage = File('public/index.html').readAsStringSync();
    return Response.ok(indexPage, headers: {'Content-Type': 'text/html'});
  }

  @override
  RouterConfig get router => _$homeControllerRouterConfig(this);
}

@Controller('/admin')
class AdminController extends BaseController {
  @Get('/')
  Future<Response> hello(Request request) async {
    return Response.ok(jsonEncode("{'message': 'Hello from AdminController'}"));
  }

  @override
  RouterConfig get router => _$adminControllerRouterConfig(this);
}
