import 'package:bsa/home.dart';
import 'package:bsa/search.dart';
import 'package:bsa/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'menu_screen.dart';

class MenuFrame extends StatefulWidget {
  @override
  _MenuFrameState createState() => _MenuFrameState();
}

class _MenuFrameState extends State<MenuFrame>
    with SingleTickerProviderStateMixin {
  //controller to animate screens form ltr | rtl
  AnimationController _animationController;
  Animation<double> scaleAnimation, smallerScaleAnimation;
  //time taken for the screen to travel
  Duration duration = Duration(milliseconds: 200);
  bool menuOpen = true; //change to false if error shows
  List<Animation> scaleAnimations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    //initialized scale animation
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.7).animate(_animationController);
    //initialized smaller scale animation
    smallerScaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);

    //defined the list scaleAnimations which has 3 screens showing
    scaleAnimations = [
      Tween<double>(begin: 1.0, end: 0.7).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.6).animate(_animationController),
      Tween<double>(begin: 1.0, end: 0.5).animate(_animationController),
    ];
    _animationController.forward();
    screenSnapshot = screens.values.toList();
  }

  //map of screens that can be navigated to in the menu drawer
  Map<int, Widget> screens = {
    // 0: Container(
    //   decoration: BoxDecoration(
    //     color: Colors.deepOrange,
    //     borderRadius: BorderRadius.circular(40.0),
    //   ),
    // ),
    // 1: Container(
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(40.0),
    //   ),
    // ),
    // 3: Container(
    //   decoration: BoxDecoration(
    //     color: Colors.blueAccent,
    //     borderRadius: BorderRadius.circular(40.0),
    //   ),
    // ),
    //first should be MapScreen
    0: MapScreen(
      menuCallback: () {},
    ),
    //second should be search screen
    1: SearchPage(
      menuCallback: () {},
    ),
    //third should be profile screen
    2: ProfileView(
      menuCallback: () {},
    ),
  };

  //below is the list of screens in the menu drawer
  List<Widget> screenSnapshot;

  List<Widget> finalStack() {
    List<Widget> stackToReturn = [];
    stackToReturn.add(MenuScreen(
      menuCallback: (selectedIndex) {
        setState(() {
          screenSnapshot = screens.values.toList();
          final selectedWidget = screenSnapshot.removeAt(selectedIndex);
          screenSnapshot.insert(0, selectedWidget);
        });
      },
    ));

    screenSnapshot
        .asMap()
        .entries
        .map((screenEntry) => buildScreenStack(screenEntry.key))
        .toList()
        .reversed
      ..forEach((screen) {
        stackToReturn.add(screen);
      });

    return stackToReturn;
  }

  Widget buildScreenStack(int position) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: menuOpen ? deviceWidth * 0.55 - (position * 50) : 0.0,
      right: menuOpen ? deviceWidth * -0.45 + (position * 50) : 0.0,
      child: ScaleTransition(
        scale: scaleAnimations[position],
        child: GestureDetector(
          onTap: () {
            if (menuOpen) {
              setState(() {
                menuOpen = false;
                _animationController.reverse();
              });
            }
          },
          child: AbsorbPointer(
            absorbing: menuOpen,
            child: Stack(
              children: <Widget>[
                Material(
                  animationDuration: duration,
                  //border radius is not getting implemented check why
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(menuOpen ? 40.0 : 0.0),
                  child: screenSnapshot[position],
                  // MapScreen(
                  //   menuCallback: () {
                  //     setState(() {
                  //       menuOpen = true;
                  //       _animationController.forward();
                  //     });
                  //   },
                  // ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //below  commented line cause error in placing screens properly
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: finalStack(),
    );
  }
}
