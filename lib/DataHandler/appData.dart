import 'package:bsa/Models/address.dart';
import 'package:flutter/material.dart';
import 'package:bsa/Assistants/requestAssistant.dart';

class AppData extends ChangeNotifier {
  Address currentLocation;

  //in below line currLoc is the var
  void updateCurrentLocationAddress(Address currLocAddress) {
    currentLocation = currLocAddress;

    //below listener function detects changes in loc and broadcasts it
    notifyListeners();
  }
}
