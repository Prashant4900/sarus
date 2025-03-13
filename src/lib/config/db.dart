// import 'package:stormberry/stormberry.dart';

// import 'env.dart';

// class DB {
//   late Database db;

//   void init() async {
//     db = Database(
//       host: Env.get(EnvKey.DB_HOST),
//       password: Env.get(EnvKey.DB_PASSWORD),
//       username: Env.get(EnvKey.DB_USER),
//       database: Env.get(EnvKey.DB_NAME),
//       port: int.parse(Env.get(EnvKey.DB_HOST) ?? '5432'),
//     );
//   }

//   Future<void> close() async {
//     await db.close();
//   }
// }
