import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../../../../core/prefManager.dart';
import '../../../../../core/resources/AssetsManager.dart';
import '../../../../../core/resources/StringManager.dart';
import '../../../../../core/reusable_componant/CustomSwitch.dart';
import '../../../../../providers/UserProvider.dart';
import '../../../../auth/login/screen/login_screen.dart';

class ProfileTabScreen extends StatefulWidget {
  static const String routeName = "ProfileTabScreen";

  ProfileTabScreen({super.key});

  @override
  State<ProfileTabScreen> createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {

  int selectedLanguage = 0 ;
  int selectedTheme = 0;
  late bool isAR ;


  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);
    isAR = context.locale.languageCode == 'ar' ? true : false ;


    return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding:EdgeInsets.symmetric(horizontal: 16),
              decoration:BoxDecoration(
                  color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
              ),
      
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userProvider.myUser?.name??"",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              userProvider.myUser?.email??"",
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(color:Colors.white ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(StringManager.language.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500
                        ),),
                        CustomSwitch(
                          item1: AssetsManager.us,
                          item2: AssetsManager.eg,
                          selected: selectedLanguage,
                          onChanged: (value) {
                            setState(() {
                              selectedLanguage = value;
                              if(value == 1)
                              {
                                context.setLocale(Locale('ar'));
                              }else{
                                context.setLocale(Locale('en'));
                              }
                
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(StringManager.theme.tr(),style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w500
                        ),),
                        CustomSwitch(item1: AssetsManager.sun,
                          item2: AssetsManager.moon,
                          isColored: true, selected: selectedTheme,
                          onChanged: (value) {
                            if(value == 0)
                            {
                              provider.changeTheme(ThemeMode.light);
                              PrefManager.saveThemeMode(false);
                            }else{
                              provider.changeTheme(ThemeMode.dark);
                              PrefManager.saveThemeMode(true);
                            }
                            setState(() {
                              selectedTheme = value;
                
                            });
                          },)
                      ],
                    ),
                    const SizedBox(height: 100,),
                    Container(
                      width: double.infinity,
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 16,),
                      child: CustomButton(
                          color: ColorManager.red,
                          title: "Logout",
                          onTap: (){
                            GoogleSignIn.instance.signOut();
                            FirebaseAuth.instance.signOut();
                            Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                          }
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        );
  }
}
