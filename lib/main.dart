import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:yourquotes/Splash%20Screen/splash.dart';
import 'package:yourquotes/User%20Info/userinfo.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
