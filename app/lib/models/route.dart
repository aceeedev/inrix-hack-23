import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavRoute {
  final String name;
  final List<LatLng> latLongPairs;

  NavRoute({required this.name, required this.latLongPairs});
}
