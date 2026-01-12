import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/core/resources/StringManager.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:evently_app1/providers/UserProvider.dart';
import 'package:evently_app1/ui/create_event/screen/create_event_screen.dart';
import 'package:evently_app1/ui/home/tabs/HomeTab/screen/home_tab_screen.dart';
import 'package:evently_app1/ui/home/tabs/MapsTab/screen/maps_tab_screen.dart';
import 'package:evently_app1/ui/start/screen/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../tabs/LoveTab/screen/love_tab_screen.dart';
import '../tabs/ProfileTab/screen/profile_tab_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int isSelected = 0;
  List<Widget> screens =
  [
    HomeTabScreen(),
    MapsTabScreen(),
    LoveTabScreen(),
    ProfileTabScreen(),
  ];


  @override

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: themeProvider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.blue,
          statusBarIconBrightness: themeProvider.themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,


        ),
      ),
      body:screens[isSelected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: isSelected,
        onTap: (index){
          setState(() {
            isSelected = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor:Colors.white ,
        unselectedItemColor: ColorManager.white,
        selectedIconTheme: IconThemeData(size:35),
        unselectedIconTheme: IconThemeData(size:20),
        showSelectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.location_solid),
            label: "Maps",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: "Love",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, CreateEventScreen.routeName);
        },
        backgroundColor:themeProvider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.blue,
        shape:RoundedRectangleBorder(
          side: BorderSide(width: 3, color: Colors.white),
        borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add , color: ColorManager.white,size: 35,),


      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,


    );
  }
}
