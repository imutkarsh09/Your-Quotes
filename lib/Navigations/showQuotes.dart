import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:yourquotes/Loaders/loading.dart';

class ShowQuotes extends StatefulWidget {
  final String genre;
  final String author;
  // receive data from the FirstScreen as a parameter
  ShowQuotes({
    this.genre,
    this.author,
  });
  @override
  _ShowQuotesState createState() => _ShowQuotesState();
}

class _ShowQuotesState extends State<ShowQuotes> {
  int page = 1;
  List data = [];

  @override
  void initState() {
    getJsonData();
    super.initState();
  }

  Future<String> getJsonData() async {
    final String url =
        "https://quote-garden.herokuapp.com/api/v3/quotes?page=$page&&limit=1&&genre=${widget.genre}&&author=${widget.author}";
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    print("Response Code ${response.statusCode}");
    print("Genre---> ${widget.genre}");
    print("Author----> ${widget.author}");
    print("Data Length-->${data.length}");
    if (response.statusCode == 7) {
      print("No Internet");
    }
    print("Page Is-----> $page");
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson["data"];
      print("Data is--->");
      print(data);
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return data.length == 0
        ? Loader()
        : Scaffold(
            // appBar: AppBar(),
            body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(
                      Colors.black.withOpacity(0.9), BlendMode.dstATop),
                  image: AssetImage("Images/Background_Images/Background.jpg"),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.red,
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                          height: 40,
                          width: double.infinity,
                          color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      width: double.infinity,
                      color: Colors.blue,
                      child: Wrap(
                        children: [
                          Text(
                            data[0]["quoteText"],
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Baloo",
                              fontSize: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          onPressed: () {
                            page = page + 1;
                            getJsonData();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            if (page > 1) {
                              page = page - 1;
                              getJsonData();
                            }
                          },
                          icon: Icon(Icons.arrow_right),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
  }
}
