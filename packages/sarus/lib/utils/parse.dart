// ============================================================================
// UTILITY FUNCTIONS
// ============================================================================

/// Parses a string value to a boolean with flexible input handling.
///
/// ## Supported Boolean Representations
///
/// **True values:**
/// - `'true'` (case insensitive)
/// - `'1'`
/// - `'yes'` (case insensitive)
/// - `'on'` (case insensitive)
///
/// **False values:**
/// - `'false'` (case insensitive)
/// - `'0'`
/// - `'no'` (case insensitive)
/// - `'off'` (case insensitive)
///
/// ## Return Value
/// - Returns `true` for true values
/// - Returns `false` for false values
/// - Returns `null` if the value cannot be parsed
///
/// ## Examples
/// ```dart
/// parseBool('true')  // true
/// parseBool('1')     // true
/// parseBool('yes')   // true
/// parseBool('false') // false
/// parseBool('0')     // false
/// parseBool('no')    // false
/// parseBool('maybe') // null
/// ```
bool? parseBool(String value) {
  final lower = value.toLowerCase();
  switch (lower) {
    case 'true':
    case '1':
    case 'yes':
    case 'on':
      return true;
    case 'false':
    case '0':
    case 'no':
    case 'off':
      return false;
    default:
      return null;
  }
}
