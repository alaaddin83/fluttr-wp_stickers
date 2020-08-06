import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Animation flipAnimation;
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initAnimation();
    const duration = Duration(seconds: 2);
    new Timer(duration, () {
      Navigator.of(context).pushReplacementNamed('HomePage');
    });
  }

  //اعداد الحركة
  void initAnimation() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    //تنفيذ الحركة  fastOutSlowIn
    flipAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.fastOutSlowIn,
    ));
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget widget) {
        final double h = MediaQuery.of(context).size.height;
        return Scaffold(
          body: Transform(
            //            transform: Matrix4.identity()
            //              ..rotateZ(2 * pi * flipAnimation.value),

            transform:
                Matrix4.translationValues(0.0, h * flipAnimation.value, 0.0),

            child: Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage("images/background_img2.png"),
//                       fit: BoxFit.cover)),
              color: Colors.white60,
              child: Center(
                child: Image(
                  image: new AssetImage(
                    "assets/images/aladdinapps.png",
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
