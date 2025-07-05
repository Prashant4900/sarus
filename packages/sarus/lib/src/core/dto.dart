/// A marker annotation that indicates a class should have JSON serialization
/// methods generated automatically.
///
/// When applied to a class, this annotation triggers the DTOGenerator to
/// create `fromJson` and `toJson` methods for automatic JSON serialization
/// and deserialization.
///
/// ## Usage:
/// ```dart
/// @DTO()
/// class User {
///   final String name;
///   final int age;
///   final String? email;
///
///   User({required this.name, required this.age, this.email});
/// }
/// ```
///
/// This will generate:
/// ```dart
/// User _$UserFromJson(Map<String, dynamic> json) {
///   return User(
///     name: json['name'] as String,
///     age: json['age'] as int,
///     email: json['email'] as String?,
///   );
/// }
///
/// Map<String, dynamic> _$UserToJson(User instance) {
///   final val = <String, dynamic>{};
///   val['name'] = instance.name;
///   val['age'] = instance.age;
///   val['email'] = instance.email;
///   return val;
/// }
/// ```
///
/// ## Requirements:
/// - Can only be applied to classes
/// - The class must have a constructor that accepts all fields as parameters
/// - All fields should be accessible (public or have getters)
///
/// ## Supported Types:
/// - Primitive types: `String`, `int`, `double`, `bool`
/// - Nullable versions of primitive types
/// - `List<T>` where T is a supported type
/// - Custom objects (with basic casting)
///
/// ## See Also:
/// - [JsonKey] for customizing individual field serialization
class DTO {
  /// Creates a new DTO annotation.
  ///
  /// This is a const constructor that creates a marker annotation
  /// with no additional configuration options.
  const DTO();
}

/// An annotation for customizing how individual fields are serialized
/// to and from JSON.
///
/// This annotation can be applied to class fields to control their
/// JSON serialization behavior, including custom field names and
/// null value handling.
///
/// ## Usage:
/// ```dart
/// @DTO()
/// class User {
///   final String name;
///
///   @JsonKey(name: 'user_id')
///   final int id;
///
///   @JsonKey(name: 'email_address', includeIfNull: true)
///   final String? email;
///
///   @JsonKey(includeIfNull: false)
///   final String? nickname;
///
///   User({required this.name, required this.id, this.email, this.nickname});
/// }
/// ```
///
/// This will generate JSON serialization that:
/// - Maps the `id` field to `user_id` in JSON
/// - Maps the `email` field to `email_address` in JSON
/// - Includes the `email` field even when null
/// - Excludes the `nickname` field when null
///
/// ## Examples:
///
/// ### Custom Field Names:
/// ```dart
/// @JsonKey(name: 'created_at')
/// final DateTime createdAt;
/// ```
/// Maps `createdAt` property to `created_at` in JSON.
///
/// ### Null Handling:
/// ```dart
/// @JsonKey(includeIfNull: false)
/// final String? optionalField;
/// ```
/// Excludes the field from JSON when its value is null.
///
/// ### Combined Usage:
/// ```dart
/// @JsonKey(name: 'phone_number', includeIfNull: false)
/// final String? phoneNumber;
/// ```
/// Uses custom field name and excludes when null.
class JsonKey {
  /// Creates a new JsonKey annotation with optional customization.
  ///
  /// [name] The custom field name to use in JSON serialization.
  /// If not provided, the original field name will be used.
  ///
  /// [includeIfNull] Whether to include this field in JSON output
  /// when its value is null. Defaults to `false`, meaning null
  /// values will be excluded from the JSON output.
  ///
  /// ## Examples:
  /// ```dart
  /// // Use custom field name
  /// @JsonKey(name: 'user_id')
  /// final int id;
  ///
  /// // Exclude when null
  /// @JsonKey(includeIfNull: false)
  /// final String? nickname;
  ///
  /// // Include when null (explicit)
  /// @JsonKey(includeIfNull: true)
  /// final String? email;
  ///
  /// // Custom name and exclude when null
  /// @JsonKey(name: 'phone_number', includeIfNull: false)
  /// final String? phoneNumber;
  /// ```
  const JsonKey({
    this.name,
    this.includeIfNull = false,
  });

  /// The custom field name to use in JSON serialization.
  ///
  /// When this is provided, the JSON key will use this name instead
  /// of the original field name. This is useful for adapting to
  /// different naming conventions (e.g., snake_case in JSON vs
  /// camelCase in Dart).
  ///
  /// If `null`, the original field name will be used.
  ///
  /// ## Examples:
  /// ```dart
  /// @JsonKey(name: 'first_name')
  /// final String firstName; // JSON: {"first_name": "John"}
  ///
  /// @JsonKey(name: 'created_at')
  /// final DateTime createdAt; // JSON: {"created_at": "2023-01-01T00:00:00Z"}
  /// ```
  final String? name;

  /// Whether to include this field in JSON output when its value is null.
  ///
  /// When `false` (default), null values will be excluded from the
  /// generated JSON. When `true`, null values will be explicitly
  /// included in the JSON output.
  ///
  /// ## Default Behavior:
  /// By default, this is set to `false` to reduce JSON payload size
  /// and avoid unnecessary null values in the output.
  ///
  /// ## Examples:
  /// ```dart
  /// @JsonKey(includeIfNull: false)
  /// final String? nickname;
  /// // When nickname is null: field is excluded from JSON
  /// // When nickname is "Bob": {"nickname": "Bob"}
  ///
  /// @JsonKey(includeIfNull: true)
  /// final String? email;
  /// // When email is null: {"email": null}
  /// // When email is "user@example.com": {"email": "user@example.com"}
  /// ```
  ///
  /// ## Use Cases:
  /// - Set to `false` for optional fields that don't need to appear in JSON
  /// - Set to `true` when the API expects explicit null values
  /// - Set to `true` for fields that must always be present in JSON schema
  final bool includeIfNull;
}
