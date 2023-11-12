import 'package:app/pages/saved_tickets_page.dart';
import 'package:app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/retry.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.title});

  final String title;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7775, -122.416389);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  var tempLinePoints = <LatLng>[];

  Polyline driveline = const Polyline(
    polylineId: PolylineId("driveline"),
    color: Colors.blue,
    points: <LatLng>[
      LatLng(37.791948, -122.409969),
      LatLng(37.797891, -122.406749),
      LatLng(37.805438, -122.415288)
    ], // replace with temp points
    endCap: Cap.roundCap,
  );
  Polyline transitline =
      const Polyline(polylineId: PolylineId("awqeF|h_jVv@dATXCDMN"));
  Polyline returnline = const Polyline(polylineId: PolylineId("returnline"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          onMapCreated: _onMapCreated,
          // cloudMapId: '40bae229feee19e5', // javascript vector
          // cloudMapId: '5b05b9f927bfcf34',  // javascript raster
          cloudMapId: '701a336f83a1aaa6', // static raster
          // cloudMapId: '74194f22342551fa',  // android
          polylines: <Polyline>{driveline, transitline, returnline},
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
          myLocationButtonEnabled: false,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(MaterialPageRoute(
                builder: (context) => const SavedTicketsPage(),
              )),
              style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
              child: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
        ),
      ],
    ));
  }
}
