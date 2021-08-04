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

import 'components/text_field_container.dart';
import 'constants.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MenuFrame()));
          },
          icon: Icon(
            Icons.menu_rounded,
            color: Colors.green,
            size: 35.0,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Search Destination',
          style: TextStyle(color: Colors.green, fontFamily: "DevantHorgen"),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 220.0,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6.0,
                spreadRadius: 0.2,
                offset: Offset(0.7, 0.7),
              ),
            ]),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 25.0, top: 10.0, right: 25.0, bottom: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 10.0),
                  //search block code below
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextFieldContainer(
                            child: TextField(
                              //add code to change field color on input
                              onChanged: (value) {},
                              cursorColor: kPrimaryColor,
                              keyboardType: TextInputType.text,
                              controller: locationTextEditingController,
                              decoration: InputDecoration(
                                labelText: "Your Location",
                                icon: Icon(
                                  Icons.my_location,
                                  color: kPrimaryColor,
                                ),
                                hintText: "current location",
                                border: InputBorder.none,
                              ),
                            ),
                          ),

                          // TextField(
                          //   controller: locationTextEditingController,
                          //   decoration: InputDecoration(
                          //     hintText: "current location",
                          //     fillColor: Colors.grey[400],
                          //     filled: true,
                          //     border: InputBorder.none,
                          //     isDense: true,
                          //     contentPadding: EdgeInsets.only(
                          //         left: 11.0, top: 8.0, bottom: 8.0),
                          //   ),
                          // ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  //drop off code below
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: TextFieldContainer(
                            child: TextField(
                              onChanged: (val) {
                                findPlace(val);
                              },
                              cursorColor: kPrimaryColor,
                              keyboardType: TextInputType.text,
                              controller: destinationTextEditingController,
                              decoration: InputDecoration(
                                labelText: "Destination",
                                icon: Icon(
                                  Icons.edit_location_rounded,
                                  color: kPrimaryColor,
                                ),
                                hintText: "Enter Destination",
                                border: InputBorder.none,
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
        child: Expanded(
          child: Column(
            children: [
              SizedBox(width: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.add_location_sharp,
                    color: Colors.green,
                  ),
                  SizedBox(width: 14.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.0),
                      Text(
                        placePredictions.main_text,
                        //below line of code handles places that have a long name
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontFamily: "DevantHorgen"),
                      ),
                      SizedBox(height: 3.0),
                      Text(
                        placePredictions.secondary_text,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey,
                            fontFamily: "HelveticaNow"),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 10.0),
            ],
          ),
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
