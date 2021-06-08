import 'package:flutter/material.dart';
import 'package:bsa/views/Login/components/body.dart';

class LoginScreenView extends StatelessWidget {
  static String route = "login";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
