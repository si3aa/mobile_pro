import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String isLoggedInKey = 'isLoggedIn';
  static Future<void> setLoginState(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<bool> getLoginState() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool(isLoggedInKey) ?? false;
  }
}
