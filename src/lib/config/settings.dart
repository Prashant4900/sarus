import 'package:stormberry/stormberry.dart';

class Settings {
  late Database db;

  void init() async {
    db = Database(
      host: "db.ohmseaieinffyejmgyen.supabase.co",
      password: "q5jDc3AYUn39SYth",
      username: "postgres",
      database: "postgres",
      port: 5432,
    );
  }

  Future<void> close() async {
    await db.close();
  }
}
