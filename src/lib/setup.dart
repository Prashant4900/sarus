import 'package:example/config/db.dart';
import 'package:example/users/services.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  try {
    final db = Database();

    getIt.registerSingleton<UserService>(UserService(await db.getConnection()));
  } catch (e) {
    print('Failed to setup dependencies injection: $e');
  }
}
