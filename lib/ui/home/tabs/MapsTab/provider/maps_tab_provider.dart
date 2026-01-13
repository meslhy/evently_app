import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsTabProvider extends ChangeNotifier {
  Location location = Location();

  late GoogleMapController googleMapController;
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  Set<Marker> markers = {};

  // MapsTabProvider(){
  //   getLocation();
  //   selectLocationListener();
  // }


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

  void selectLocationListener() {
    location.onLocationChanged.listen((newLocation) {
      changeLocationOnMap(newLocation);
      notifyListeners();
    });

  }

  void changCameraPosition(LatLng latLng , String title){
    cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14.4746,
    );
    markers.add(Marker(
      markerId: MarkerId(UniqueKey().toString()),
      position: latLng,
      infoWindow: InfoWindow(
        title:title,
      ),
    ));


    googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();

  }

  String? country;
  String? city;
  Future<void> convertLatLog(LatLng latLng)async {

    List<geocoding.Placemark> placemarks = await geocoding.placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      country = placemarks[0].country??"Can't find Country";
      city = placemarks[0].locality?? "Can't find City";
      notifyListeners();
    } else {
      country = "Can't find Country";
      city = "Can't find City";
    }

    notifyListeners();
  }
}