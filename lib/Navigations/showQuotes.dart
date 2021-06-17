import 'dart:math';

import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Loaders/loading.dart';
import 'package:yourquotes/Shared%20Preferences/liked.dart';

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
  int r = 1;
  bool _isLiked = false;
  List data = [];
  List<Liked> list = new List<Liked>();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    loadSharedPreferencesAndData();
    getJsonData();
    super.initState();
  }

  loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadDataHere();
  }

  Future<List<Liked>> loadDataHere() async {
    print("Load Data Called");
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      setState(() {
        print("Inside the set state");
        list =
            listString.map((item) => Liked.fromMap(json.decode(item))).toList();
      });
      print("I am here");
      print(list);
    }
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
      Random rnd = new Random();
      int min = 1;
      int max = 6;
      r = min + rnd.nextInt(max - min);
      print("r is----->$r");
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    print("r here is--->$r");
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
                  image:
                      AssetImage("Images/Background_Images/Background_$r.jpg"),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                // color: Colors.red,
                child: Column(
                  children: [
                    SafeArea(
                      child: Container(
                          height: 40,
                          width: double.infinity,
                          // color: Colors.yellow,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: IconButton(
                              alignment: Alignment.centerLeft,
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          )),
                    ),
                    InkWell(
                      onDoubleTap: () {
                        setState(() {
                          _isLiked = !_isLiked;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.4,
                        width: double.infinity,
                        // color: Colors.blue,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                data[0]["quoteText"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Baloo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Text(
                                  data[0]["quoteAuthor"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Baloo",
                                      fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(
                                  Icons.arrow_left,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              onTap: () {
                                if (page > 1) {
                                  page = page - 1;
                                  _isLiked = false;
                                  getJsonData();
                                }
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: _isLiked
                                    ? Icon(Icons.favorite,
                                        color: Colors.red, size: 25)
                                    : Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                              ),
                              onTap: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                  print("Liked Ho Gaya shayad");
                                  print(_isLiked);
                                  if (_isLiked == true) {
                                    addItem(Liked(
                                        quote: data[0]["quoteText"],
                                        author: data[0]["quoteAuthor"]));
                                  } else {
                                    removeItem();
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.share_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                              onTap: () {
                                String msg = data[0]["quoteText"].toString();
                                share(context, msg);
                              },
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.transparent, // button color
                            child: InkWell(
                              splashColor: Colors.white, // inkwell color
                              child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 40,
                                  )),
                              onTap: () {
                                // if (_isLiked == true) {
                                //   addItem(Liked(
                                //       quote: data[0]["quoteText"],
                                //       author: data[0]["quoteAuthor"]));
                                // }
                                page = page + 1;
                                _isLiked = false;
                                getJsonData();
                              },
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ));
  }

  share(BuildContext context, String msg) {
    final RenderBox box = context.findRenderObject();

    Share.share("$msg",
        subject: "Quote",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void addItem(Liked item) {
    print("add item called");
    list.insert(0, item);
    saveData();
  }

  void removeItem() {
    print("Remove Item is Called");
    // print();
    list.removeAt(0);
    saveData();
  }

  Future<bool> saveData() async {
    print("List is----->");
    print(list);
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
    print(stringList);
    loadDataHere();
  }
}
