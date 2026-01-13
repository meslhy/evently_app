import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../core/DilogUtils.dart';
import '../../../core/FirestoreHandler.dart';
import '../../../core/resources/Constants.dart';
import '../../../model/event/event_model.dart';

class CreateEventProvider extends ChangeNotifier{


  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  Location location = Location();
  LatLng? eventLocation;


  late GoogleMapController googleMapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};

   CreateEventProvider(){
    getLocation();
    //selectLocationListener();
  }


  Future<bool> _getLocationPermission()async{
    PermissionStatus permissionStatus;

    permissionStatus = await location.hasPermission();

    if(permissionStatus == PermissionStatus.denied){

      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;

  }

  Future<bool> _checkLocationService()async{
    bool serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  Future<void> getLocation()async {
    bool permissionGranted = await _getLocationPermission();
    if(!permissionGranted){
      notifyListeners();
    }

    bool serviceEnabled = await _checkLocationService();
    if(!serviceEnabled){
      notifyListeners();
    }
    notifyListeners();

    LocationData locationData = await location.getLocation();

    changeLocationOnMap(locationData);

    notifyListeners();

  }

  void changeLocationOnMap(LocationData locationData){
    cameraPosition =  CameraPosition(
      target: LatLng(locationData.latitude??0,locationData.longitude?? 0),
      zoom: 14.4746,
    );

    markers.add(Marker(
      markerId: MarkerId("1"),
      position: LatLng(locationData.latitude??37.42796133580664,locationData.longitude?? -122.085749655962),
      infoWindow: InfoWindow(
        title: "Current Location",
      ),
    ));

    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();

  }

  void changeLocation(LatLng latLng){
     eventLocation = latLng;
     markers.add(
       Marker(
         markerId: MarkerId("2"),
         position: latLng,
         infoWindow: InfoWindow(
           title: "Event Location",
         ),
       )
     );

    notifyListeners();
  }

  void createEvent(context , tabController)async{
    if(selectedDate == null) {
      dilogUtils().showToast("Chose Event Date");
    }else if(selectedTime == null){
      dilogUtils().showToast("Chose Event Time");
    }
    else {
      DateTime eventDate = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );
      dilogUtils().showLoadingDialog(context);
      try {
        await FirestoreHandler().addEvent(EventModel(
          title: titleController.text,
          description: descriptionController.text,
          type: eventType[tabController.index],
          date: Timestamp.fromDate(eventDate),
          latitude:eventLocation!.latitude,
          longitude:eventLocation!.longitude,
          favoriteUsersId: [],
          userId: FirebaseAuth.instance.currentUser!.uid,
        ));
        Navigator.pop(context);
        dilogUtils().showToast(
            "Event Created Successfully");
      }catch(e){
        Navigator.pop(context);
        dilogUtils().showToast(e.toString());

      }
    }
  }


  }