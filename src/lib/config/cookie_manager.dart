import 'package:web/web.dart' as html;

class CookieManager {
  /// Set a cookie with optional expiration and path
  static void setCookie({
    required String name,
    required String value,
    int? maxAge,
    String path = '/',
    bool httpOnly = false,
    bool secure = false,
  }) {
    String cookieString = '$name=$value';

    if (maxAge != null) {
      cookieString += '; Max-Age=$maxAge';
    }

    cookieString += '; Path=$path';

    if (httpOnly) {
      cookieString += '; HttpOnly';
    }

    if (secure) {
      cookieString += '; Secure';
    }

    html.document.cookie = cookieString;
  }

  /// Get a cookie by name
  static String? getCookie(String name) {
    final cookies = html.document.cookie.split('; ');

    for (var cookie in cookies) {
      final parts = cookie.split('=');
      if (parts.first == name) {
        return parts.length > 1 ? parts[1] : '';
      }
    }
    return null;
  }

  /// Delete a cookie
  static void deleteCookie(String name, {String path = '/'}) {
    // Set max-age to 0 to delete the cookie
    setCookie(name: name, value: '', maxAge: 0, path: path);
  }

  /// Check if a cookie exists
  static bool hasCookie(String name) {
    return getCookie(name) != null;
  }

  /// Get all cookies as a map
  static Map<String, String> getAllCookies() {
    final cookieMap = <String, String>{};
    final cookies = html.document.cookie.split('; ');

    for (var cookie in cookies) {
      final parts = cookie.split('=');
      if (parts.length == 2) {
        cookieMap[parts[0]] = parts[1];
      }
    }

    return cookieMap;
  }
}
