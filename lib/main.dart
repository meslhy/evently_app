import 'package:evently_app1/core/resources/AppStyle.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/ui/splash/screen/splash_screen.dart';
import 'package:evently_app1/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      darkTheme:AppStyle.darkTheme,
      themeMode: AppStyle.themeMode,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen()
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
