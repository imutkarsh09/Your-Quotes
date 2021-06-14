import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Moment%20Quotes/moment.dart';
import 'package:yourquotes/Name%20Change/nachequote.dart';
import 'package:yourquotes/Shared%20Preferences/showliked.dart';

class Drawerr extends StatefulWidget {
  final String name;
  Drawerr({
    this.name,
  });
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    print("Name Recieved Here is---->");
    print(widget.name);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              widget.name,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Baloo",
                fontSize: 25,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
            arrowColor: Colors.red,
            currentAccountPicture: CircleAvatar(
              radius: 16.0,
              child: ClipRRect(
                child: Image.asset('Images/User_Images/User.png'),
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Request Random Quotes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Baloo",
              ),
            ),
            leading: Icon(
              Icons.format_quote_sharp,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Moment()));
            },
          ),
          ListTile(
            title: Text(
              "Liked Quotes",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Baloo",
              ),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ShowLiked()));
            },
          ),
          ListTile(
            title: Text(
              "Request Name Change",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: "Baloo",
              ),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => NacheQuote()));
            },
          )
        ],
      ),
    );
  }

  Widget liti(String text, Icon ico) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: "Baloo",
        ),
      ),
      leading: ico,
      onTap: () {},
    );
  }
}
