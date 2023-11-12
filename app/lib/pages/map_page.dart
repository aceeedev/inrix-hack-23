import 'package:app/pages/saved_tickets_page.dart';
import 'package:app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/pages/begin_page.dart';
import 'package:app/backend/flask_interface.dart';
import 'package:app/models/route.dart';

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
      body: FutureBuilder(
        future: getRoutes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                  child: Text('An error has occurred, ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List<NavRoute> routes = snapshot.data!;

              List<MaterialColor> lineColors = [
                Colors.blue,
                Colors.orange,
                Colors.red
              ];

              Set<Polyline> polyset = {};
              for (int loop = 0; loop <= 0; loop++) {
                polyset.add(Polyline(
                    polylineId: PolylineId(routes[loop].name),
                    points: routes[loop].latLongPairs,
                    color: lineColors[loop]));
              }

              // example
              // Polyline driveline = const Polyline(
              //   polylineId: PolylineId("driveline"),
              //   color: Colors.blue,
              //   points: [LatLng(37.7775, -122.416389)], // replace with temp points
              //   endCap: Cap.roundCap,
              // );

              return SlidingUpPanel(
                panel: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Route',
                        style: Styles().largeTextStyle,
                      ),
                    ),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                body: Stack(
                  children: [
                    GoogleMap(
                      onMapCreated: _onMapCreated,
                      cloudMapId: '40bae229feee19e5', // javascript vector
                      // cloudMapId: '5b05b9f927bfcf34',  // javascript raster
                      // cloudMapId: '701a336f83a1aaa6', // static raster
                      // cloudMapId: '74194f22342551fa',  // android
                      polylines: polyset,
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
                          style: const ButtonStyle(
                              splashFactory: NoSplash.splashFactory),
                          child: const Icon(Icons.arrow_back_ios_new),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
