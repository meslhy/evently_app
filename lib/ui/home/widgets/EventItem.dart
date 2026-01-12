import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app1/core/resources/AppStyle.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/model/event/event_model.dart';
import 'package:evently_app1/providers/ThemeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/Constants.dart';

class EventItem extends StatelessWidget {

  EventModel eventModel;

   EventItem({
     super.key,
     required this.eventModel
   });

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider = Provider.of<ThemeProvider>(context);
    String type = eventModel.type!;

    return Container(
      margin: EdgeInsets.all(12),
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(
              provider.themeMode == ThemeMode.light ?
          bgEventsLight[type]??"":
              bgEventsDark[type]??""
          ),
          fit: BoxFit.fill,
        ),
          border: Border.all(
              color: ColorManager.blue,
              width: 1
          )
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width:54 ,
            height: 58,
            decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.lightBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorManager.blue,
                width: 1
              )

            ),
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    DateFormat.d(context.locale.languageCode == 'ar' ? 'ar' : 'en').format(eventModel.date!.toDate()),
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontSize: 18
                    )
                  ),
                ),
                Expanded(
                  child: Text(
                      DateFormat.MMM(context.locale.languageCode == 'ar' ? 'ar' : 'en').format(eventModel.date!.toDate()),
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontSize: 14
                    )
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.symmetric(horizontal: 8),
            width:double.infinity ,
            height: 58,
            decoration: BoxDecoration(
              color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground.withOpacity(0.95) : ColorManager.lightBackground.withOpacity(0.95),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 80,
                  child: Text(
                    eventModel.description??"",
                    style: TextStyle(
                      color: provider.themeMode == ThemeMode.dark ? ColorManager.white : ColorManager.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w700
                    )
                  ),
                ),
                Expanded(
                  child: Align(
                      child: Icon(CupertinoIcons.heart , color: ColorManager.blue, size: 25,),
                    alignment: AlignmentDirectional.centerEnd,
                  ),
                  flex: 20,
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
