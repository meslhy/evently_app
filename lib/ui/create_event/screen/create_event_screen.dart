import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "CreateEventScreen";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider= Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Event",style: Theme.of(context).textTheme.titleMedium,),
        backgroundColor: Colors.transparent,
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.22,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      margin: EdgeInsets.symmetric(vertical: 16),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image:provider.themeMode == ThemeMode.light ?
                          AssetImage("assets/images/eventsBG/SportImage.png"):
                          AssetImage("assets/images/eventsBG/SportImageDark.png"),
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      margin: EdgeInsets.all(16),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: provider.themeMode == ThemeMode.light ?
                            AssetImage("assets/images/eventsBG/BirthdayImage.png"):
                          AssetImage("assets/images/eventsBG/BirthdayImageDark.png"),
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.22,
                      margin: EdgeInsets.all(16),
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: provider.themeMode == ThemeMode.dark?
                          AssetImage("assets/images/eventsBG/BookClubImageDark.png"):
                          AssetImage("assets/images/eventsBG/BookClubImage.png"),
                          fit: BoxFit.cover,
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                dividerHeight:0,
                indicator: BoxDecoration(
                  color: ColorManager.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                labelColor: ColorManager.white,
                unselectedLabelColor: ColorManager.blue,
                labelStyle: Theme.of(context).textTheme.titleMedium,
                unselectedLabelStyle: Theme.of(context).textTheme.titleMedium,
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: BouncingScrollPhysics(),
                onTap: (index){
                  print(provider.themeMode == ThemeMode.dark);
                },
                tabs:[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorManager.blue,width: 1)
                    ),
                    child: Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/SportIcon.svg" ,
                                color:_tabController.index == 0 ?Colors.white : ColorManager.blue,
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
                        border: Border.all(color: ColorManager.blue,width: 1)
                    ),
                    child: Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/BDIcon.svg" ,
                                color:_tabController.index == 1 ?Colors.white : ColorManager.blue,
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
                        border: Border.all(color: ColorManager.blue,width: 1)
                    ),
                    child: Tab(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/BookIcon.svg" ,
                                color:_tabController.index ==2 ?Colors.white : ColorManager.blue ,
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
              const SizedBox(height: 16,),
              Text(
                "Title",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
