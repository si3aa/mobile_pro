import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String loginKey = 'isLoggedIn';

  static Future<bool> getLoginState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginKey) ?? false;
  }

  static Future<void> setLoginState(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginKey, value);
  }
}