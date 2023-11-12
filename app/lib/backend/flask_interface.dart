import 'dart:convert';
import 'package:app/models/parking_option.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:app/backend/geo_location_helper.dart';
import 'package:app/models/event.dart';
import 'package:app/models/nav_route.dart';

String apiUrl = 'http://172.31.151.109:5000';

Future<List<Event>> findEvents() async {
  String endpoint = '/tickets';
  var response = await http.Client().get(Uri.parse('$apiUrl$endpoint'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);

    List<Event> events = json
        .map((e) => Event(
              name: e['name'],
              address: e['location'],
              date: DateTime.parse(e['eventDate']),
              url: e['eventURL'],
              imageUrl: e['imagelist'],
              latitude: double.parse(e['lat']),
              longitude: double.parse(e['long']),
            ))
        .toList();

    return events;
  } else {
    throw Exception('Error, code ${response.statusCode}');
  }
}

/// Returns a [List] of parking options where each option is a [List] of the
/// [NavRoute] for that option
Future<List<ParkingOption>> getRoutes(
    double eventLat, double eventLong, int parkingRadius) async {
  // get user's position
  Position userPosition = await getUserPosition();
  double userLat = userPosition.latitude;
  double userLong = userPosition.longitude;

  String endpoint = '/parking-options';
  var response = await http.Client().get(Uri.parse(
      '$apiUrl$endpoint?latDest=$eventLat&longDest=$eventLong&latSource=$userLat&longSource=$userLong&radius=$parkingRadius'));

  if (response.statusCode == 200) {
    List<dynamic> json = jsonDecode(response.body);
    List<ParkingOption> parkingOptions = [];

    for (Map<String, dynamic> option in json[0]) {
      List<NavRoute> navRoutes = [];
      List<LatLng> latLongPairs = [];

      // to parking
      for (List<dynamic> pathPair in option['routeToParking']['steps']
          ['path']) {
        latLongPairs.add(LatLng(pathPair[0], pathPair[1]));
      }
      navRoutes.add(NavRoute(
          mode: option['routeToParking']['steps']['mode'],
          latLongPairs: latLongPairs));

      // to event
      for (Map<String, dynamic> step in option['routeToEvent']['steps']) {
        for (List<dynamic> pathPair in step['path']) {
          latLongPairs.add(LatLng(pathPair[0], pathPair[1]));
        }

        navRoutes.add(NavRoute(mode: step['mode'], latLongPairs: latLongPairs));
      }

      parkingOptions.add(ParkingOption(
          parkingAddress: option['routeToParking']['end'],
          totalTimeText: option['totalTimeText'],
          totalTime: option['totalTime'],
          totalFareText: option['totalFareText'] ?? ' free',
          totalFare: option['totalFare'] ?? 0,
          navRoutes: navRoutes));
    }

    return parkingOptions;
  } else {
    throw Exception('Error, code ${response.statusCode}');
  }
}
