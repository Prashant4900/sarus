import 'package:stormberry/stormberry.dart';

part 'model.schema.dart';

@Model(tableName: '{{name}}')
abstract class {{name}}Model {
  @PrimaryKey()
  @AutoIncrement()
  int get id;

  String get createdAt;
  String get updatedAt;
}
