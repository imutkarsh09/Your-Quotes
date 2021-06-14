import "package:flutter/material.dart";
import 'package:yourquotes/Moment%20Quotes/moment.dart';

class NoLiked extends StatefulWidget {
  const NoLiked({Key key}) : super(key: key);

  @override
  _NoLikedState createState() => _NoLikedState();
}

class _NoLikedState extends State<NoLiked> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            image: AssetImage("Images/Background_Images/Background_1.jpg"),
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
                      ],
                    )),
              ),
              Container(
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
                        "बहुत तकलीफ होती है... जब आप योग्य हाे लाेग आपकी योग्यता ना पहचाने बहुत तकलीफ होती है.",
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
                          "मुन्‍ना भईया",
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.3),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: []),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) => Moment()));
                    },
                    child: Text(
                      "Read And Like Some Quotes",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 2),
                        fontFamily: "Baloo",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ])
            ],
          ),
        ),
      ],
    ));
  }
}
