import 'package:bsa/Assistants/requestAssistant.dart';
import 'package:bsa/DataHandler/appData.dart';
import 'package:bsa/Models/address.dart';
import 'package:bsa/Models/directionDetails.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bsa/.env.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class AssistantMethods {
  static Future<String> searchCoordinateAddress(
      Position position, context) async {
    String placeAddress = "";
    //made unique vars to store each component of address
    String st1, st2, st3, st4;
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$googleAPIKey";
    var response = await RequestAssistant.getRequest(Uri.parse(url));

    if (response != "failed") {
      //commented below line so that it doesn't display detailed address as it is privacy risk
      // placeAddress = response["results"][0]["formatted_address"];
      st1 = response["results"][0]["address_components"][0]["long_name"];
      st2 = response["results"][0]["address_components"][1]["long_name"];
      st3 = response["results"][0]["address_components"][5]["long_name"];
      st4 = response["results"][0]["address_components"][6]["long_name"];
      placeAddress = st1 + ", " + st2 + ", " + st3 + ", " + st4;

      //assigning all required values to be used in the address

      Address userCurrentLocation = new Address();
      userCurrentLocation.longitude = position.longitude;
      userCurrentLocation.latitude = position.latitude;
      userCurrentLocation.placeName = placeAddress;
      //listen is set to false as we only want to update current location
      Provider.of<AppData>(context, listen: false)
          .updateCurrentLocationAddress(userCurrentLocation);
    }
    return placeAddress;
  }
  //below is the code for drawing polyLines after setting destinationLocation

  static Future<DirectionDetails> obtainPlaceDirectionDetails(
      LatLng initialPosition, LatLng finalPosition) async {
    //below line is to make polyline's request
    String directionUrl =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$googleAPIKey";

    var res = await RequestAssistant.getRequest(Uri.parse(directionUrl));

    if (res == "failed") {
      return null;
    }
    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints =
        res["routes"][0]["overview_polyline"]["points"];

    directionDetails.distanceText =
        res["routes"][0]["legs"][0]["distance"]["text"];

    directionDetails.distanceValue =
        res["routes"][0]["legs"][0]["distance"]["value"];

    directionDetails.durationText =
        res["routes"][0]["legs"][0]["duration"]["text"];

    directionDetails.durationValue =
        res["routes"][0]["legs"][0]["duration"]["value"];

    return directionDetails;
  }

  //use below function to display black spot details which come on the card after setting dest and getting polyline info
  // static int calculateDetails(DirectionDetails directionDetails) {
  //   double
  // }
}
