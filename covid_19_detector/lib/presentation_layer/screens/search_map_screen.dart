import 'package:covid_19_detector/business_logic_layer/api_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';

class SearchMapScreen extends StatefulWidget {
  final DetailsResult? startPosition;
  final DetailsResult? endPosition;

  const SearchMapScreen({Key? key, this.startPosition, this.endPosition}) : super(key: key);

  
  @override
  State<SearchMapScreen> createState() => _SearchMapScreenState();
}

class _SearchMapScreenState extends State<SearchMapScreen> {
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
  }

  @override
  void dispose() {
    super.dispose();
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
    Set<Marker> _markers = {
      Marker(
        markerId: MarkerId("Start"),
        position: LatLng(
          widget.startPosition!.geometry!.location!.lat!,
          widget.startPosition!.geometry!.location!.lng!,
        ),
      ),
      Marker(
        markerId: MarkerId("End"),
        position: LatLng(
          widget.endPosition!.geometry!.location!.lat!,
          widget.endPosition!.geometry!.location!.lng!,
        ),
      ),
    };
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