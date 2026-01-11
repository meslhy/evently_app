
import 'package:evently_app1/core/FirestoreHandler.dart';
import 'package:evently_app1/model/user/user_model.dart';
import 'package:evently_app1/providers/UserProvider.dart';
import 'package:evently_app1/ui/home/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/AssetsManager.dart';
import '../../../core/resources/ColorManager.dart';
import '../../start/screen/start_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    navigateToNext();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(AssetsManager.logo).animate()
            .scale(
          duration: Duration(seconds: 1)
        ).fade(
          duration: Duration(seconds: 1)
        ),
      )
    );
  }

  navigateToNext()async{
    if(FirebaseAuth.instance.currentUser == null){
      Future.delayed(Duration(seconds: 2),(){
        Navigator.pushReplacementNamed(context, StartScreen.routeName);
      });
    }else{
      UserModel? myUser = await FirestoreHandler().getUser(FirebaseAuth.instance.currentUser!.uid);
      UserProvider provider = Provider.of<UserProvider>(context , listen: false);
      provider.saveUser(myUser);
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);

    }
  }
}
