import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../core/resources/Constants.dart';
import '../../../../../model/event/event_model.dart';
import '../../../../../providers/ThemeProvider.dart';

class EventCardInMap extends StatelessWidget {
  EventModel? eventModel;
  EventCardInMap({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.blue, width: 1),
        color: ColorManager.lightBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Image(image: AssetImage(
                provider.themeMode == ThemeMode.light ?
            bgEventsLight[eventModel?.type]??"":
            bgEventsDark[eventModel?.type]??"")
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(eventModel?.description??"",
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 14)
                    ),
                  flex: 70,
                ),
                Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: ColorManager.blue, size: 20,),
                        Expanded(
                            child: Text("location ${eventModel?.longitude??0}",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10 , color: ColorManager.black)
                        )),
                      ],
                    ),
                  flex: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
