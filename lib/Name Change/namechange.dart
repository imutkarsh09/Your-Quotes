import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yourquotes/Navigations/home.dart';

class NameChange extends StatefulWidget {
  const NameChange({Key key}) : super(key: key);

  @override
  _NameChangeState createState() => _NameChangeState();
}

class _NameChangeState extends State<NameChange> {
  String _name;
  int width;
  TextEditingController name = new TextEditingController();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    const color1 = const Color.fromRGBO(15, 12, 41, 1);
    const color2 = const Color.fromRGBO(30, 94, 152, 1);
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color1, color2])),
          ),
          SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
              // color: Colors.red,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width / 11,
                        30,
                        MediaQuery.of(context).size.width / 11,
                        0),
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    // color: Colors.green,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          "Please Enter Your New Requested Name",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Baloo",
                              color: Colors.white,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 20,
                          width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          width: double.infinity,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: TextFormField(
                                // textAlignVertical: TextAlignVertical.center,
                                textAlign: TextAlign.center,
                                controller: name,
                                cursorColor: Colors.white,
                                onEditingComplete: () {
                                  if (name.text != "") {
                                    saveData();
                                  }
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Baloo",
                                  fontSize: 25,
                                ),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                  ),
                  // Text("hello"),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(70),
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(3.0, 3.0),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ),
                        ]),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_right_alt,
                        size: 50,
                      ),
                      color: Colors.blue,
                      onPressed: () {
                        print("Button is Pressed");
                        if (name.text != "") {
                          saveData();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  Future<bool> saveData() async {
    print("Saved Name is--->");
    print(name.text);
    sharedPreferences.setString("user", name.text);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => Home()));
  }
}
