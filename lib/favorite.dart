import 'package:flutter/material.dart';
import 'home.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Favourite",
            style: TextStyle(fontFamily: "Montserrat"),
          ),
          leading: IconButton(
            icon: Icon(FlutterIcons.left_ant, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            color: HexColor("#4D7CFE"),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.11),
                    height: size.height,
                      decoration: BoxDecoration(
                      color: HexColor("#F3F1F7"),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(26),
                        topRight: Radius.circular(26),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: size.height * 0.1,
                    ),
                    // height: 500,
                  
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(children: <Widget>[
                          InkWell(
                              onTap: () {},
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 7),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 10.0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  child: Row(children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 18.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.asset(
                                          "images/slider/fes.jpg",
                                          width: 90.0,
                                          height: 80.0,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Fes",
                                              style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              "Morocco",
                                              style: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.grey),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              "Rating is good",
                                              style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )),
                                  ]),
                                ),
                              )),
                        ]);
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
