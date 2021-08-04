import 'package:flutter/material.dart';

import 'home.dart';

class Terms extends StatelessWidget {
  final Function menuCallback;

  Terms({@required this.menuCallback});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Terms And Conditions",
          style: TextStyle(fontFamily: "DevantHorgen", color: Colors.green),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MapScreen()));
          },
          child: Icon(
            Icons.arrow_back_sharp,
            color: Colors.green,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 28.0, width: 05.0),
              Text(
                "IMPORTANT",
                style: TextStyle(
                  fontFamily: "HelveticaNow",
                  color: Colors.red,
                  fontSize: 32,
                ),
              ),
              SizedBox(height: 18.0),

              //body terms
              Text(
                "THESE TERMS AND CONDITIONS (“Conditions”) DEFINE THE BASIS UPON WHICH GET WILL PROVIDE YOU WITH ACCESS TO THE THIS MOBILE APPLICATION PLATFORM, PURSUANT TO WHICH YOU WILL BE ABLE TO REQUEST CERTAIN SERVICES FROM THE SERVER BY PLACING ORDERS THROUGH THIS MOBILE APPLICATION PLATFORM. ",
                style: TextStyle(
                  fontFamily: "HelveticaNow",
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18.0),
              Text(
                "THESE CONDITIONS (TOGETHER WITH THE DOCUMENTS REFERRED TO HEREIN) SET OUT THE TERMS OF USE ON WHICH YOU MAY, AS A CUSTOMER, USE THE APP AND REQUEST THESE SERVICES. ",
                style: TextStyle(
                  fontFamily: "HelveticaNow",
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18.0),
              Text(
                "BY USING THE APP AND TICKING THE ACCEPTANCE BOX, YOU INDICATE THAT YOU ACCEPT THESE TERMS OF USE WHICH APPLY, AMONG OTHER THINGS, TO ALL SERVICES HERE IN UNDER TO BE RENDERED TO OR BY YOU VIA THE APP WITHIN INDIA AND THAT YOU AGREE TO ABIDE BY THEM. ",
                style: TextStyle(
                  fontFamily: "HelveticaNow",
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 18.0),

              Text(
                "USE THE APP AND REQUEST THE SERVICES, BY USING THE APP AND TICKING THE ACCEPTANCE BOX, YOU INDICATE THAT YOU ACCEPT THESE TERMS OF USE WHICH APPLY, AMONG OTHER THINGS, TO ALL SERVICES HERE IN UNDER TO BE RENDERED TO OR BY YOU VIA THE APP WITHIN INDIA AND THAT YOU AGREE TO ABIDE BY THEM. ",
                style: TextStyle(
                  fontFamily: "HelveticaNow",
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
