import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'ColorManager.dart';

class AppStyle {

  static ThemeMode themeMode = ThemeMode.light;

  static ThemeData lightTheme =  ThemeData(
    scaffoldBackgroundColor: ColorManager.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.blue,
      centerTitle:true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: ColorManager.black,
      tertiary: ColorManager.red,
      brightness: Brightness.light,
      onPrimary: Colors.white,
      onPrimaryContainer: Colors.grey,

    ),
    textTheme: TextTheme(
      bodySmall:  TextStyle(
          color: ColorManager.black,
          fontSize: 16,
          fontWeight: FontWeight.w500
      ),
      titleMedium: TextStyle(
          color: ColorManager.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      titleLarge:  TextStyle(
          color: ColorManager.white,
          fontSize: 24,
          fontWeight: FontWeight.w700
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorManager.blue,
      selectedItemColor: ColorManager.white,
      unselectedItemColor: Colors.grey,
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme =  ThemeData(
    scaffoldBackgroundColor: ColorManager.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      centerTitle:true,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: ColorManager.blue,
        fontSize: 22,
        fontWeight: FontWeight.w400,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: ColorManager.blue,
      secondary: ColorManager.white,
      tertiary: ColorManager.red,
        brightness: Brightness.dark,
      onPrimary: Colors.black,
      onPrimaryContainer: ColorManager.white,
    ),
    textTheme: TextTheme(
      bodySmall:  TextStyle(
          color: ColorManager.white,
          fontSize: 16,
          fontWeight: FontWeight.w500
      ),
      titleMedium: TextStyle(
          color: ColorManager.blue,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        labelMedium: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        )
    ),
    useMaterial3: true,
  );

}