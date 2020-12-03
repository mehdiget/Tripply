import 'dart:async';
import 'home.dart';
import 'login.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// flutter_tester

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  Future<User> _getUser() async {
    _user = await _auth.currentUser;
    return _user;
  }

  Future startTime() async {
    _user = await _auth.currentUser;
//var _duration = new Duration(seconds: 2);

    return new Timer(Duration(seconds: 5), () {
      if (_user == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) => Login()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage(user: _user)));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    HexColor("#4D7CFE").withOpacity(1),
                    Color(0x5677FA).withOpacity(1)
                  ]),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.location_on,
                          color: HexColor("#4D7CFE"),
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "Tripply",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            fontFamily: "Montserrat"),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Find your Trip",
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                          fontFamily: "Montserrat"),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
