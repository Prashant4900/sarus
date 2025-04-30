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
