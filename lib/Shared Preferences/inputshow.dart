import 'dart:convert';

import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'liked.dart';

class InputShow extends StatefulWidget {
  InputShow({Key key}) : super(key: key);

  @override
  _InputShowState createState() => _InputShowState();
}

class _InputShowState extends State<InputShow>
    with SingleTickerProviderStateMixin {
  List<Liked> list = new List<Liked>();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    loadSharedPreferencesAndData();
  }

  loadSharedPreferencesAndData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: list.isEmpty ? emptyList() : buildListView(),
    );
  }

  Widget emptyList() {
    return Center(child: Text('No items'));
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(list[index], index);
      },
    );
  }

  Widget buildItem(Liked item, index) {
    return Dismissible(
      key: Key('${item.hashCode}'),
      background: Container(color: Colors.red[700]),
      // onDismissed: (direction) => removeItem(item),
      direction: DismissDirection.startToEnd,
      child: buildListTile(item, index),
    );
  }

  Widget buildListTile(Liked item, int index) {
    // print(item.completed);
    return ListTile(
      // onTap: () => changeItemCompleteness(item),
      // onLongPress: () => goToEditItemView(item),
      title: Text(
        item.quote,
        key: Key('item-$index'),
        style: TextStyle(
            color: true ? Colors.grey : Colors.black,
            decoration: true ? TextDecoration.lineThrough : null),
      ),
      trailing: Icon(
        true ? Icons.check_box : Icons.check_box_outline_blank,
        key: Key('completed-icon-$index'),
      ),
    );
  }

  Future<List<Liked>> loadData() async {
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
}
