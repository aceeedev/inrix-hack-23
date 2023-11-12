import 'package:app/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:app/backend/flask_interface.dart';
import 'package:app/models/event.dart';
import 'package:app/models/parking_option.dart';
import 'package:app/models/nav_route.dart';

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
        parkingAddress: '',
        totalTimeText: '',
        totalTime: 1,
        totalFareText: '',
        totalFare: 1,
        navRoutes: [
          NavRoute(mode: 'TRANSIT', latLongPairs: const [
            LatLng(37.7775, -122.416389),
            LatLng(37.7775, -122.416389)
          ])
        ])
  ];
  // late LatLng startPos = const LatLng(37.7775, -122.416389);
  late int parkingOptionIndex = 0;

  LatLng startPos = const LatLng(99, 99);
  LatLng endPos = const LatLng(99, 99);
  late BitmapDescriptor startIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow);
  late BitmapDescriptor endIcon = BitmapDescriptor.defaultMarker;
  late BitmapDescriptor midIcon = BitmapDescriptor.defaultMarker;

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

  bool isLoading = true;
  late List<Widget> routeDescriptions = [];

  @override
  void initState() {
    super.initState();

    asyncFunction();
  }

  Future asyncFunction() async {
    setState(() {
      isLoading = true;
    });

    List<ParkingOption> preRoutes = await getRoutes(
        widget.event.latitude, widget.event.longitude, widget.parkingRadius);

    startIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/icons/home_pin.png');
    midIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)), 'assets/icons/train.png');
    endIcon = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(48, 48)),
        'assets/icons/flag_circle.png');

    setState(() {
      parkingOptions = preRoutes;
      parkingOptionIndex = 0;

      routeDescriptions = _getRouteDescriptions();

      isLoading = false;
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

      // determine color
      Color polylineColor = Colors.black;
      switch (parkingOptions[parkingOptionIndex].navRoutes[routeIndex].mode) {
        case 'WALKING':
          {
            polylineColor = Colors.pinkAccent;
            break;
          }
        case 'TRANSIT':
          {
            polylineColor = Colors.purple;
            break;
          }
        case 'DRIVING':
          {
            polylineColor = Colors.indigo;
            break;
          }
        default:
          {
            polylineColor = Colors.white;
            break;
          }
      }

      polyset.add(Polyline(
          polylineId: PolylineId(parkingOptions[parkingOptionIndex]
              .navRoutes[routeIndex]
              .latLongPairs[0]
              .toString()),
          points: parkingOptions[parkingOptionIndex]
              .navRoutes[routeIndex]
              .latLongPairs,
          color: polylineColor));
    }

    // get the starting coordinate
    LatLng startPos =
        parkingOptions[parkingOptionIndex].navRoutes[0].latLongPairs[0];
    // BitmapDescriptor startIcon = BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/icons/home_pin.svg').then((onValue) {myIcon = onValue});
    Marker startMarker = Marker(
        markerId: const MarkerId('startMarker'),
        position: startPos,
        icon: startIcon);

    // calculate the mid index
    LatLng midPos = parkingOptions[parkingOptionIndex]
            .navRoutes[0]
            .latLongPairs[
        parkingOptions[parkingOptionIndex].navRoutes[0].latLongPairs.length -
            1];
    Marker midMarker = Marker(
        markerId: const MarkerId('startMarker'),
        position: midPos,
        icon: midIcon);

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
    Marker endMarker = Marker(
        markerId: const MarkerId('endMarker'), position: endPos, icon: endIcon);

    // example
    // Polyline driveline = const Polyline(
    //   polylineId: PolylineId("driveline"),
    //   color: Colors.blue,
    //   points: [LatLng(37.7775, -122.416389)], // replace with temp points
    //   endCap: Cap.roundCap,
    // );

    return Scaffold(
      body: SlidingUpPanel(
        minHeight: 120.0,
        panel: Column(
          children: [
            const Divider(
              height: 20,
              thickness: 2,
              indent: 100,
              endIndent: 100,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                'Parking Options',
                style: Styles().largeTextStyle,
              ),
            ),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else
              Expanded(
                child: ListView.builder(
                  itemCount: routeDescriptions.length,
                  itemBuilder: (context, index) => routeDescriptions[index],
                ),
              )
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
              markers: {startMarker, midMarker, endMarker},
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
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Styles().borderColor, width: 2.5),
                borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      parkingOption.parkingAddress,
                      style: Styles().mediumTextStyle,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.attach_money),
                        Text(
                          parkingOption.totalFareText
                              .substring(1, parkingOption.totalFareText.length),
                          style: Styles().defaultTextStyle,
                        ),
                        const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.timer_outlined)),
                        Text(
                          parkingOption.totalTimeText,
                          style: Styles().defaultTextStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ))));
    }

    return routeDescriptions;
  }
}
