import 'dart:convert';

import 'package:sarus/sarus.dart';

part 'controllers.g.dart';

@Controller('/{{name.paramCase()}}')
class {{name.pascalCase()}}Controller extends BaseController {
  {{name.pascalCase()}}Controller() : super();

  @Get('')
  Future<Response> index(Request request) async {
    return Response.ok(jsonEncode({'message': 'Hello from {{name.pascalCase()}}Controller'}));
  }

  @override
  RouterConfig get router => _${{name.camelCase()}}ControllerRouterConfig(this);
}
