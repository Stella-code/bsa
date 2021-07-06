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
      body: Text("Terms and Conditions go here",
          style: TextStyle(fontFamily: "HelveticaNow")),
    );
  }
}
