import 'package:stormberry/stormberry.dart';

part 'admin_model.schema.dart';

@Model(tableName: 'admins')
abstract class AdminModel {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get firstName;
  String get lastName;
  String get password;
  String get email;
  String get name;
  String get role;
  String get status;
  String get createdAt;
  String get updatedAt;
}
