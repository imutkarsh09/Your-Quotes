import 'dart:convert';
import 'dart:math';

import "package:flutter/material.dart";
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Loaders/loading.dart';

import 'liked.dart';
import 'noLiked.dart';

class ShowLiked extends StatefulWidget {
  ShowLiked({Key key}) : super(key: key);

  @override
  _ShowLikedState createState() => _ShowLikedState();
}

class _ShowLikedState extends State<ShowLiked> {
  List<Liked> list = new List<Liked>();
  int page = 0;
  bool _isLiked = true;
  int r = 1;
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

  Future<List<Liked>> loadData() async {
    List<String> listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      setState(() {
        print("Inside the set state");
        list =
            listString.map((item) => Liked.fromMap(json.decode(item))).toList();
        _isLiked = true;
      });
      print("Length of list is---->");
      print(list.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Color> coList = [
      Color.fromRGBO(15, 12, 41, 1),
      Color.fromRGBO(30, 94, 152, 1)
    ];
    print("IsLiked------>");
    print(_isLiked);
    return list.length == 0
        ? NoLiked()
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  "Your Liked Quotes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Baloo",
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
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
                                list[page].quote,
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
                                  list[page].author,
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
                                if (page > 0) {
                                  if (_isLiked == false) {
                                    // removeItem(page);
                                  } else {
                                    _isLiked = true;
                                    setState(() {
                                      r = getRandom();
                                      page = page - 1;
                                    });
                                  }
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
                                  if (_isLiked == true) {
                                    addItem(
                                        Liked(
                                            quote: list[page].quote,
                                            author: list[page].author),
                                        page);
                                  } else {
                                    removeItem(page);
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
                                String msg = list[page].quote.toString();
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
                                print("On Tap Pressed and isLiked");
                                print(_isLiked);
                                if (_isLiked == false) {
                                  print("IsLiked is False");
                                  // removeItem(page);
                                } else if (page < list.length - 1) {
                                  print(page);
                                  print(list.length);
                                  _isLiked = true;
                                  setState(() {
                                    r = getRandom();
                                    page = page + 1;
                                  });
                                }
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

  int getRandom() {
    Random rnd = new Random();
    int min = 1;
    int max = 6;
    int r = min + rnd.nextInt(max - min);
    return r;
  }

  void removeItem(int index) {
    print("Remove Item is Called");
    print(index);
    if (list.length == 2) {
      setState(() {
        page = 0;
      });
    }
    list.removeAt(index);
    saveData();
  }

  void addItem(Liked item, int page) {
    list.insert(page, item);
    saveData();
  }

  Future<bool> saveData() async {
    print("List is----->");
    print(list);
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
    print(stringList);
    loadData();
  }
}
