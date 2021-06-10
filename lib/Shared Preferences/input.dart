import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Shared%20Preferences/inputshow.dart';
import 'liked.dart';

class Input extends StatefulWidget {
  Input({Key key}) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> with SingleTickerProviderStateMixin {
  // ignore: deprecated_member_use
  List<Liked> list = new List<Liked>();
  SharedPreferences sharedPreferences;
  // SharedPreferences preferences = PreferenceManager.getDefaultSharedPreferences(this);

  @override
  void initState() {
    loadSharedPreferencesAndData();
    super.initState();
  }

  loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _id = new TextEditingController();
    TextEditingController _quo = new TextEditingController();
    TextEditingController _aut = new TextEditingController();

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 150,
              child: TextFormField(
                controller: _id,
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: TextFormField(
                controller: _quo,
              ),
            ),
            Container(
              height: 50,
              width: 150,
              child: TextFormField(
                controller: _aut,
              ),
            ),
            FlatButton(
              color: Colors.blue,
              onPressed: () {
                print(_id.text);
                print(_quo.text);
                print(_aut.text);
                addItem(
                    Liked(id: _id.text, quote: _quo.text, author: _aut.text));
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => InputShow()));
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }

  void addItem(Liked item) {
    list.insert(0, item);
    saveData();
  }

  Future<bool> saveData() async {
    print("List is----->");
    print(list);
    List<String> stringList =
        list.map((item) => json.encode(item.toMap())).toList();
    sharedPreferences.setStringList('list', stringList);
    print("Hello Babuji");
    print(stringList);
    // sharedPreferences.commit();
    print("Jai Shree Ram!!");
    print(sharedPreferences.commit());
  }
}
