import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bsa/DataHandler/appData.dart';
import 'package:bsa/Models/directionDetails.dart';
import 'package:bsa/components/progressDialog.dart';
import 'package:bsa/directions_repository.dart';
import 'package:bsa/menu_frame.dart';
import 'package:bsa/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:bsa/menu_screen.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'Assistants/assistantMethods.dart';
import 'directions_model.dart';

class MapScreen extends StatefulWidget {
  // static String route = "home";

  final auth = FirebaseAuth.instance;
  final Function menuCallback;

  MapScreen({@required this.menuCallback});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  //getting lat/long of user current pos
  Position currentPosition;
  var geoLocator = Geolocator();
  double bottomPaddingOfMap = 0;

  //to display distance between loc and dest
  DirectionDetails tripDirectionDetails;

  // for setting labels on markers
  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};

  //in below line using below var to hide black spot details
  double rideDetailsContainerHeight = 0;
  double searchContainerHeight = 200.0;

  //making a boolean value to make drawer icon into a cancel button to cancel ride
  bool drawerOpen = true;
  bool detailsOpen = false;

  //below function is to cancel ride info
  resetApp() {
    setState(() {
      drawerOpen = true;

      searchContainerHeight = 220;
      rideDetailsContainerHeight = 00.0;
      bottomPaddingOfMap = 230;

      //below resetting markers polylines coords circles
      polylineSet.clear();
      markersSet.clear();
      circlesSet.clear();
      pLineCoordinates.clear();
    });

    locatePosition();
  }

  void _detailsOpen() {
    setState(() {
      detailsOpen = false;
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 260.0;
      bottomPaddingOfMap = 230;
    });
  }

  void _detailsClose() {
    setState(() {
      detailsOpen = true;
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 160.0;
      bottomPaddingOfMap = 230;
    });
  }

  //using below function to hide unwanted card in that instance
  void displayRideDetailsContainer() async {
    await getPlaceDirection();

    setState(() {
      searchContainerHeight = 0;
      rideDetailsContainerHeight = 160.0;
      bottomPaddingOfMap = 230;
      drawerOpen = false;
    });
  }

  //function for getting location
  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    //below change to latLang* if error occurs (resolved)
    LatLng latLangPosition = LatLng(position.latitude, position.longitude);

    //instance to move cam as you move on the map
    CameraPosition cameraPosition =
        new CameraPosition(target: latLangPosition, zoom: 14);
    _googleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//below code is to get address of use using geoCoding (resolved)
    String address =
        await AssistantMethods.searchCoordinateAddress(position, context);
    print("this is your Address :: " + address);
  }

  //fixing a location on the map (san fran)
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(37.773972, -122.431297),
    zoom: 12.0,
  );

  //below controller centers the map on your location
  GoogleMapController _googleMapController;

  //below list stores the points data to draw polyline from currLoc to dest
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};

  //2 markers for storing origin and destination
  Marker _origin;
  Marker _destination;

  Directions _info;

