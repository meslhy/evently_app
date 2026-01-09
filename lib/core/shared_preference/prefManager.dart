import 'package:flutter/material.dart' show ThemeMode;
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {

  static late SharedPreferences prefs;
  static init()  async {
    prefs = await SharedPreferences.getInstance();
  }

  static  saveThemeMode(bool isDarkMode) async {
    return prefs.setBool('isDarkMode', isDarkMode);
  }

  static getThemeMode() async {
    return prefs.getBool('isDarkMode') ?? false;
  }
}