import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tester/API/DataManager.dart';
import 'package:flutter_tester/Components/profile_list_item.dart';
import 'package:flutter_tester/Screens/dashboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import 'login.dart';

class Profilex extends StatefulWidget {
  final User user;
  Profilex({this.user});
  @override
  _ProfilexState createState() => _ProfilexState();
}

class _ProfilexState extends State<Profilex> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User user;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  fetchCurrentUser() async {
    final User userX = await DataManager().getCurrentUser();
    setState(() {
      user = userX;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: size.height,
            width: size.width,
            color: HexColor("#F1F1F1"),
            child: Stack(
              children: [
                Container(
                  height: size.height * 0.28,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    image: DecorationImage(
                        image: AssetImage('images/assets/Vectoria.png'),
                        fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: size.height * 0.21,
                  left: size.width * 0.049,
                  bottom: size.height * 0.1,
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withAlpha(90),
                                blurRadius: 5.0),
                          ]),
                      width: size.width * 0.9,
                      height: size.height * 0.7,
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.7, top: size.height * 0.03),
                          child: Icon(
                            LineAwesomeIcons.adjust,
                            size: 28,
                            color: Colors.black87,
                          ),
                        ),
                        user == null
                            ? CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              )
                            : Padding(
                                padding:
                                    EdgeInsets.only(top: size.height * 0.03),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 2,
                                        ),
                                        child: Text(
                                          user.displayName,
                                          style: TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                          top: 2,
                                        ),
                                        child: Text(
                                          user.email,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Quicksand',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: size.height,
                                        width: size.width,
                                        child: Column(
                                          children: [
                                            Expanded(
                                                child: ListView(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.04),
                                              children: <Widget>[
                                                ProfileListItem(
                                                  icon: LineAwesomeIcons.edit,
                                                  text: 'Edit Profile',
                                                  tap: () {
                                                    //Just TEST !!!!!!!
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                new Dashboard(
                                                                  user: user,
                                                                )));
                                                  },
                                                ),
                                                ProfileListItem(
                                                  icon: LineAwesomeIcons
                                                      .user_shield,
                                                  text: 'Privacy',
                                                ),
                                                ProfileListItem(
                                                  icon: LineAwesomeIcons
                                                      .user_plus,
                                                  text: 'Invite a Friend',
                                                ),
                                                ProfileListItem(
                                                  icon: LineAwesomeIcons
                                                      .question_circle,
                                                  text: 'Help & Support',
                                                ),
                                                ProfileListItem(
                                                  icon: LineAwesomeIcons
                                                      .alternate_sign_out,
                                                  text: 'Logout',
                                                  tap: () {
                                                    _signOut().whenComplete(() {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Login()));
                                                    });
                                                  },
                                                ),
                                              ],
                                            ))
                                          ],
                                        )),
                                  ],
                                ))
                      ]))),
                ),
                Positioned(
                  top: size.height * 0.11,
                  left: size.width * 0.34,
                  child: Container(
                    child: CircleAvatar(
                      radius: 66,
                      backgroundColor: Colors.black12,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('images/assets/person.jpg'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
