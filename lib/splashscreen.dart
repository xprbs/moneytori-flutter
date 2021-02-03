import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moneytory/getstarted.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer _timer;
  removeScreen() {
    return _timer = Timer(Duration(seconds: 10), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GetStarted()));
    });
  }

  @override
  void initState() {
    super.initState();
    removeScreen();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: new Padding(
      padding: new EdgeInsets.only(top: 250.0),
      child: Center(
        child: new Image.asset(
          "images/i1.png",
          width: 200.0,
        ),
      ),
    ),
  );
}
