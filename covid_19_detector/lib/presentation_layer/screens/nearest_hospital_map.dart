import 'dart:async';
import 'package:covid_19_detector/business_logic_layer/api_keys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:covid_19_detector/business_logic_layer/helpers/location_helper.dart';
import 'package:covid_19_detector/data_layer/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearestHospitalMap extends StatefulWidget {
  @override
  State<NearestHospitalMap> createState() => _NearestHospitalMapState();
}

class _NearestHospitalMapState extends State<NearestHospitalMap> {
  static Position? position;
  bool showButton = false;
  Set<Marker> markers = {};
  Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? subscription;
  static CameraPosition _myCurrentlocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 15,
  );
  Future<List<Place>> getPlaces(double lat, double lng) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=hospital&rankby=distance&key=${ApiKeys.googleMaps}';
    var response = await http.get(Uri.parse(url));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

  setMarkers(Future<List<Place>> places) async {
    List<Place> places =
        await getPlaces(position!.latitude, position!.longitude);
    if (places.length > 0) {
      Marker marker = Marker(
        markerId: MarkerId('hospital'),
        position: LatLng(
          places[0].geometry!.location!.lat!,
          places[0].geometry!.location!.lng!,
        ),
        flat: true,
        draggable: false,
        zIndex: 2,
      );
      markers.add(marker);
    }
    setState(() {});
  }

  getNearestHospital() {
    Future<List<Place>> places =
        getPlaces(position!.latitude, position!.longitude);
    setMarkers(places);
  }

  getCurrentLocation() async {
    try {
      position = await LocationHelper.getCurrentLocation().whenComplete(() {
        setState(() {});
      });

      if (subscription != null) {
        subscription!.cancel();
      }
    } on PlatformException catch (e) {
      print(e.message);
    }
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
  void initState() {
    super.initState();
    getCurrentLocation();
    getNearestHospital();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.place,
          color: Colors.white,
        ),
        onPressed: _goToMyCurrentLocation,
      ),
      appBar: AppBar(
        title: Text('Nearest Hospital'),
      ),
      body: SafeArea(
        child: (position != null)
            ? GoogleMap(
                markers: markers,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: _myCurrentlocationCameraPosition,
                onMapCreated: (GoogleMapController mapController) {
                  _mapController.complete(mapController);
                },
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
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
      ),
    );
  }
}
