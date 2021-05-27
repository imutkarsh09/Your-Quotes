import 'dart:async';

import "package:flutter/material.dart";
import 'package:yourquotes/Navigations/home.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Home())));
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("This is splash screen"),
        ),
      ),
    );
  }
}
