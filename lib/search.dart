import 'package:bsa/Assistants/requestAssistant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bsa/menu_frame.dart';
import 'package:provider/provider.dart';
import 'package:bsa/.env.dart';
import 'DataHandler/appData.dart';
import 'Models/address.dart';
import 'Models/placePredictions.dart';
import 'components/Divider.dart';
import 'package:bsa/components/progressDialog.dart';

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
  //initializing a list to store places
  List<PlacePredictions> placePredictionList = [];

  @override
  Widget build(BuildContext context) {
    //in below line if there is some data it will retrieve it else display null
    String placeAddress =
        Provider.of<AppData>(context).currentLocation.placeName ?? "";
    locationTextEditingController.text = placeAddress;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: Navigator.of(context).pop,
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Search Destination'),
      ),
      body: Column(
        children: [
          Container(
            height: 220.0,
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

                  // SizedBox(height: 20),
                  Row(
                    children: [
                      Positioned(
                        top: 12.0,
                        left: 12.0,
                        child: Container(
                          width: 50.0,
                          height: 50.0,
                          child: InkWell(
                            child: Icon(
                              Icons.menu_rounded,
                              color: Colors.black87,
                              size: 35,
                            ),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MenuFrame()));
                              //goes to menu screen
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
                              onChanged: (val) {
                                findPlace(val);
                              },
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
          //tile for displaying the predictions
          SizedBox(height: 10.0),
          (placePredictionList.length > 0)
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListView.separated(
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return PredictionTile(
                          placePredictions: placePredictionList[index]);
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        DividerWidget(),
                    itemCount: placePredictionList.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                  ),
                )
              : Container(),
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

  //below is async function to get details about places
  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      //below url is used to send request to places api to get info
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$googleAPIKey&sessiontoken=1234567890&components=country:in";

      var res = await RequestAssistant.getRequest(Uri.parse(autoCompleteUrl));

      if (res == "failed") {
        return;
      }
      //checking response if status is good
      if (res["status"] == "OK") {
        var predictions = res["predictions"];

        //below line is used to retrieve responses from places api in json and store them in placeList
        var placesList = (predictions as List)
            .map((e) => PlacePredictions.fromJson(e))
            .toList();

        //below line will update our placePrediction list
        setState(() {
          placePredictionList = placesList;
        });
      }
    }
  }
}

class PredictionTile extends StatelessWidget {
  final PlacePredictions placePredictions;

  PredictionTile({Key key, this.placePredictions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(00.0),
      onPressed: () {
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child: Column(
          children: [
            SizedBox(width: 10.0),
            Row(
              children: [
                Icon(Icons.add_location_sharp),
                SizedBox(width: 14.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        placePredictions.main_text,
                        //below line of code handles places that have a long name
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }

  //below function is used to get details of places
  void getPlaceAddressDetails(String placeId, context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "please wait...",
      ),
    );

    String placeDetailsUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleAPIKey";

    var res = await RequestAssistant.getRequest(Uri.parse(placeDetailsUrl));

    Navigator.pop(context);

    if (res == "failed") {
      return;
    }
    if (res["status"] == "OK") {
      Address address = Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false)
          .updateDestinationLocationAddress(address);

      print("this is destination location:: ");
      print(address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
  }
}
