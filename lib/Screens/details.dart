import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tester/API/DataManager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'map.dart';
import "dart:ui";
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Details extends StatefulWidget {
  String place_ID;
  String place;
  String img;
  String country;
  String desc;
  String way;
  double lat;
  double lng;

  Details({
    this.place_ID,
    this.place,
    this.img,
    this.country,
    this.desc,
    this.way,
    this.lat,
    this.lng,
  });
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  Color _iconColor;
  List favoritePlacesList = [];
  List imagesList = [];
  bool autoPlay = true;

  User user;
  @override
  void initState() {
    super.initState();
    fetchImagesList();
    fetchCurrentUser();
    fetchFavoriteList();
  }

  fetchFavoriteList() async {
    dynamic resultPlaces = await DataManager().getFavoritePlacesList();
    if (resultPlaces == null) {
      print("Unable to favorite asi mehdi");
    } else {
      setState(() {
        favoritePlacesList = resultPlaces;
        if (_iconColor == null) {
          for (int i = 0; i < favoritePlacesList.length; i++) {
            if (favoritePlacesList[i]["place_ID"].contains(widget.place_ID)) {
              _iconColor = Colors.red;
            }
          }
        }
        if (_iconColor != Colors.red) {
          _iconColor = Colors.grey;
        }
      });
    }
  }

  fetchCurrentUser() async {
    final User userX = await DataManager().getCurrentUser();
    setState(() {
      user = userX;
    });
  }

  fetchImagesList() async {
    dynamic resultPlaces =
        await DataManager().getDetailImagesList(widget.place_ID);
    if (resultPlaces == null) {
      print("Unable to load images asi mehdi");
    } else {
      setState(() {
        imagesList = resultPlaces;
        print("able to load images asi mehdi");
        print(imagesList);
        if (imagesList.length == 1) {
          print("FALSE");
          autoPlay = false;
        } else {
          // ignore: unnecessary_statements
          print("TRUE");
          autoPlay = true;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FlutterIcons.arrow_left_fea, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            children: <Widget>[
              Stack(children: [
                Stack(
                  children: [
                    imagesList.isEmpty
                        ? Image.asset("images/assets/placeholder_GIF.gif")
                        : CarouselSlider.builder(
                            itemCount: imagesList.length,
                            options: CarouselOptions(
                              autoPlayInterval: const Duration(seconds: 5),
                              height: size.height * 0.45,
                             
                              viewportFraction: 1,
                              autoPlay: autoPlay,
                            ),
                            itemBuilder: (context, index) {
                              return Stack(children: [
                                Container(
                                  height: size.height * 0.45,
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => new Image
                                            .asset(
                                        "images/assets/placeholder_GIF.gif"),
                                    imageUrl: imagesList[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          HexColor("#2B55F8").withOpacity(0.6),
                                          Colors.white.withOpacity(0)
                                        ]),
                                  ),
                                ),
                              ]);
                            }),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: size.height * 0.38, bottom: size.height * 0.1),
                    child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0,
                                  left: 5.0,
                                  right: 5.0,
                                  bottom: 0.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      width: size.width * 0.6,
                                      padding: EdgeInsets.only(left: 15.0),
                                      child: Text(
                                        widget.place + ", " + widget.country,
                                        style: TextStyle(
                                          fontFamily: "Poppins",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25.0,
                                        ),
                                      )),
                                  // SizedBox(
                                  //   width: 50,
                                  // ),
                                  Container(
                                    width: size.width * 0.33,
                                    alignment: Alignment.topRight,
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            "images/assets/star_fill.svg"),
                                        Text("3.2/5",
                                            style: TextStyle(
                                                fontFamily: "Montserrat")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 2.0),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 7.0),
                                      child: Text(
                                        'Summary',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      widget.place + " " + widget.desc,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: HexColor("#76787C"),
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: 2.0),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        'How to Get There',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                    Text(
                                      widget.place + " " + widget.way,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: HexColor("#76787C"),
                                        fontSize: 16.0,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: 2.0),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 12.0),
                                      child: Text(
                                        'Reviews',
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Card(
                              shadowColor: Colors.transparent,
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      Icons.person,
                                      color: HexColor("#2B55F8"),
                                    ),
                                    title: Container(
                                      child: Text("Hanan",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    subtitle: Text(
                                      "sara7a 3jbni blan o kda o makrhtch tzido developiw hadshi o nshealh twslo li makyna o tl9aw gorlfrand li tbghikom hhhhhhhhhhh",
                                      style: TextStyle(fontFamily: "Poppins"),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        color: HexColor("#2B55F8"),
                                      ),
                                      title: Container(
                                        child: Text("Zineb",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      subtitle: Text(
                                        "sara7a 3jbni blan o kda o makrhtch tzido developiw hadshi o nshealh twslo li makyna o tl9aw gorlfrand li tbghikom hhhhhhhhhhh",
                                        style: TextStyle(fontFamily: "Poppins"),
                                        textAlign: TextAlign.justify,
                                      )),
                                  Divider(
                                    height: 10,
                                  ),
                                  ListTile(
                                      leading: Icon(
                                        Icons.person,
                                        color: HexColor("#2B55F8"),
                                      ),
                                      title: Container(
                                        child: Text("Fatima",
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      subtitle: Text(
                                        "sara7a 3jbni blan o kda o makrhtch tzido developiw hadshi o nshealh twslo li makyna o tl9aw gorlfrand li tbghikom hhhhhhhhhhh",
                                        style: TextStyle(fontFamily: "Poppins"),
                                        textAlign: TextAlign.justify,
                                      )),
                                ],
                              ),
                            )
                          ],
                        )))
              ])
            ],
          ),
        ],
      )),
      bottomSheet: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        height: size.height * 0.083,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: size.width * 0.15,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 1.4,
                  ),
                ),
                height: size.height * 0.065,
                child: GestureDetector(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3.0,
                    child: Container(
                      width: size.width * 0.15,

                      child: IconButton(
                        icon: Icon(FontAwesomeIcons.shareAlt,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {},
                      ),
                      //    onPressed: () {},
                    ),
                  ),
                )),
            SizedBox(
              width: 20,
            ),
            Container(
                width: size.width * 0.15,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    style: BorderStyle.solid,
                    width: 1.4,
                  ),
                ),
                height: size.height * 0.065,
                child: GestureDetector(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3.0,
                    child: Container(
                      width: size.width * 0.15,

                      child: IconButton(
                        icon: Icon(Icons.favorite, color: _iconColor),
                        //favoritePlacesList.contains(widget.place_ID) ?  Icon(Icons.favorite, color: Colors.red)
                        onPressed: () {
                          //we have to add something here
                          try {
                            if (_iconColor == Colors.grey) {
                              DataManager().addPlaceToFavorite(
                                  widget.place_ID, user.uid);
                              setState(() {
                                _iconColor = Colors.red;
                              });
                            } else {
                              DataManager()
                                  .deletePlaceFromFavorite(widget.place_ID);
                              setState(() {
                                _iconColor = Colors.grey;
                              });
                            }
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                      ),
                      // onPressed: () {},
                    ),
                  ),
                )),
            SizedBox(
              width: 30,
            ),
            Container(
                width: 190,
                height: size.height * 0.065,
                child: GestureDetector(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                    elevation: 2.0,
                    child: MaterialButton(
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Row(children: [
                          IconButton(
                            icon: Icon(Icons.location_on, color: Colors.white),
                            onPressed: () {},
                          ),
                          Text(
                            "Find Place",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          )
                        ]),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => new Map(
                                name: widget.place,
                                country: widget.country,
                                img: widget.img,
                                desc: widget.desc,
                                lat: widget.lat,
                                lng: widget.lng)));
                      },
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
