import 'dart:convert';
import "dart:core";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:yourquotes/Loaders/loading.dart';
import 'package:yourquotes/Navigations/showQuotes.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  final String url = "https://quote-garden.herokuapp.com/api/v3/genres";
  List data = [];
  @override
  void initState() {
    getJsonData();
    super.initState();
  }

  Future<String> getJsonData() async {
    var response = await http.get(
      Uri.parse(url),
      headers: {"Accept": "application/json"},
    );
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson["data"];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return data.length == 0
        ? Loader()
        : Scaffold(
            appBar: AppBar(),
            body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Center(
                      child: Column(
                    children: [
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => ShowQuotes(
                                    author: "", genre: data[index])));
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Text(data[index]),
                          ),
                        ),
                      )
                    ],
                  )),
                );
              },
            ));
  }
}
