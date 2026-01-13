import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

class MapsTabProvider extends ChangeNotifier {
  Location location = Location();
  String locationMessage = "";

  MapsTabProvider(){
    getLocation();
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
      locationMessage = "Location Permission Denied";
      notifyListeners();
    }

    bool serviceEnabled = await _checkLocationService();
    if(!serviceEnabled){
      locationMessage = "Location Service Disabled";
      notifyListeners();
    }
    locationMessage = "Location Service Enabled and we are now getting your location";
    notifyListeners();

    LocationData locationData = await location.getLocation();
    locationMessage = "Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}";
    notifyListeners();

  }
}