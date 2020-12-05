import 'dart:ui';
import 'Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tester/API/DataManager.dart';
import 'package:flutter_tester/Components/StarsWidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Dashboard extends StatefulWidget {
  final User user;
  Dashboard({this.user});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double Slider_rating = 3.5;
  List placesList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultPlaces = await DataManager().getTrendingPlacesList();
    if (resultPlaces == null) {
      print("Unable to retrieve asi mehdi");
    } else {
      setState(() {
        print("able to retrieve data asi mehdi");
        placesList = resultPlaces;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String str = widget.user.displayName;
    var arr = [];
    arr = str.split(" ");
    String word = arr[0];
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            height: size.height * 0.45,
            width: size.width,
            child: Column(
              children: [
                Stack(
                  children: [
                    CarouselSlider.builder(
                        itemCount: placesList.length,
                        options: CarouselOptions(
                          autoPlayInterval: const Duration(seconds: 6),
                          height: size.height * 0.45,
                          // enlargeCenterPage: true,
                          viewportFraction: 1,
                          autoPlay: true,
                        ),
                        itemBuilder: (context, index) {
                          return Stack(children: [
                            Container(
                              height: size.height * 0.45,
                              child: CachedNetworkImage(
                                imageUrl: placesList[index]['place_image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                child: Container(
                                  height: size.height * 0.11,
                                  width: size.width,
                                  color: Colors.white60,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: size.width * 0.685,
                                            padding: EdgeInsets.only(
                                                top: size.height * 0.11 - 63,
                                                left: size.width * 0.03),
                                            child: Text(
                                                placesList[index]['place_name'],
                                                style: TextStyle(
                                                    fontFamily: "Barlow",
                                                    fontSize: 19,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                          Container(
                                            width: size.width * 0.31,
                                            padding: EdgeInsets.only(
                                              top: size.height * 0.11 - 64,
                                            ),
                                            child: StarsWidget(
                                              rating: Slider_rating,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              width: size.width * 0.8,
                                              padding: EdgeInsets.only(
                                                  left: size.width * 0.03),
                                              child: Text(
                                                "Recommendation",
                                                style: TextStyle(
                                                    fontFamily: "Barlow",
                                                    fontSize: 14),
                                              )),
                                          Container(
                                              width: size.width * 0.2,
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: RichText(
                                                text: TextSpan(children: <
                                                    TextSpan>[
                                                  TextSpan(
                                                    text: placesList[index]
                                                        ['rating'],
                                                    style: TextStyle(
                                                        fontFamily: "Barlow",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15,
                                                        color: Colors.black),
                                                  ),
                                                  TextSpan(
                                                    text: " (" +
                                                        placesList[index]
                                                            ['total_rating'] +
                                                        ")",
                                                    style: TextStyle(
                                                        fontFamily: "Barlow",
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 13,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ]);
                        }),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.only(top: size.height * 0.053, left: 20),
                      child: Text("Hi " + word + ",\nWhere do you want to go ?",
                          style: TextStyle(
                            fontFamily: "Barlow",
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(0.0, 2.0),
                                blurRadius: 25.0,
                                color: Colors.black,
                              ),
                            ],
                          )),
                    ),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.only(top: size.height * 0.15),
                          child: Container(
                            height: 50.0,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(
                              color: Colors.white60,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Flexible(
                                  child: Theme(
                                    data: ThemeData(primaryColor: Colors.black),
                                    child: TextField(
                                      cursorColor:
                                          Theme.of(context).accentColor,
                                      decoration: InputDecoration.collapsed(
                                        hintText: 'Search for a trip',
                                        hintStyle: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
          // Had Container how li fih content li mor ta7t container fo9ani
          Container(
              child: Column(children: [
            Text("****", style: TextStyle(fontSize: 50)),
            Text("Scroll", style: TextStyle(fontSize: 50)),
            Text("is", style: TextStyle(fontSize: 50)),
            Text("Working", style: TextStyle(fontSize: 50)),
            Text("****", style: TextStyle(fontSize: 50)),
            IconButton(
              icon: new Icon(Icons.person, color: HexColor("FC3E3F")),
              iconSize: 50,
              onPressed: () {
            Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Profile(user: widget.user)));

              },
            ),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
            Text("data", style: TextStyle(fontSize: 50)),
          ]))
        ])));
  }
}
