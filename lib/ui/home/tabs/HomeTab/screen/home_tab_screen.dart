import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:evently_app1/providers/UserProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/prefManager.dart';
import '../../../../../core/resources/StringManager.dart';
import '../../../../start/screen/start_screen.dart';
import '../../../widgets/EventItem.dart';
import '../widgets/AllTab.dart';
import '../widgets/BirtdayTab.dart';
import '../widgets/BookClubTab.dart';
import '../widgets/SportTab.dart';


class HomeTabScreen extends StatefulWidget {
  static const String routeName = "HomeTabScreen";


   HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> with SingleTickerProviderStateMixin {
  late bool isAR ;
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {

    isAR = context.locale.languageCode == 'ar' ? true : false ;
    UserProvider provider = Provider.of<UserProvider>(context);
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                padding:EdgeInsets.symmetric(horizontal: 16),
                decoration:BoxDecoration(
                  color: themeProvider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.blue,
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
                                StringManager.welcomeBack.tr(),
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color:Colors.white ),
                              ),
                              Text(
                                provider.myUser?.name??"",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            themeProvider.changeTheme(
                                themeProvider.themeMode == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark);
                            themeProvider.themeMode == ThemeMode.dark
                                ?PrefManager.saveThemeMode(true): PrefManager.saveThemeMode(false);
                          },
                              icon: Icon(
                            themeProvider.themeMode == ThemeMode.dark ? CupertinoIcons.moon:CupertinoIcons.sun_max,
                            color: Colors.white,),
                        ),
                        GestureDetector(
                          onTap: () {
                            isAR != isAR;
                            context.setLocale(Locale(isAR ? 'en' : 'ar'));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                               isAR ? "Ar" : "En",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.tab,
                        isScrollable: true,
                        dividerHeight:0,
                        indicator: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        labelColor: ColorManager.blue,
                        unselectedLabelColor: Colors.white,
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        physics: BouncingScrollPhysics(),
                        onTap: (index){},
                        tabs:[
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 1)
                            ),
                            child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/VectorIcon.svg" ,
                                        color: _tabController.index ==0? ColorManager.blue: Colors.white,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                          "All"
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 1)
                            ),
                            child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/SportIcon.svg" ,
                                        color:_tabController.index == 1 ? ColorManager.blue: Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                          "Sport"
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 1)
                            ),
                            child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/BDIcon.svg" ,
                                        color:_tabController.index == 2 ? ColorManager.blue:Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                          "Birthday"
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration:  BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white,width: 1)
                            ),
                            child: Tab(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("assets/images/BookIcon.svg" ,
                                        color:_tabController.index == 3 ? ColorManager.blue: Colors.white,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                          "Book Club"
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                        ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: _tabController,
                    children:[
                      AllTab(),
                      SportTab(),
                      BirthdayTab(),
                      Bookclubtab(),

                    ] ,
                ),
              ),
            ],
          ),
      ),
    );
  }
}


