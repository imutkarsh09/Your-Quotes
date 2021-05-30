import "package:flutter/material.dart";
import 'package:yourquotes/Web%20Scrapping/scrapping.dart';
import 'Splash Screen/splash.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scrapper(),
    );
  }
}
