import "package:flutter/material.dart";

class Drawerr extends StatefulWidget {
  @override
  _DrawerrState createState() => _DrawerrState();
}

class _DrawerrState extends State<Drawerr> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Utkarsh Saxena",
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
          liti(
              "Quote Of The Moment",
              Icon(
                Icons.timeline,
                color: Colors.blue,
              )),
          liti(
              "Request Name Change",
              Icon(
                Icons.person,
                color: Colors.blue,
              )),
          liti(
              "Liked Quotes",
              Icon(
                Icons.favorite,
                color: Colors.red,
              )),
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
