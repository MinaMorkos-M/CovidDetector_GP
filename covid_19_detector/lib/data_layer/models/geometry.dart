import 'package:covid_19_detector/data_layer/models/location.dart';

class Geometry {
  final Location? location;

  Geometry({this.location});

  Geometry.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Location.fromJson(parsedJson['location']);
}
