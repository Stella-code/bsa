import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';

class RequestAssistant {
  // var url = Uri.parse('https://example.com');
  //add String before url in below line
  static Future<dynamic> getRequest(Uri url) async {
    http.Response response = await http.get(url);

    try {
      if (response.statusCode == 200) {
        String jSonData = response.body;
        var decodeData = jsonDecode(jSonData);
        return decodeData;
      } else {
        return "failed";
      }
    } catch (exp) {
      return "failed";
    }
  }
}
