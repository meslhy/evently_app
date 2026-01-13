import 'package:evently_app1/core/resources/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/ColorManager.dart';
import '../../../model/event/event_model.dart';
import '../../../providers/ThemeProvider.dart';

class EventDetailsScreen extends StatelessWidget {
  static const String routeName = "EventDetailsScreen";


  const EventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final EventModel eventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
    ThemeProvider provider= Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details', style: TextStyle(color:ColorManager.blue)),
        backgroundColor: Colors.transparent,
        actions: [
           if(eventModel.userId == FirebaseAuth.instance.currentUser!.uid)
             IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.pencil_outline, color: ColorManager.blue,)),
          if(eventModel.userId ==FirebaseAuth.instance.currentUser!.uid)
             IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.trash , color: Colors.red,)),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.22,
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image:provider.themeMode == ThemeMode.light ?
                  AssetImage(bgEventsLight[eventModel.type]??""):
                  AssetImage(bgEventsDark[eventModel.type]??""),
                  fit: BoxFit.cover,
                ),

              ),
            ),
            Text(eventModel.title??"" , style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize:25 ),),
            Container(
              width: double.infinity,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.lightBackground,
                border: Border.all(color: ColorManager.blue,width: 1),
              ),
              child: Row(
                children: [
                  Icon(CupertinoIcons.calendar_today , color: ColorManager.blue,size: 80,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat('dd MMM yyyy').format(eventModel.date!.toDate()),style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 18),),
                      Text(DateFormat('hh:mm a').format(eventModel.date!.toDate()),style: Theme.of(context).textTheme.bodyMedium,),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 16,),

          ],
        ),
      )

    );
  }
}
