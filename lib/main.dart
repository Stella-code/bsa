import 'package:bsa/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bsa/signIn.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      title: 'Black Spot Alert',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Roboto",
      ),
      home: Container(
        child: AnimatedSplashScreen(
          splash: Image.asset(
            'assets/images/splashlogo.png',
            fit: BoxFit.cover,
            // width: 400.0,
            // height: 1000.0,
          ),
          nextScreen: SignIn(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.blueAccent,
          duration: 3000,
        ),
      ),
    );
  }
}
