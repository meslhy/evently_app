import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/ColorManager.dart';
import '../../../providers/ThemeProvider.dart';
import '../provider/create_event_provider.dart';

class ChoseLocationButton extends StatelessWidget {
  CreateEventProvider? createEventProvider;

  ChoseLocationButton({super.key ,required this.createEventProvider});

  @override
  Widget build(BuildContext context) {
    ThemeProvider provider= Provider.of<ThemeProvider>(context);
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: provider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.lightBackground,
          border: Border.all(color: ColorManager.blue,width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.gps_fixed , color: ColorManager.blue,size: 40,),
            const SizedBox(width: 16,),
             Text(
                createEventProvider!.eventLocation == null ?
                "Choose Event Location":
                "${createEventProvider?.city??""}, ${createEventProvider?.country??""}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 16),),
            const Spacer(),
            Icon(Icons.arrow_forward_ios , color: ColorManager.blue,size: 20,),
          ],
        ),
      );
  }
}
