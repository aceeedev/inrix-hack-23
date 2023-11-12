import 'package:app/models/nav_route.dart';

class ParkingOption {
  final String parkingAddress;
  final String totalTimeText;
  final int totalTime;
  final String totalFareText;
  final int totalFare;
  final List<NavRoute> navRoutes;

  ParkingOption(
      {required this.parkingAddress,
      required this.totalTimeText,
      required this.totalTime,
      required this.totalFareText,
      required this.totalFare,
      required this.navRoutes});
}
