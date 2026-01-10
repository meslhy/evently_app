import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/AppStyle.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:evently_app1/ui/auth/forgetPass/screen/forget_pass_screen.dart';
import 'package:evently_app1/ui/auth/login/screen/login_screen.dart';
import 'package:evently_app1/ui/auth/register/screen/register_screen.dart';
import 'package:evently_app1/ui/splash/screen/splash_screen.dart';
import 'package:evently_app1/ui/start/screen/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/shared_preference/prefManager.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefManager.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      EasyLocalization(
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
      ],
          path: "assets/translations",
          fallbackLocale: Locale('en'),
      child: ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider()..init(),
          child: MyApp()
      )
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppStyle.lightTheme,
      darkTheme:AppStyle.darkTheme,
      themeMode: provider.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        StartScreen.routeName: (context) => StartScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        ForgetPassScreen.routeName: (context) => ForgetPassScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
