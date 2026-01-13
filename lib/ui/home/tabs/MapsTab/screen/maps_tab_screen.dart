import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:evently_app1/ui/home/tabs/MapsTab/provider/maps_tab_provider.dart';
import 'package:evently_app1/ui/home/tabs/MapsTab/widgets/EventCardInMap.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../core/FirestoreHandler.dart';
import '../../../widgets/EventItem.dart';

class MapsTabScreen extends StatelessWidget {
  static const String routeName = "MapsTabScreen";
  const MapsTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MapsTabProvider provider = Provider.of<MapsTabProvider>(context);
    return Scaffold(
      body : Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
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
          StreamBuilder(
            stream: FirestoreHandler().getEventsStream(),
            builder: (context, snapshot) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.15,
                margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 8),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(width: 0,),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.length??0,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: InkWell(
                            onTap: (){
                              provider.changCameraPosition(
                                  LatLng(snapshot.data?[index].latitude??0,
                                      snapshot.data?[index].longitude??0),
                                  snapshot.data?[index].title??""
                              );
                            },
                            child: EventCardInMap(eventModel: snapshot.data?[index])
                        ),
                    );
                  },
                ),
              );
            }
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            provider.getLocation();
            provider.convertLatLog(provider.cameraPosition.target);
          },
          backgroundColor: Theme.of(context).primaryColor,

          child: const Icon(Icons.gps_fixed, color: Colors.white,size: 30,),

            ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
