import 'package:dart_frog/dart_frog.dart';
import 'package:src/admins/model.dart';
import 'package:src/config/config.dart';
import 'package:stormberry/stormberry.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Execute code before request is handled.
    //     .queryAdminModels(QueryParams(where: '"admins"."id" = 1'));
    final db = Config.db;

    // await db.adminModels.insertOne(
    //   AdminModelInsertRequest(
    //     firstName: "Prashant",
    //     lastName: "Nigam",
    //     password: "Nigam@123",
    //     email: "prashantnigam490@gmail.com",
    //     role: "super_admin",
    //     status: true,
    //     createdAt: DateTime.now().toIso8601String(),
    //     updatedAt: DateTime.now().toIso8601String(),
    //   ),
    // );

    final admins = await db.adminModels.queryAdminModels(QueryParams(limit: 1));
    if (admins.isEmpty) {
      // context.mountedParams['admin'] = 'Not found';
      print('Admin not found');
    } else {
      // context.mountedParams['admin'] = admins.first.email;
      print('Admin found: ${admins.first.email}');
    }

    // Forward the request to the respective handler.
    final response = await handler(context);

    // Execute code after request is handled.

    // Return a response.
    return response;
  };
}
