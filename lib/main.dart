import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);

    _animation = Tween(begin: 0.0, end: 300.0).animate(new CurvedAnimation(
      parent: _animationController,
      curve:  new Interval(
        0.0,
        0.20,
        curve: Curves.linear,
      ),
    ));


   _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LogoAnimation(
      animation: _animation,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class LogoAnimation extends AnimatedWidget {
  LogoAnimation({Key key, Animation animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Row(
        children: <Widget>[
          Container(
            height: animation
                .value,
            width: animation.value,
            child: Image.asset('assets/changefly-cube-left.png', height: 10.0, width: 10.0),
          ),
          Container(
            height: animation
                .value,
            width: animation.value,
            child: Image.asset('assets/changefly-cube-right.png', height: 10.0, width: 10.0),
          ),
        ],
      ),
    );
  }
}