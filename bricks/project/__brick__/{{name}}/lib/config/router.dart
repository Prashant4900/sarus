import 'package:sarus/sarus.dart';
import 'package:{{name}}/greeting/endpoints.dart';

final router = Router(routes: [Route(endpoints: GreetingEndpoints())]);
