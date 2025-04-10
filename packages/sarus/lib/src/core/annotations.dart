/// Used to annotate a class as a database table
class Table {
  /// Creates a new Table annotation
  ///
  /// [tableName] specifies the name of the database table
  const Table({required this.tableName});

  /// The name of the table in the database
  final String tableName;
}

/// Used to annotate a field as a column in the database
class Column {
  /// Creates a new Column annotation
  ///
  /// [name] specifies the name of the column
  const Column({
    required this.name,
    this.isNullable = false,
    this.isAutoIncrement = false,
    this.isUnique = false,
    this.isPrimary = false,
    this.maxLength,
    this.autoNowAdd = false,
    this.autoNow = false,
    this.defaultValue,
  });

  /// The name of the column in the database
  ///
  /// [name] is required
  final String name;

  /// Whether the column can be null
  final bool isNullable;

  /// Whether the column is auto-incrementing
  ///
  /// [isAutoIncrement] is only valid for Integer columns
  final bool isAutoIncrement;

  /// Whether the column has a unique constraint
  ///
  /// [isUnique] is only valid for String columns
  final bool isUnique;

  /// Whether the column is the primary key of the table
  ///
  /// [isPrimary] is only valid for Integer columns
  final bool isPrimary;

  /// Maximum length of the column
  ///
  /// [maxLength] is only valid for String columns
  final int? maxLength;

  /// Whether the column should be auto-set on creation
  ///
  /// [autoNowAdd] is only valid for DateTime columns
  final bool autoNowAdd;

  /// Whether the column should be auto-set on update
  ///
  /// [autoNow] is only valid for DateTime columns
  final bool autoNow;

  /// Default value for the column
  ///
  /// [defaultValue] is not valid for DateTime columns
  final dynamic defaultValue;
}
