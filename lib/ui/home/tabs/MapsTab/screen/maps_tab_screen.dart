import 'package:evently_app1/ui/home/tabs/MapsTab/provider/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapsTabScreen extends StatelessWidget {
  static const String routeName = "MapsTabScreen";
  const MapsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    return Scaffold(
      body : Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: provider.cameraPosition,
              onMapCreated: (controller) {
                provider.googleMapController = controller;
              },
              mapType:MapType.normal,
              markers: provider.markers,
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            provider.getLocation();
          },
          backgroundColor: Theme.of(context).primaryColor,

          child: const Icon(Icons.gps_fixed, color: Colors.white,size: 30,),

            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
