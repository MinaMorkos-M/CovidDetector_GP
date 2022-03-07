import 'dart:async';
import 'package:covid_19_detector/helpers/location_helper.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  bool showButton = false;
  static Position? position;
  Completer<GoogleMapController> _mapController = Completer();
  static CameraPosition _myCurrentlocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(position!.latitude, position!.longitude),
    tilt: 0.0,
    zoom: 15,
  );
  Marker? _destination;

  Future<void> getCurrentLocation() async {
    position = await LocationHelper.detectCurrentLocation().whenComplete(() {
      setState(() {});
    });
  }

  @override
  initState() {
    super.initState();
    getCurrentLocation();
  }

  Widget buildMap() {
    return GoogleMap(
      mapToolbarEnabled: false,
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      initialCameraPosition: _myCurrentlocationCameraPosition,

      //circles: circles,
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
      markers: {
        if (_destination != null) _destination!,
      },
      onLongPress: _addMarker,
    );
  }

  void _addMarker(LatLng pos) {
    setState(() {
      _destination = Marker(
        markerId: const MarkerId("Destination"),
        infoWindow: const InfoWindow(title: "Destination"),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: pos,
      );
    });
  }

  Widget floatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: floatingSearchBarController,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      leadingActions: [
        Container(
          margin: EdgeInsets.only(left: 10,right: 10),
          child: Icon(
            Icons.search,
            color: Colors.black.withOpacity(0.6),
          ),
        )
      ],
      hint: "Find a place..",
      border: BorderSide(
        style: BorderStyle.none,
      ),
      margins: EdgeInsets.fromLTRB(20, 20, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Theme.of(context).primaryColor,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: BouncingScrollPhysics(),
      axisAlignment: (isPortrait) ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: (isPortrait) ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        //TODO
      },
      onFocusChanged: (isFocused) {
        //TODO
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: Icon(
              Icons.place,
              color: Colors.black.withOpacity(0.6),
            ),
            onPressed: () {},
          ),
        )
      ],
      builder: (BuildContext context, Animation<double> transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [],
          ),
        );
      },
    );
  }

  Future<void> _goToMyCurrentLocation() async {
    final GoogleMapController controller = await _mapController.future;
    controller
        .animateCamera(
            CameraUpdate.newCameraPosition(_myCurrentlocationCameraPosition))
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
          floatingSearchBar(),
        ],
      ),
    );
  }
}
