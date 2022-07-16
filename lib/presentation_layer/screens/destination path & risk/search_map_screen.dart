import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_19_detector/business_logic_layer/api_keys.dart';
import 'package:covid_19_detector/data_layer/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'dart:math' show cos, sqrt, asin;

class SearchMapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const SearchMapScreen({Key? key, this.startPosition, this.endPosition})
      : super(key: key);

  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
  List<User> users = [];
  int numberOfUsers = 0;
  List<String> uids = [];
  Set<Marker> _markers = {};
  StreamSubscription? subscription;
  late CameraPosition _initialPosition;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  late Circle circle;
  @override
  initState() {
    super.initState();
    _initialPosition = CameraPosition(
      target: LatLng(
        widget.startPosition!.geometry!.location!.lat!,
        widget.startPosition!.geometry!.location!.lng!,
      ),
      zoom: 14.4746,
    );
    circle = Circle(
      circleId: CircleId("Destination Zone"),
      center: LatLng(
        widget.endPosition!.geometry!.location!.lat!,
        widget.endPosition!.geometry!.location!.lng!,
      ),
      radius: 1000,
      fillColor: Colors.red.withAlpha(60),
      strokeColor: Colors.red,
      strokeWidth: 1,
      zIndex: 1,
    );
    getUsersLongitudeAndLatitude();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getAllMarkers(List<User> users) {
    print("Users number:${users.length}");
    for (int i = 0; i < users.length; i++) {
      if (users[i].infected == true) {
        LatLng userPosition = LatLng(
          users[i].lat,
          users[i].lng,
        );
        if (calculateDistance(
              users[i].lat,
              users[i].lng,
              widget.endPosition!.geometry!.location!.lat!,
              widget.endPosition!.geometry!.location!.lng!,
            ) <
            1) {
          Marker marker = Marker(
            markerId: MarkerId("Infected"),
            position: userPosition,
            flat: true,
            draggable: false,
            zIndex: 2,
          );
          _markers.add(marker);
        }
      } else
        continue;
    }
    setState(() {});
  }

  void getUsersLongitudeAndLatitude() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc("uid")
        .get()
        .then((value) async {
      var result = value.data();

      numberOfUsers = result!['number'];
      for (int i = 0; i < numberOfUsers; i++) {
        uids.add(result['user${i + 1}']);
      }
      print(uids);
      for (int i = 0; i < uids.length; i++) {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(uids[i])
            .get()
            .then((value) {
          var result = value.data();
          users.add(User(
              lng: result!['longitude'],
              lat: result['latitude'],
              infected: result['infected'],
              state: "",
              country: "",
              city: " ",
              email: "",
              id: 0,
              phone: "",
              username: "",
              name: "",
              uid: "",
              password: ""));
        });
      }
    });
    getAllMarkers(users);
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.black,
      points: polylineCoordinates,
      width: 2,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      ApiKeys.googleMaps,
      PointLatLng(
        widget.startPosition!.geometry!.location!.lat!,
        widget.startPosition!.geometry!.location!.lng!,
      ),
      PointLatLng(
        widget.endPosition!.geometry!.location!.lat!,
        widget.endPosition!.geometry!.location!.lng!,
      ),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(
      Marker(
        markerId: MarkerId("Start"),
        position: LatLng(
          widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    _markers.add(
      Marker(
        markerId: MarkerId("End"),
        position: LatLng(
          widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );

    Set<Circle> circles = {
      circle,
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('Route'),
      ),
      body: GoogleMap(
        polylines: Set<Polyline>.of(polylines.values),
        initialCameraPosition: _initialPosition,
        markers: Set.from(_markers),
        circles: circles,
        onMapCreated: (GoogleMapController controller) {
          _getPolyline();
        },
      ),
    );
  }
}
