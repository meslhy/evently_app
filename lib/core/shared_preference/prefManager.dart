import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {

  static late SharedPreferences prefs;
  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);

  }
}