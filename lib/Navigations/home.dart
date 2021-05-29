import 'dart:convert';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:yourquotes/Loaders/loading.dart';
import 'package:yourquotes/Navigations/allauthors.dart';
import 'package:yourquotes/Navigations/allgenres.dart';
import 'package:yourquotes/Navigations/showQuotes.dart';

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
    TextEditingController sercontroller = new TextEditingController();
    List trendgenres = [
      "attitude",
      "beauty",
      "education",
      "fitness",
      "inspirational",
      "relationship"
    ];
    List trendauthors = [
      "Abdul Kalam",
      "Albert Einstein",
      "Bill Gates",
      "Charles Dickens",
      "Jackie Chan",
      "Jeff Bezos"
    ];
    return data.length == 0
        ? Loader()
        : Scaffold(
            body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Column(children: [
                      Container(
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(40, 40, 40, 0),
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
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: double.infinity,
                                width: 260,
                                child: TextFormField(
                                  controller: sercontroller,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "Search By Genre Or By Author",
                                      hintStyle: TextStyle(
                                        color: Colors.grey[600],
                                        fontFamily: "Baloo",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      )),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.search_outlined,
                                    size: 30,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    print(sercontroller.text);
                                  })
                            ],
                          ),
                        ),
                      ),
                      Container(
                          height: 50,
                          width: double.infinity,
                          // color: Colors.red,
                          padding: EdgeInsets.only(top: 5, bottom: 5),
                          child: Center(
                            child: Text(
                              "Quote Of The Day",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontFamily: "Baloo",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: Container(
                          // color: Colors.yellow,
                          child: Wrap(
                            // alignment: WrapAlignment.center,
                            children: [
                              Text(
                                data[0]["quoteText"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Baloo",
                                  fontSize: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Trending Genres",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Baloo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Genres()));
                        },
                        child: Text(
                          "See More",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Baloo",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    width: double.infinity,
                    // color: Colors.yellow,
                    child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          String gen = trendgenres[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ShowQuotes(
                                                    genre: trendgenres[index],
                                                    author: "")));
                                  },
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image(
                                        image: AssetImage(
                                            "Images/Genre_Images/${trendgenres[index]}.jpg"),
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
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "Trending Authors",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Baloo",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => Authors()));
                        },
                        child: Text(
                          "See More",
                          style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Baloo",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                    width: double.infinity,
                    // color: Colors.yellow,
                    child: Wrap(
                        alignment: WrapAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          String gen = trendauthors[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ShowQuotes(
                                                    genre: "",
                                                    author:
                                                        trendauthors[index])));
                                  },
                                  child: Container(
                                    height: 85,
                                    width: 85,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image(
                                        image: AssetImage(
                                            "Images/Author_Images/${trendauthors[index]}.jpg"),
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
          ));
  }
}
