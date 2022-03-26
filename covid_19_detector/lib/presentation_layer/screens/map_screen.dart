import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'package:covid_19_detector/business_logic_layer/helpers/location_helper.dart';
import 'package:covid_19_detector/business_logic_layer/user_list.dart';
import 'package:covid_19_detector/data_layer/models/user.dart';
import 'package:covid_19_detector/presentation_layer/screens/search_screen.dart';
import 'package:covid_19_detector/presentation_layer/widgets/map_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
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

  getCurrentLocation() async {
    try {
      position = await LocationHelper.getCurrentLocation().whenComplete(() {
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

  getAllMarkers(List<User> users) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].infected == true) {
        LatLng userPosition = LatLng(
          users[i].lat,
          users[i].lng,
        );
        if (true) {
          //TODO:if distance is less than 0.2 km
          Marker marker = Marker(
            markerId: MarkerId("Infected"),
            position: userPosition,
            flat: true,
            draggable: false,
            zIndex: 2,
          );
          allMarkers.add(marker);
        }
      } else
        continue;
    }
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
    getAllMarkers(Dummy.users);
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
    );
  }

  _refreshMyCircle() async {
    position = await LocationHelper.getCurrentLocation().whenComplete(() {
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
      bottomNavigationBar: MapBottomBar(),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: (showButton)
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: _refreshMyCircle,
            ),
            if (showButton)
              FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.place,
                  color: Colors.white,
                ),
                onPressed: _goToMyCurrentLocation,
              ),
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          (position != null)
              ? Stack(
                  children: [
                    LayoutBuilder(builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        child: buildMap(),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Card(
                          color: Colors.grey[200],
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            title: Text(
                              'Search a Place',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                )
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
