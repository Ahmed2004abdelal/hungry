import 'package:shared_preferences/shared_preferences.dart';

///
///
//* to get and save and remove the token
///
///

class PrefHelpers {
  static final String _tokenKey = "auth_token";

  /// to save token
  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
  }

  /// to get token
  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  /// to remove token
  static Future<void> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_tokenKey);
  }
}

