import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;

void changeTheme(ThemeMode newTheme){
  themeMode = newTheme;
  notifyListeners();
}

}




