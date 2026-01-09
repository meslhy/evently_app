import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/AppStyle.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:evently_app1/ui/splash/screen/splash_screen.dart';
import 'package:evently_app1/ui/start/screen/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/shared_preference/prefManager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await PrefManager.init();
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
        SplashScreen.routeName: (_) => SplashScreen(),
        StartScreen.routeName: (_) => StartScreen()
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
