import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "package:flutter_spinkit/flutter_spinkit.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url =
      "https://quote-garden.herokuapp.com/api/v3/quotes/random?genre=motivational";
  List data = [];

  @override
  void initState() {
    super.initState();
    getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
        // Encoding the URL
        Uri.parse(url),
        // Only accept Json response
        headers: {"Accept": "application/json"});
    // print(response.body);
    setState(() {
      var convertDatatoJson = jsonDecode(response.body);
      print(convertDatatoJson);
      data = convertDatatoJson["data"];
      print(data);
      print(" Length ----> ");
      // print(data[1].runtimeType);
      print(data.length);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController sercontroller;
    return data.length == 0
        ? Center(
            child: SpinKitWave(
            color: Colors.white,
          ))
        : Scaffold(
            body: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.blueAccent[200],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Container(
                        width: double.infinity,
                        height: 35,
                        margin:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0),
                                blurRadius: 6.0,
                              ),
                            ]),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 200,
                              height: double.infinity,
                              color: Colors.red,
                              alignment: Alignment.center,
                              child: TextFormField(
                                controller: sercontroller,
                                cursorColor: Colors.transparent,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: "Search by genre or by author",
                                  hintStyle: TextStyle(fontFamily: "Baloo"),
                                ),
                              ),
                            ),
                            Text("Hello")
                          ],
                        ))
                  ],
                )));
  }
}
