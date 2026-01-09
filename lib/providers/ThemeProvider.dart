import 'package:flutter/material.dart';

import '../core/shared_preference/prefManager.dart';




class ThemeProvider extends ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;

  Future<void> init()  async{
     bool isDarkMode =await PrefManager.getThemeMode();
    themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;

}

void changeTheme(ThemeMode newTheme){
  themeMode = newTheme;
  notifyListeners();
}

}




