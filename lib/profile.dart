import 'package:flutter/material.dart';
import 'package:bsa/menu_frame.dart';

class ProfilePage extends StatefulWidget {
  final Function menuCallback;

  ProfilePage({@required this.menuCallback});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                        color: Colors.blue,
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
                color: Colors.deepOrangeAccent,
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

// class ProfilePage extends StatelessWidget {
//   final Function menuCallback;
//
//   ProfilePage({@required this.menuCallback});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topRight,
//                 end: Alignment.bottomLeft,
//                 colors: [
//                   Color(0xffFFCE69),
//                   Color(0xffE86F39),
//                 ],
//               ),
//               border: Border.all(
//                   style: BorderStyle.solid, color: Colors.blueAccent),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//}
