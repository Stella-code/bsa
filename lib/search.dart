import 'package:flutter/material.dart';
import 'package:bsa/menu_frame.dart';
import 'package:provider/provider.dart';

import 'DataHandler/appData.dart';

class SearchPage extends StatefulWidget {
  final Function menuCallback;

  SearchPage({@required this.menuCallback});
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  //below controllers are used to display the set location in the search field
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    //in below line if there is some data it will retrieve it else display null
    String placeAddress =
        Provider.of<AppData>(context).currentLocation.placeName ?? "";
    locationTextEditingController.text = placeAddress;

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.5,
                offset: Offset(0.7, 0.7),
              ),
            ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 25.0, right: 25.0, bottom: 20.0),
              child: Column(
                children: [
                  SizedBox(height: 5.0),

                  Stack(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      Center(
                        child: Text(
                          "search destination",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),
                  //search block code below
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: locationTextEditingController,
                              decoration: InputDecoration(
                                hintText: "current location",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  //drop off code below
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              controller: destinationTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors.grey[400],
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(
                                    left: 11.0, top: 8.0, bottom: 8.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: Container(
      //         child: Positioned(
      //           top: 12.0,
      //           left: 12.0,
      //           child: Row(
      //             children: <Widget>[
      //               Container(
      //                 width: 50.0,
      //                 height: 50.0,
      //                 child: Positioned(
      //                   child: InkWell(
      //                     child: Icon(
      //                       Icons.menu_sharp,
      //                       color: Colors.black87,
      //                       size: 31.0,
      //                     ),
      //                     onTap: () {
      //                       Navigator.of(context).pushReplacement(
      //                           MaterialPageRoute(
      //                               builder: (context) => MenuFrame()));
      //                       //goes to menu screen
      //                     },
      //                   ),
      //                 ),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white70,
      //                   borderRadius: BorderRadius.circular(14.0),
      //                   boxShadow: const [
      //                     BoxShadow(
      //                       color: Colors.black26,
      //                       offset: Offset(0, 2),
      //                       blurRadius: 6.0,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         width: double.infinity,
      //         decoration: BoxDecoration(
      //           color: Colors.blueAccent,
      //           border:
      //               Border.all(style: BorderStyle.solid, color: Colors.grey),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
