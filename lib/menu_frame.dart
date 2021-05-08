import 'package:bsa/home.dart';
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
  Animation<double> scaleAnimation;
  //time taken for the screen to travel
  Duration duration = Duration(milliseconds: 200);
  bool menuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);
  }

  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        MenuScreen(),
        AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left: menuOpen ? deviceWidth * 0.55 : 0.0,
          right: menuOpen ? deviceWidth * -0.45 : 0.0,
          child: ScaleTransition(
            scale: scaleAnimation,
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
                      borderRadius:
                          BorderRadius.circular(menuOpen ? 40.0 : 0.0),
                      child: MapScreen(
                        menuCallback: () {
                          setState(() {
                            menuOpen = true;
                            _animationController.forward();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
