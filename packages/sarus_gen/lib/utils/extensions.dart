extension StringCamelCase on String {
  /// Converts a string to lowerCamelCase
  String toLowerCamelCase() {
    if (isEmpty) return '';

    // If the string is already PascalCase (no delimiters, starts uppercase)
    if (!contains(RegExp(r'[_\s-]')) && this[0].toUpperCase() == this[0]) {
      return this[0].toLowerCase() + substring(1);
    }

    final words = trim()
        .split(RegExp(r'[_\s-]+')) // split by space, underscore, hyphen
        .where((w) => w.isNotEmpty)
        .toList();

    if (words.isEmpty) return '';

    final firstWord = words.first.toLowerCase();
    final rest = words.skip(1).map((word) {
      final lower = word.toLowerCase();
      return lower[0].toUpperCase() + lower.substring(1);
    }).join();

    return firstWord + rest;
  }
}
