import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  GoogleMapController? googleMapController;

  static const CameraPosition initialCameraPosition = CameraPosition(target: LatLng(38.9573415, 35.240741), zoom: 14);

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GoogleMap(initialCameraPosition: initialCameraPosition,
        markers: markers,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          googleMapController = controller;
        },),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude , position.longitude),zoom: 14)));
          markers.clear();
          markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(position.latitude,position.longitude)));
          setState(() {
          });
        },
        label: Text("Mevcut Konum"),
        icon: Icon(Icons.location_history),

      ),
    );
  }

  Future<Position> _determinePosition() async{
    bool serviceEnable;
    LocationPermission permission;

    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error('Location services are disable!');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are  permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}