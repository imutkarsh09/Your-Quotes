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
            body: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        // color: Colors.yellow,
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      // color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: Text(
                          "All Genres",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Baloo",
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        // color: Colors.yellow,
                        child: Wrap(
                            alignment: WrapAlignment.spaceEvenly,
                            children: List.generate(data.length, (index) {
                              String gen = data[index];
                              gen = gen[0].toUpperCase() + gen.substring(1);

                              return Container(
                                height: 125,
                                width: 110,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0),
                                        blurRadius: 6.0,
                                      ),
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        ShowQuotes(
                                                            genre: data[index],
                                                            author: "")));
                                      },
                                      child: Container(
                                        height: 85,
                                        width: 85,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image(
                                            image: AssetImage(
                                                "Images/Background_Images/Background_4.jpg"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      gen,
                                      style: TextStyle(
                                        fontFamily: "Baloo",
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }))),
                  ],
                ),
              ),
            ),
          );
  }
}
