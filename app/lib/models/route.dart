import 'package:google_maps_flutter/google_maps_flutter.dart';

class Route {
  final String name;
  final List<LatLng> latLongPairs;

  Route({required this.name, required this.latLongPairs});
}
