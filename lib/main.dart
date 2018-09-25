import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation _animation;
  bool _visible = false;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);

    //Animation to bounce in and out
    _animation = Tween(begin: 0.0, end: 200.0).animate(new CurvedAnimation(
      parent: _animationController,
      curve: new Interval(
        0.0,
        0.25,
        curve: Curves.bounceInOut,
      ),
    ));

    //Timer for when to fade in company name
    new Timer(const Duration(milliseconds: 1500), () {
      setState(() {
        _visible = true;
      });
    });

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Friendlychat",
        home: Scaffold(
          appBar: AppBar(
            title: Text("ChangeFly"),
            elevation:
                Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
          ),
          body: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    LogoAnimation(
                      animation: _animation,
                      logo: 'assets/changefly-cube-top.png',
                    ),
                    Container(
                      child: LogoAnimation(
                        animation: _animation,
                        logo: 'assets/changefly-cube-left.png',
                      ),
                    ),
                    LogoAnimation(
                      animation: _animation,
                      logo: 'assets/changefly-cube-right.png',
                    ),
                  ],
                ),
                AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset('assets/changefly-name.png',
                        height: 200.0, width: 200.0))
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

///
/// Class That create the animation for the images
/// @Animation this animation used for the Image
/// @Logo the name of the asset
///
class LogoAnimation extends AnimatedWidget {
  final String logo;
  LogoAnimation({Key key, Animation animation, this.logo})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Image.asset(
      logo,
      height: animation.value,
      width: animation.value,
    );
  }
}
