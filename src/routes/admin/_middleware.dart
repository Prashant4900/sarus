import 'package:dart_frog/dart_frog.dart';
import 'package:src/admins/admin_model.dart';
import 'package:src/config/config.dart';
import 'package:stormberry/stormberry.dart';

Handler middleware(Handler handler) {
  return (context) async {
    // Execute code before request is handled.
    final db = Config.db;
    await db.adminModels.insertOne(AdminModelInsertRequest());
    // final admins = await db.adminModels
    //     .queryAdminModels(QueryParams(where: '"admins"."id" = 1'));

    // Forward the request to the respective handler.
    final response = await handler(context);

    // Execute code after request is handled.

    // Return a response.
    return response;
  };
}