//below dispose function prevents unwanted use of the controller
  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: false,
        title: const Text('Black Spot Alert'),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin.position,
                    zoom: 18.0,
                    tilt: 55.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination.position,
                    zoom: 19.0,
                    tilt: 55.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            polylines: polylineSet,
            markers: markersSet,
            circles: circlesSet,
            onMapCreated: (controller) {
              _googleMapController = controller;

              setState(() {
                bottomPaddingOfMap = 300.0;
              });
              //below function animates cam to user loc
              locatePosition();
            },
            onLongPress: _addMarker,
            //code for 2 markers to add on the screen
            // markers: {
            //   if (_origin != null) _origin,
            //   if (_destination != null) _destination
            // },
            // polylines: {
            //   if (_info != null)
            //     Polyline(
            //       polylineId: const PolylineId('overview_polyline'),
            //       color: Colors.blueAccent,
            //       width: 5,
            //       points: _info.polylinePoints
            //           .map((e) => LatLng(e.latitude, e.longitude))
            //           .toList(),
            //     ),
            // },

            //below line was a test hence commented
            // polylineSet.add(addpolyline);
            // onLongPress: _addMarker,
          ),

          //side menu button code below
          //check if not functioning properly after adding more screens like search and profile
          Positioned(
            top: 12.0,
            left: 12.0,
            child: Container(
              width: 50.0,
              height: 50.0,
              child: InkWell(
                child: Icon(
                  //below lines decides when menu icon becomes cancel icon
                  (drawerOpen) ? Icons.menu_rounded : Icons.cancel_outlined,
                  color: Colors.black87,
                  size: 40,
                ),
                onTap: () {
                  if (drawerOpen) {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MenuFrame()));
                    //goes to menu screen
                  } else {
                    resetApp();
                  }
                },
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
            ),
          ),
          //code for bottom card starts below
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 160),
              child: Container(
                height: searchContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                //inside content code starts below
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 6.0),
                      Text(
                        "Hey there, ",
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      Text(
                        "Where to?",
                        style: TextStyle(
                            fontSize: 20.0, color: Colors.grey //add a font fam
                            ),
                      ),
                      SizedBox(height: 10.0),
                      //below container search block
                      GestureDetector(
                        onTap: () async {
                          var res = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchPage()));
                          //goes to search page

                          if (res == "obtainDirection") {
                            displayRideDetailsContainer();
                            // await getPlaceDirection();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ],
                          ),
                          //code for search bar starts below
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.blueAccent,
                                ),
                                SizedBox(
                                  width: 60.0,
                                ),
                                Text(
                                  "Search your destination",
                                  style: TextStyle(color: Colors.blueGrey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 24.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //in below text widget we display user current loc and if its not available add it
                              Text(
                                "Currently you are at : ",
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12.0),
                              ),
                              SizedBox(height: 10.0),

                              Text(
                                Provider.of<AppData>(context).currentLocation !=
                                        null
                                    ? Provider.of<AppData>(context)
                                        .currentLocation
                                        .placeName
                                    : "searching for location...",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 10.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //below card is used to display black spots in the path if there are any
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: Duration(milliseconds: 160),
              child: Container(
                height: rideDetailsContainerHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 50.0,
                          height: 5.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.tealAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 10.0),
                        child: Row(
                          children: [
                            //below here an image is supposed to be replaced with icon
                            // SizedBox(width: 10.0),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 180.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.blueAccent,
                                      ),
                                      child: Center(
                                        child: DefaultTextStyle(
                                          style: const TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          child: AnimatedTextKit(
                                            animatedTexts: [
                                              WavyAnimatedText(
                                                  'BlackSpotDetails'),
                                              WavyAnimatedText(
                                                  'BlackSpotDetails'),
                                            ],
                                            isRepeatingAnimation: true,
                                            onTap: () {
                                              if (detailsOpen) {
                                                _detailsOpen();
                                                //goes to menu screen
                                              } else {
                                                _detailsClose();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5.0),
                                InkWell(
                                  onTap: () {
                                    if (detailsOpen) {
                                      _detailsOpen();
                                      //goes to menu screen
                                    } else {
                                      _detailsClose();
                                    }
                                  },
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border:
                                          Border.all(color: Colors.blueAccent),
                                      color: Colors.white60,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        //below lines decides when menu icon becomes cancel icon
                                        (detailsOpen)
                                            ? Icons.keyboard_arrow_up_outlined
                                            : Icons
                                                .keyboard_arrow_down_outlined,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 10.0),

                            Container(
                              width: 130,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    SizedBox(width: 5.0),
                                    Icon(
                                      Icons.map_sharp,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 10.0),
                                    Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 4.0),
                                          Text("Distance:",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Colors.black)),
                                          Text(
                                              ((tripDirectionDetails != null)
                                                  ? tripDirectionDetails
                                                      .distanceText
                                                  : ''),
                                              style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              color: Colors.black,
                            ),
                            Text(
                              "BlackSpotDetails go here as listView",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          //to show distance and time to reach destination
          if (_info != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info.totalDistance}, ${_info.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.white,
      //   foregroundColor: Colors.blue,
      //   onPressed: () => _googleMapController.animateCamera(
      //     _info != null
      //         ? CameraUpdate.newLatLngBounds(_info.bounds, 100.0)
      //         : CameraUpdate.newCameraPosition(_initialCameraPosition),
      //   ),
      //   child: const Icon(
      //     Icons.my_location,
      //     color: Colors.black87,
      //   ),
      // ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // Get directions
      final directions = await DirectionsRepository()
          .getDirections(origin: _origin.position, destination: pos);
      setState(() => _info = directions);
    }
  }

  Future<void> getPlaceDirection() async {
    var initialPos =
        Provider.of<AppData>(context, listen: false).currentLocation;

    var finalPos =
        Provider.of<AppData>(context, listen: false).destinationLocation;

    var currentLatLng = LatLng(initialPos.latitude, initialPos.longitude);
    var destLatLng = LatLng(finalPos.latitude, finalPos.longitude);

    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting up, please wait...",
      ),
    );

    var details = await AssistantMethods.obtainPlaceDirectionDetails(
        currentLatLng, destLatLng);

    setState(() {
      tripDirectionDetails = details;
    });

    Navigator.pop(context);

    print("this are the encoded points :: ");
    print(details.encodedPoints);

    //decoding polyline data starts below
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResult =
        polylinePoints.decodePolyline(details.encodedPoints);

    //clears previous data when adding new dest
    pLineCoordinates.clear();

    //what below line does is that it gives us a list of points to draw polyline on map
    if (decodedPolyLinePointsResult.isNotEmpty) {
      decodedPolyLinePointsResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }

    polylineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.pink,
        polylineId: PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinates,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );

      polylineSet.add(polyline);
    });

    setState(() {
      if (_info != null) {
        Polyline addpolyline = Polyline(
          polylineId: const PolylineId('overview_polyline'),
          color: Colors.blueAccent,
          width: 5,
          points: _info.polylinePoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        );
        polylineSet.add(addpolyline);
      }
    });

    LatLngBounds latLngBounds;
    if (currentLatLng.latitude > destLatLng.latitude &&
        currentLatLng.longitude > destLatLng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destLatLng, northeast: currentLatLng);
    } else if (currentLatLng.longitude > destLatLng.longitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(currentLatLng.latitude, destLatLng.longitude),
        northeast: LatLng(destLatLng.latitude, currentLatLng.longitude),
      );
    } else if (currentLatLng.latitude > destLatLng.latitude) {
      latLngBounds = LatLngBounds(
        southwest: LatLng(destLatLng.latitude, currentLatLng.longitude),
        northeast: LatLng(currentLatLng.latitude, destLatLng.longitude),
      );
    } else {
      latLngBounds =
          LatLngBounds(southwest: currentLatLng, northeast: destLatLng);
    }
    _googleMapController
        .animateCamera(CameraUpdate.newLatLngBounds(latLngBounds, 70.0));

    Marker currLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow:
          InfoWindow(title: initialPos.placeName, snippet: "you are here"),
      position: currentLatLng,
      markerId: MarkerId("yourLocationId"),
    );

    Marker destLocMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(
          title: finalPos.placeName, snippet: "Destination Location"),
      position: destLatLng,
      markerId: MarkerId("destinationId"),
    );

    setState(() {
      markersSet.add(currLocMarker);
      markersSet.add(destLocMarker);
    });

    Circle currLocCircle = Circle(
      fillColor: Colors.blueAccent,
      center: currentLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.blue,
      circleId: CircleId("yourLocationId"),
    );

    Circle destCircle = Circle(
      fillColor: Colors.deepOrange,
      center: destLatLng,
      radius: 12,
      strokeWidth: 4,
      strokeColor: Colors.deepOrangeAccent,
      circleId: CircleId("destinationId"),
    );

    setState(() {
      circlesSet.add(currLocCircle);
      circlesSet.add(destCircle);
    });
  }
}
