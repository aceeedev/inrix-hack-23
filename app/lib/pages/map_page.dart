import 'package:app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/backend/flask_interface.dart';
import 'package:app/models/event.dart';
import 'package:app/models/parking_option.dart';
import 'package:app/models/nav_route.dart';
import 'dart:ui';

class MapPage extends StatefulWidget {
  const MapPage({super.key, required this.event, required this.parkingRadius});
  final Event event;
  final int parkingRadius;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(37.7775, -122.416389);

  late List<ParkingOption> parkingOptions = [
    ParkingOption(
        startAddress: 'startAddress',
        endAddress: 'endAddress',
        timeText: 'timeText',
        time: 1,
        fareText: 'fareText',
        fare: 1,
        navRoutes: [
          NavRoute(mode: 'TRANSIT', latLongPairs: const [
            LatLng(37.7775, -122.416389),
            LatLng(37.7775, -122.416389)
          ])
        ])
  ];
  // late LatLng startPos = const LatLng(37.7775, -122.416389);
  late int parkingOptionIndex = 0;

  late BitmapDescriptor startIcon = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor endIcon = BitmapDescriptor.defaultMarker;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Polyline transitline =
  //     const Polyline(polylineId: PolylineId("awqeF|h_jVv@dATXCDMN"));
  // Polyline returnline = const Polyline(polylineId: PolylineId("returnline"));
  // var parkSpots = <Marker>{
  //   const Marker(
  //     markerId: MarkerId('spot1'),
  //     position: LatLng(37.797891, -122.406749),
  //   )
  // };

  @override
  void initState() {
    super.initState();

    asyncFunction();
  }

  Future asyncFunction() async {
    List<ParkingOption> preRoutes = await getRoutes(
        widget.event.latitude, widget.event.longitude, widget.parkingRadius);

    startIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/home_pin.png');
    startIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/flag_circle.png');

    setState(() {
      parkingOptions = preRoutes;
      parkingOptionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<MaterialColor> lineColors = [
    //   Colors.blue,
    //   Colors.orange,
    //   Colors.red
    // ];

    Set<Polyline> polyset = {};
    for (int routeIndex = 0;
        routeIndex < parkingOptions[parkingOptionIndex].navRoutes.length;
        routeIndex++) {
      // parkingOptions[index]
      // orange if transit
      // green if walk

      polyset.add(Polyline(
          polylineId: PolylineId(parkingOptions[parkingOptionIndex]
              .navRoutes[routeIndex]
              .latLongPairs[0]
              .toString()),
          points: parkingOptions[parkingOptionIndex]
              .navRoutes[routeIndex]
              .latLongPairs,
          color:
              parkingOptions[parkingOptionIndex].navRoutes[routeIndex].mode ==
                      "TRANSIT"
                  ? Colors.purple
                  : Colors.pinkAccent));
    }

    // get the starting coordinate
    LatLng startPos =
        parkingOptions[parkingOptionIndex].navRoutes[0].latLongPairs[0];
    // BitmapDescriptor startIcon = BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/home_pin.svg').then((onValue) {myIcon = onValue});
    Marker startMarker = Marker(
        markerId: const MarkerId('startMarker'),
        position: startPos,
        icon: startIcon);

    // calculate the last coordinate index
    var lastNavRouteI = parkingOptions[parkingOptionIndex].navRoutes.length - 1;
    var lastLatPongPairsI = parkingOptions[parkingOptionIndex]
            .navRoutes[lastNavRouteI]
            .latLongPairs
            .length -
        1;
    LatLng endPos = parkingOptions[parkingOptionIndex]
        .navRoutes[lastNavRouteI]
        .latLongPairs[lastLatPongPairsI];
    Marker endMarker =
        Marker(markerId: const MarkerId('endMarker'), position: endPos);

    // example
    // Polyline driveline = const Polyline(
    //   polylineId: PolylineId("driveline"),
    //   color: Colors.blue,
    //   points: [LatLng(37.7775, -122.416389)], // replace with temp points
    //   endCap: Cap.roundCap,
    // );

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
            ..._getRouteDescriptions(),
          ],
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              cloudMapId: '40bae229feee19e5', // javascript vector
              // cloudMapId: '5b05b9f927bfcf34',  // javascript raster
              // cloudMapId: '701a336f83a1aaa6', // static raster
              // cloudMapId: '74194f22342551fa',  // android
              polylines: polyset,
              markers: {startMarker, endMarker},
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
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                  child: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _getRouteDescriptions() {
    List<Widget> routeDescriptions = [];
    for (int i = 0; i < parkingOptions.length; i++) {
      ParkingOption parkingOption = parkingOptions[i];

      List<Widget> directions = [];
      for (NavRoute navRoute in parkingOption.navRoutes) {
        directions.add(Text(
          navRoute.mode,
          style: Styles().defaultTextStyle,
        ));
      }

      routeDescriptions.add(GestureDetector(
          onTap: () => setState(() => parkingOptionIndex = i),
          child: Card(
              child: Column(
            children: [
              Text(
                parkingOption.endAddress,
                style: Styles().largeTextStyle,
              ),
              Text(
                parkingOption.fareText,
                style: Styles().defaultTextStyle,
              ),
              Text(
                parkingOption.timeText,
                style: Styles().defaultTextStyle,
              )
            ],
          ))));
    }

    return routeDescriptions;
  }
}
