import 'package:app/pages/saved_tickets_page.dart';
import 'package:app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/pages/begin_page.dart';

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

  Polyline driveline = const Polyline(
    polylineId: PolylineId("driveline"),
    color: Colors.blue,
    points: <LatLng>[
      LatLng(37.7792079, -122.3900709),
      LatLng(37.77806169999999, -122.3915693),
      LatLng(37.78166050000001, -122.3961541),
      LatLng(37.7993974, -122.4087114),
      LatLng(37.79948880000001, -122.4087865),
      LatLng(37.7997396, -122.4066119),
      LatLng(37.80161289999999, -122.4069633),
      LatLng(37.80185669999999, -122.4056576),
      LatLng(37.8020986, -122.4059576),
      LatLng(37.8021366, -122.4058373),
      LatLng(37.8022515, -122.405858),
      LatLng(37.8022916, -122.4056988)
    ], // replace with temp points
    endCap: Cap.roundCap,
  );
  // Polyline transitline =
  //     const Polyline(polylineId: PolylineId("awqeF|h_jVv@dATXCDMN"));
  // Polyline returnline = const Polyline(polylineId: PolylineId("returnline"));
  var parkSpots = <Marker>{
    const Marker(
      markerId: MarkerId('spot1'),
      position: LatLng(37.797891, -122.406749),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlidingUpPanel(
      panel: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Route',
              style: Styles().largeTextStyle,
            ),
          ),
          ..._getRouteDirections(),
        ],
      ),
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            // cloudMapId: '40bae229feee19e5', // javascript vector
            // cloudMapId: '5b05b9f927bfcf34',  // javascript raster
            cloudMapId: '701a336f83a1aaa6', // static raster
            // cloudMapId: '74194f22342551fa',  // android
            polylines: <Polyline>{driveline},
            markers: parkSpots,
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
                onPressed: () => Navigator.of(context).pop(),
                style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                child: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  List<Widget> _getRouteDirections() {
    return [];
  }
}
