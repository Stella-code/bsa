import 'package:flutter/material.dart';
import 'package:bsa/menu_frame.dart';

class SearchPage extends StatefulWidget {
  final Function menuCallback;

  SearchPage({@required this.menuCallback});
  @override
  _SearchPage createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Positioned(
                top: 12.0,
                left: 12.0,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 50.0,
                      height: 50.0,
                      child: Positioned(
                        child: InkWell(
                          child: Icon(
                            Icons.menu_sharp,
                            color: Colors.black87,
                            size: 31.0,
                          ),
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MenuFrame()));
                            //goes to menu screen
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(14.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                border:
                    Border.all(style: BorderStyle.solid, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
