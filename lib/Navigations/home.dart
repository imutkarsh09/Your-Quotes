import 'dart:convert';
import 'dart:math';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Loaders/loading.dart';
import 'package:yourquotes/Navigations/allauthors.dart';
import 'package:yourquotes/Navigations/allgenres.dart';
import 'package:yourquotes/Navigations/drawer.dart';
import 'package:yourquotes/Navigations/showQuotes.dart';
import "package:yourquotes/Searching/search.dart";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String urlgenre = "https://quote-garden.herokuapp.com/api/v3/genres";
  final String urlauthor = "https://quote-garden.herokuapp.com/api/v3/authors";
  List genredata = [];
  List authordata = [];
  String _name;
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    loadDataAndSharedPrefereces();
    getGenreData();
    getAuthorData();
  }

  loadDataAndSharedPrefereces() async {
    sharedPreferences = await SharedPreferences.getInstance();
    String naam = sharedPreferences.getString("user");
    setState(() {
      print("Name is------>");
      print(naam);
      _name = naam;
    });
  }

  Future<String> getGenreData() async {
    var response = await http.get(
      Uri.parse(urlgenre),
      headers: {"Accept": "application/json"},
    );
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      genredata = convertDataToJson["data"];
    });
    return "Success";
  }

  Future<String> getAuthorData() async {
    var response = await http.get(
      Uri.parse(urlauthor),
      headers: {"Accept": "application/json"},
    );
    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      authordata = convertDataToJson["data"];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    Random rnd = new Random();
    int min = 1;
    int max = 6;
    int r = min + rnd.nextInt(max - min);
    TextEditingController sercontroller = new TextEditingController();
    GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
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
    return authordata.length == 0
        ? Loader()
        : Scaffold(
            key: _scaffoldState,
            drawer: Drawerr(name: _name),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      // height: MediaQuery.of(context).size.height / 2.5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Image(
                              image:
                                  AssetImage("Images/Home_Image/Home_$r.jpg"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Column(children: [
                          Container(
                            child: Container(
                              height: 50,
                              width: 350,
                              margin: EdgeInsets.fromLTRB(
                                  MediaQuery.of(context).size.width / 15,
                                  45,
                                  MediaQuery.of(context).size.width / 15,
                                  0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: IconButton(
                                        icon: Icon(Icons.menu),
                                        onPressed: () {
                                          _scaffoldState.currentState
                                              .openDrawer();
                                        }),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: 230,
                                    // color: Colors.blue,
                                    child: TextFormField(
                                      onEditingComplete: () {
                                        print(sercontroller.text);
                                        // search(sercontroller.text);
                                        print("hello bhaiya yahan hai hum");
                                        print(genredata.runtimeType);
                                        String gen_here =
                                            sercontroller.text.toLowerCase();
                                        bool gen =
                                            binary_Search(genredata, gen_here);
                                        String aut_here = convertToTitleCase(
                                            sercontroller.text.toLowerCase());
                                        print("Auth Here---->$aut_here");
                                        bool aut =
                                            binary_Search(authordata, aut_here);
                                        if (gen == true) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ShowQuotes(
                                                              author: "",
                                                              genre:
                                                                  sercontroller
                                                                      .text)));
                                        } else if (aut == true) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ShowQuotes(
                                                              author:
                                                                  sercontroller
                                                                      .text,
                                                              genre: "")));
                                        } else {
                                          showAlertDialog(context);
                                        }
                                      },
                                      controller: sercontroller,
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          hintText:
                                              "Search By Genre Or By Author",
                                          hintStyle: TextStyle(
                                            color: Colors.grey[600],
                                            fontFamily: "Baloo",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          )),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 0),
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.search_outlined,
                                          size: 30,
                                          color: Colors.grey[700],
                                        ),
                                        onPressed: () {
                                          print(sercontroller.text);
                                          // search(sercontroller.text);
                                          print("hello bhaiya yahan hai hum");
                                          print(genredata.runtimeType);
                                          String gen_here =
                                              sercontroller.text.toLowerCase();
                                          bool gen = binary_Search(
                                              genredata, gen_here);
                                          String aut_here = convertToTitleCase(
                                              sercontroller.text.toLowerCase());
                                          print("Auth Here---->$aut_here");
                                          bool aut = binary_Search(
                                              authordata, aut_here);
                                          if (gen == true) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ShowQuotes(
                                                            author: "",
                                                            genre: sercontroller
                                                                .text)));
                                          } else if (aut == true) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        ShowQuotes(
                                                            author:
                                                                sercontroller
                                                                    .text,
                                                            genre: "")));
                                          } else {
                                            showAlertDialog(context);
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // Container(
                          //     height: 50,
                          //     width: double.infinity,
                          //     color: Colors.red,
                          //     padding: EdgeInsets.only(top: 5, bottom: 5),
                          //     child: Center(
                          //       child: Text(
                          //         "Quote Of The Moment",
                          //         style: TextStyle(
                          //           color: Colors.white,
                          //           fontSize: 30,
                          //           fontFamily: "Baloo",
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     )),
                          // Padding(
                          //   padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                          //   child: Container(
                          //     // color: Colors.yellow,
                          //     child: Wrap(
                          //       // alignment: WrapAlignment.center,
                          //       children: [
                          //         Padding(
                          //           padding: const EdgeInsets.only(bottom: 25),
                          //           child: Text(
                          //             data[0]["quoteText"],
                          //             textAlign: TextAlign.center,
                          //             style: TextStyle(
                          //               color: Colors.white,
                          //               fontFamily: "Baloo",
                          //               fontSize: 20,
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ]),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  ShowQuotes(
                                                      genre: "",
                                                      author: trendauthors[
                                                          index])));
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Please enter correct author or genre."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String convertToTitleCase(String text) {
    if (text == null) {
      return null;
    }

    if (text.length <= 1) {
      return text.toUpperCase();
    }

    // Split string into multiple words
    final List<dynamic> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      }
      return '';
    });

    // Join/Merge all words back to one String
    return capitalizedWords.join(' ');
  }
}
