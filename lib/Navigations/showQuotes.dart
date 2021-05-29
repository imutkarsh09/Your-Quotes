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
            appBar: AppBar(),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  page = page + 1;
                  getJsonData();
                });
              },
            ),
            body: Center(
              child: Text(data[0]["quoteText"]),
            ));
  }
}
