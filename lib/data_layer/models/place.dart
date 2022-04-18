import 'package:covid_19_detector/data_layer/models/geometry.dart';

class Place {
  final Geometry? geometry;
  final String? name;

  Place({this.geometry, this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Geometry.fromJson(json['geometry']),
      name: json['formatted_address'],
    );
  }
}
