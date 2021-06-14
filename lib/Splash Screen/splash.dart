import 'dart:async';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Navigations/home.dart';
import 'package:yourquotes/User%20Info/userinfo.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String name;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  Future<String> loadData() async {
    String naam = sharedPreferences.getString("user");
    if (naam == null) {
      naam = "";
    }
    setState(() {
      name = naam;
      print("name is ----->");
      print(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => name == ""
            ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => UserInfo()))
            : Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => Home())));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: AssetImage("Images/Splash_Image/Splash.jpg"),
          fit: BoxFit.fill,
        ),
      )),
    );
  }
}
