import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/ui/create_event/provider/create_event_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../providers/ThemeProvider.dart';

class PickLocationScreen extends StatelessWidget {
  static const String routeName = "PickLocationScreen";
  CreateEventProvider provider;
  PickLocationScreen({super.key , required this.provider});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider= Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                provider.googleMapController = controller;
              },
              mapType:MapType.normal,
              markers: provider.markers,
              onTap: (latLng){
                provider.changeLocation(latLng);
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: double.infinity,
            height:80,
            color: themeProvider.themeMode == ThemeMode.dark ? ColorManager.darkBackground : ColorManager.blue,
            padding: EdgeInsets.all(12),
            child:Center(child: Text("Tab on Location to select" , style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),)),
          ),
        ],
      ),
    );
  }
}
