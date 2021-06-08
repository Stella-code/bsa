import 'package:bsa/DataHandler/appData.dart';
import 'package:bsa/locator.dart';
import 'package:bsa/views/Login/login_screen.dart';
import 'package:bsa/views/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupServices();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Black Spot Alert',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: Container(
          child: AnimatedSplashScreen(
            splash: Image.asset(
              'assets/images/splashlogo.png',
              fit: BoxFit.fitHeight,
              // width: 400.0,
              // height: 1000.0,
            ),
            nextScreen: LoginScreenView(),
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.blueAccent,
            duration: 3000,
          ),
        ),
        routes: {
          MapScreen.route: (context) => MapScreen(),
          LoginScreenView.route: (context) => LoginScreenView(),
          ProfileView.route: (context) => ProfileView(),
        },
      ),
    );
  }
}
