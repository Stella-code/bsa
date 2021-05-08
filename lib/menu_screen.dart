import 'package:bsa/signIn.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
Color startingColor = Color.fromRGBO(70, 112, 112, 1.0);

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedMenuIndex = 0;
  @override
  Widget build(BuildContext context) {
    // decoration:
    // BoxDecoration(
    //   gradient: LinearGradient(
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter,
    //     colors: [startingColor, mainColor],
    //   ),
    // );
    List<String> menuItems = [
      'Home',
      'Search',
      'T & C',
      'Profile',
      'Settings',
    ];
    List<IconData> icons = [
      Icons.home_outlined,
      Icons.search_sharp,
      Icons.event_note_outlined,
      Icons.person_outline_outlined,
      Icons.settings,
    ];
    Widget buildMenuRow(int index) {
      return InkWell(
        onTap: () {
          setState(() {
            selectedMenuIndex = index;
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Row(
            children: <Widget>[
              Icon(
                icons[index],
                color: selectedMenuIndex == index
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(
                menuItems[index],
                style: TextStyle(
                  color: selectedMenuIndex == index
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final auth = FirebaseAuth.instance;
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 20.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                //bsa logo code below
                Row(
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/images/bsa_logo.png'),
                      height: 80.0,
                    ),
                  ],
                ),
                //side menu options code below each option is a unique row
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuItems
                      .asMap()
                      .entries
                      .map((mapEntry) => buildMenuRow(mapEntry.key))
                      .toList(),
                ),

                Row(
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    FlatButton(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () {
                        auth.signOut();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => SignIn()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
