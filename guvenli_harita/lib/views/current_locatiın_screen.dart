import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class CurrentLocationScreen extends StatefulWidget {
  const CurrentLocationScreen({Key? key, required this.longitudevalues, required this.latitudevalues, required this.name}) : super(key: key);
  final double longitudevalues;
  final double latitudevalues;
  final String name;
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<CurrentLocationScreen> {

  double _longitudevalues = 0.0;
  double _latitudevalues = 0.0;
  String _name = "";

  @override
  void initState() {
    super.initState();
    _longitudevalues = widget.longitudevalues;
    _latitudevalues = widget.latitudevalues;
    _name = widget.name;
    _determinePosition();
  }

  GoogleMapController? googleMapController;
  Set<Marker> _markers = {};


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(_name),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(_latitudevalues, _longitudevalues), zoom: 16),
        markers: <Marker>{
          Marker(
              markerId: MarkerId('marker_id'),
              position: LatLng(_latitudevalues, _longitudevalues),
              infoWindow: InfoWindow(
                title: _name,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
        },
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          googleMapController = controller;
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () async {
          Position position = await _determinePosition();
          googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude , position.longitude),zoom: 14)));
          _markers.clear();
          _markers.add(Marker(markerId: MarkerId('currentLocation'), position: LatLng(position.latitude,position.longitude), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));
        },
        icon: Icon(Icons.location_on),
        label: Text("Mevcut Konum"),

      ),
    );
  }

  _determinePosition() async{
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