//code for logout button, leads to signin page
// add this line to initialize auth, also import it  //final auth = FirebaseAuth.instance;
// Center(
// child: FlatButton(
// child: Text('logout'),
// onPressed: () {
// auth.signOut();
// Navigator.of(context).pushReplacement(
// MaterialPageRoute(builder: (context) => SignIn()));
// },
// ),
// ),
//
// //folder path for firebase storage gs://email-login-94234.appspot.com
// //
// //  gs://email-login-94234.appspot.com
//
// //black spot details button
// Container(
// height: 52.0,
// width: 192.0,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(30),
// color: Color(0xfffa4a0c),
// ),
// child: Row(
// mainAxisSize: MainAxisSize.min,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// SizedBox(height: 15, width: 14),
// Text(
// "BlackSpot Details",
// textAlign: TextAlign.start,
// style: TextStyle(
// color: Color(0xfff6f6f9),
// fontSize: 18,
// ),
// ),
// SizedBox(height: 15.0, width: 8),
// InkWell(
// onTap: () {
// if (detailsOpen) {
// _detailsOpen();
// //goes to menu screen
// } else {
// _detailsClose();
// }
// },
// child: Container(
// width: 43,
// height: 43,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// boxShadow: [
// BoxShadow(
// color: Color(0x3f000000),
// blurRadius: 10,
// offset: Offset(-4, 4),
// ),
// ],
// color: Color(0xffeb3f03),
// ),
// child: Center(
// child: (detailsOpen)
// ? Icon(
// Icons.keyboard_arrow_up_rounded,
// color: Colors.white,
// size: 30)
// : Icon(
// Icons
//     .keyboard_arrow_down_rounded,
// color: Colors.white,
// size: 30),
// ),
// ),
// ),
// ],
// ),
// ),
