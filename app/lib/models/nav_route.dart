import 'package:google_maps_flutter/google_maps_flutter.dart';

class NavRoute {
  /// modes can be: WALKING, TRANSIT
  final String mode;
  final List<LatLng> latLongPairs;

  NavRoute({required this.mode, required this.latLongPairs});
}
