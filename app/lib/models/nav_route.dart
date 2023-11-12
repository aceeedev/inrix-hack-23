import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavRoute {
  final String mode;
  final List<LatLng> latLongPairs;

  NavRoute({required this.mode, required this.latLongPairs});
}
