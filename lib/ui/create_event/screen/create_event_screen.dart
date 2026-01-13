import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/DilogUtils.dart';
import 'package:evently_app1/core/FirestoreHandler.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/core/reusable_componant/CustomButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomTextButton.dart';
import 'package:evently_app1/core/reusable_componant/CustomTextFF.dart';
import 'package:evently_app1/model/event/event_model.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:evently_app1/ui/create_event/provider/create_event_provider.dart';
import 'package:evently_app1/ui/create_event/screen/pick_location_screen.dart';
import 'package:evently_app1/ui/create_event/widgets/ChoseLocationButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/Constants.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "CreateEventScreen";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> with SingleTickerProviderStateMixin
{

  late TabController tabController;


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider= Provider.of<ThemeProvider>(context);
    CreateEventProvider createEventProvider = Provider.of<CreateEventProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title: Text("Create Event",style: Theme.of(context).textTheme.titleMedium,),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: TabBarView(
                    controller:tabController,
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
                  controller:tabController,
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
                                  color:tabController.index == 0 ?Colors.white : ColorManager.blue,
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
                                  color:tabController.index == 1 ?Colors.white : ColorManager.blue,
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
                                  color:tabController.index ==2 ?Colors.white : ColorManager.blue ,
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
                const SizedBox(height: 16,),
                CustomTextFormField(
                  hint: "",
                  label: 'Event Title',
                  prefixIcon:Icon(CupertinoIcons.text_justify),
                  controller: createEventProvider.titleController,
                  keyboardType: TextInputType.text,
                  validator: (value){},
                ),
                const SizedBox(height: 16,),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16,),
                CustomTextFormField(
                  label: "",
                  hint: 'Event Description',
                  controller:createEventProvider.descriptionController ,
                  keyboardType: TextInputType.multiline,
                  validator: (value){},
                ),
                const SizedBox(height: 16,),
                Row(
                  children: [
                    Icon(CupertinoIcons.calendar),
                    const SizedBox(width: 16,),
                    Text(
                      "Event Date",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    CustomTextButton(
                        onPressed: ()async{
                         var date =await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                              initialDate: createEventProvider.selectedDate,
                         );
                         if(date != null)
                           {
                             setState(() {
                               createEventProvider.selectedDate = date;
                             });
                           }
                        },
                        title: createEventProvider.selectedDate != null ?
                        DateFormat.yMd( context.locale.languageCode == 'ar' ? 'ar' : 'en').format(createEventProvider.selectedDate!):
                        "Select Date"
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(CupertinoIcons.time),
                    const SizedBox(width: 16,),
                    Text(
                      "Event Time",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    CustomTextButton(
                        onPressed: ()async{
                          var time = await showTimePicker(
                              context: context,
                              initialTime:TimeOfDay.now(),

                          );
                          if(time != null)
                            {
                              setState(() {
                                createEventProvider.selectedTime = time;
                              });
                            }
                        },
                        title: createEventProvider.selectedTime != null ?
                            "${createEventProvider.selectedTime!.hour}:${createEventProvider.selectedTime!.minute}" :
                        "Select Time"
                    )
                  ],
                ),
                const SizedBox(height: 16,),
                Text(
                  "Location",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 16,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, PickLocationScreen.routeName , arguments: createEventProvider);
                  },
                    child: ChoseLocationButton( createEventProvider: createEventProvider,),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                        title: "Create Event",
                        onTap: ()async{
                           createEventProvider.createEvent(context , tabController);
                        },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
