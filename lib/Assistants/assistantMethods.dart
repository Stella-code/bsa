import 'package:bsa/Assistants/requestAssistant.dart';
import 'package:bsa/DataHandler/appData.dart';
import 'package:bsa/Models/address.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:bsa/.env.dart';
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
}
