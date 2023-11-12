import 'package:app/models/nav_route.dart';

class ParkingOption {
  final String startAddress;
  final String endAddress;
  final String timeText;
  final int time;
  final String fareText;
  final int fare;
  final List<NavRoute> navRoutes;

  ParkingOption(
      {required this.startAddress,
      required this.endAddress,
      required this.timeText,
      required this.time,
      required this.fareText,
      required this.fare,
      required this.navRoutes});
}
