import 'dart:async';
import 'dart:typed_data';
import 'dart:math' show cos, sqrt, asin;
import 'package:covid_19_detector/helpers/location_helper.dart';
import 'package:covid_19_detector/helpers/user_list.dart';
import 'package:covid_19_detector/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  StreamSubscription? subscription;
  bool showButton = false;
  static Set<Circle> circles = {};
  LocationData? liveLocation;
  static Position? position;
  static Set<Marker> allMarkers = {};
  Completer<GoogleMapController> _mapController = Completer();
  static CameraPosition _myCurrentlocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 15,
  );

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  /*Future<Uint8List> getMarker() async {
    ByteData byteData = await rootBundle.load("assets/images/virus.png");
    return byteData.buffer.asUint8List();
  }*/

  getCurrentLocation() async {
    try {
      //Uint8List imageData = await getMarker();
      position = await LocationHelper.detectCurrentLocation().whenComplete(() {
        setState(() {});
      });

      circles = Set.from(
        [
          Circle(
            circleId: CircleId("Me"),
            center: LatLng(position!.latitude, position!.longitude),
            radius: 200,
            strokeWidth: 1,
            fillColor: Colors.red.withAlpha(60),
            strokeColor: Colors.red,
            zIndex: 1,
          )
        ],
      );

      if (subscription != null) {
        subscription!.cancel();
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  getAllCirclesAndMarkers(List<User> users) async {
    for (int i = 0; i < users.length; i++) {
      LatLng userPosition = LatLng(
        users[i].lat,
        users[i].lng,
      );
      Marker marker = Marker(
        markerId: MarkerId("Me"),
        position: userPosition,
        flat: true,
        draggable: false,
        zIndex: 2,
      );
      allMarkers.add(marker);
    }
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
    getAllCirclesAndMarkers(Dummy.users);
  }

  Widget buildMap() {
    return GoogleMap(
      mapToolbarEnabled: false,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _myCurrentlocationCameraPosition,
      onCameraMove: (position) {
        if (_myCurrentlocationCameraPosition == position &&
            showButton == true) {
          setState(() {
            showButton = false;
          });
        } else if (_myCurrentlocationCameraPosition != position &&
            showButton == false) {
          setState(() {
            showButton = true;
          });
        }
      },
      onMapCreated: (GoogleMapController mapController) {
        _mapController.complete(mapController);
      },
      markers: allMarkers,
      circles: circles,
      onLongPress: _addMarker,
    );
  }

  void _addMarker(LatLng pos) {
    setState(() {
      Marker _destination = Marker(
        markerId: const MarkerId("Destination"),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        position: pos,
      );
    });
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(
      CameraUpdate.newCameraPosition(_myCurrentlocationCameraPosition),
    )
        .whenComplete(() {
      setState(() {
        showButton = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: (showButton)
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.place,
                color: Colors.white,
              ),
              onPressed: _goToMyCurrentLocation,
            )
          : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          (position != null)
              ? buildMap()
              : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
        ],
      ),
    );
  }
}
