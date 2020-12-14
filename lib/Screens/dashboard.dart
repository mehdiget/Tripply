import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'Profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tester/API/DataManager.dart';
import 'package:flutter_tester/Components/StarsWidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'details.dart';
import 'discover.dart';
import 'favorite.dart';
import 'login.dart';
import 'profilex.dart';

class Dashboard extends StatefulWidget {
  final User user;
  Dashboard({this.user});
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
//GifController controller= GifController(vsync: this);

  double Slider_rating;
  int currentIndex;

  List placesList = [];
  List collectionList = [];

  final List<Widget> _pages = [Dashboard(), Favorite(), Profile()];
  final CollectionScroller collectionScroller = CollectionScroller();
  final Category categoryScroller = new Category();
  final LatestPlaces latestPlaces = new LatestPlaces();

  @override
  void initState() {
    super.initState();
   // fetchCurrentUser();
    fetchDatabaseList();
    currentIndex = 0;
  }

  changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  fetchDatabaseList() async {
    dynamic resultPlaces = await DataManager().getTrendingPlacesList();
    if (resultPlaces == null) {
      print("Unable to retrieve asi mehdi");
    } else {
      setState(() {
        placesList = resultPlaces;
        print("able to retrieve data asi mehdi");
      });
    }
  }

  // fetchCurrentUser() async {
  //   final User userX = await DataManager().getCurrentUser();
  //   setState(() {
  //     user = userX;
  //   });
  // }

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
      body: (currentIndex == 0)
          ? SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(children: [
                Container(
                  height: size.height * 0.45,
                  width: size.width,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          placesList.isEmpty
                              ? Image.asset("images/assets/placeholder_GIF.gif")
                              : CarouselSlider.builder(
                                  itemCount: placesList.length,
                                  options: CarouselOptions(
                                    autoPlayInterval:
                                        const Duration(seconds: 6),
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
                                          placeholder: (context, url) => new Image
                                                  .asset(
                                              "images/assets/placeholder_GIF.gif"),
                                          imageUrl: placesList[index]
                                              ['place_image_1'],
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
                                                          top: size.height *
                                                                  0.11 -
                                                              63,
                                                          left: size.width *
                                                              0.03),
                                                      child: Text(
                                                          placesList[index]
                                                              ['place_name'],
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Barlow",
                                                              fontSize: 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                    ),
                                                    Container(
                                                      width: size.width * 0.31,
                                                      padding: EdgeInsets.only(
                                                        top:
                                                            size.height * 0.11 -
                                                                64,
                                                      ),
                                                      child: StarsWidget(
                                                        rating: double.parse(
                                                            placesList[index]
                                                                ['rating']),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                        width: size.width * 0.8,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left:
                                                                    size.width *
                                                                        0.03),
                                                        child: Text(
                                                          "Recommendation",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "Barlow",
                                                              fontSize: 14),
                                                        )),
                                                    Container(
                                                        width: size.width * 0.2,
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10),
                                                        child: RichText(
                                                          text: TextSpan(
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                  text: placesList[
                                                                          index]
                                                                      [
                                                                      'rating'],
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Barlow",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black),
                                                                ),
                                                                TextSpan(
                                                                  text: " (" +
                                                                      placesList[
                                                                              index]
                                                                          [
                                                                          'total_rating'] +
                                                                      ")",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "Barlow",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontSize:
                                                                          13,
                                                                      color: Colors
                                                                          .black),
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
                            padding: EdgeInsets.only(
                                top: size.height * 0.053, left: 20),
                            child: Text(
                                "Hi " + word + ",\nWhere do you want to go ?",
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
                                padding:
                                    EdgeInsets.only(top: size.height * 0.15),
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
                                        padding:
                                            const EdgeInsets.only(left: 14.0),
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 10.0),
                                      Flexible(
                                        child: Theme(
                                          data: ThemeData(
                                              primaryColor: Colors.black),
                                          child: TextField(
                                            cursorColor:
                                                Theme.of(context).accentColor,
                                            decoration:
                                                InputDecoration.collapsed(
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
                SizedBox(
                  height: size.height * 0.025,
                ),
                Container(
                    child: Column(children: [
                  Row(
                    children: [
                      Container(
                          width: size.width * 0.8,
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Text(
                            "Hot Collections",
                            style: TextStyle(
                                fontFamily: "Assistant",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                      width: size.width,
                      height: size.height * 0.2,
                      child: collectionScroller),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                          width: size.width * 0.8,
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Text(
                            "Categories",
                            style: TextStyle(
                                fontFamily: "Assistant",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.010,
                  ),
                  Container(
                      width: size.width,
                      height: size.height * 0.07,
                      child: categoryScroller),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Container(
                          width: size.width * 0.8,
                          padding: EdgeInsets.only(left: size.width * 0.04),
                          child: Text(
                            "Latest Places",
                            style: TextStyle(
                                fontFamily: "Assistant",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          )),
                      Container(
                          width: size.width * 0.2,
                          padding: EdgeInsets.only(left: size.width * 0.07),
                          child: Text(
                            "SEE ALL",
                            style: TextStyle(
                                fontFamily: "Assistant",
                                fontWeight: FontWeight.bold,
                                color: HexColor("#FC3E3F"),
                                fontSize: 12),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.009,
                  ),
                  Container(
                      width: size.width,
                      height: size.height - 250,
                      child: latestPlaces),
                ])),
              ]),
            )
          : (currentIndex == 3)
              ? Profilex(
                  user: widget.user,
                )
              : (currentIndex == 2)
                  ? Favorite()
                  : Discover(),
      //    : Icon(
      //             Icons.access_time,
      //             size: 150.0,
      //             color: Colors.deepPurple,
      //           ),
      bottomNavigationBar: BubbleBottomBar(
        opacity: 0.2,
        backgroundColor: Colors.white,
        currentIndex: currentIndex,
        hasInk: true,
        inkColor: Colors.black12,
        hasNotch: true,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.dashboard,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              title: Text("Home")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.location_on_outlined,
                size: 28,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.location_on_outlined,
                color: Colors.red,
              ),
              title: Text("Discover")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                FontAwesomeIcons.heart,
                color: Colors.black,
              ),
              activeIcon: Icon(
                FontAwesomeIcons.heart,
                color: Colors.red,
              ),
              title: Text("Favorite")),
          BubbleBottomBarItem(
              backgroundColor: Colors.red,
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              activeIcon: Icon(
                Icons.settings,
                color: Colors.red,
              ),
              title: Text("Settings"))
        ],
      ),
    );
  }
}

class CollectionScroller extends StatefulWidget {
  const CollectionScroller();

  @override
  _CollectionScrollerState createState() => _CollectionScrollerState();
}

class _CollectionScrollerState extends State<CollectionScroller> {
  List collectionList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultCollection = await DataManager().getCollectionList();
    if (collectionList == null) {
      print("Unable to retrieve Collection asi mehdi");
    } else {
      setState(() {
        collectionList = resultCollection;
        print("able to retrieve Collection asi mehdi");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double collectionHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: collectionList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            print("Container clicked");
                          },
                          child: Container(
                            width: 140,
                            margin: EdgeInsets.only(right: 20),
                            height: collectionHeight,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withAlpha(90),
                                      blurRadius: 5.0),
                                ],
                                image: new DecorationImage(
                                  image: new CachedNetworkImageProvider(
                                    collectionList[index]['collection_image'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.72),
                                        Colors.white.withOpacity(0.1)
                                      ]),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      collectionList[index]['collection_name'],
                                      // "Most\nFavorites",
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    ]);
  }
}

class Category extends StatefulWidget {
  const Category();
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List CategoryList = [];
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultCollection = await DataManager().getCategoryList();
    if (CategoryList == null) {
      print("Unable to retrieve Collection asi mehdi");
    } else {
      setState(() {
        CategoryList = resultCollection;
        print("able to retrieve Collection asi mehdi");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: Column(children: <Widget>[
      Expanded(
          child: ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
              scrollDirection: Axis.horizontal,
              itemCount: CategoryList.length,
              itemBuilder: (context, index) {
                var CategoryIcon = CategoryList[index]['category_icon'];
                return InkWell(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            print("Container clicked");
                          },
                          child: Container(
                            width: size.width * 0.3,
                            margin: EdgeInsets.only(right: 20),
                            height: size.height * 0.07,
                            decoration: BoxDecoration(
                                color: HexColor(
                                    CategoryList[index]['category_color']),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0))),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Row contents horizontally,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ImageIcon(
                                    NetworkImage(
                                        CategoryList[index]['category_icon']),
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    CategoryList[index]['category_name'],
                                    // "Most\nFavorites",
                                    style: TextStyle(
                                        fontSize: 21,
                                        color: Colors.white,
                                        fontFamily: "Assistant",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    ]));
  }
}

class LatestPlaces extends StatefulWidget {
  const LatestPlaces();
  @override
  _LatestPlacesState createState() => _LatestPlacesState();
}

class _LatestPlacesState extends State<LatestPlaces> {
  List placesList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultPlaces = await DataManager().getPlacesList();
    if (resultPlaces == null) {
      print("Unable to retrieve asi mehdi");
    } else {
      setState(() {
        placesList = resultPlaces;
        print("able to retrieve data asi mehdi");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: <Widget>[
        Expanded(
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(), //<--here
                scrollDirection: Axis.vertical,
                itemCount: placesList.length,
                itemBuilder: (context, index) {
                  return Align(
                    heightFactor: 0.72,
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => new Details(
                                    place_ID: placesList[index]['place_ID'],
                                    place: placesList[index]['place_name'],
                                    img: placesList[index]['place_image_1'],
                                    country: placesList[index]['place_city'],
                                    desc: placesList[index]
                                        ['place_description'],
                                    way: placesList[index]['place_way'],
                                    lat: placesList[index]['place_lat'],
                                    lng: placesList[index]['place_lng'],
                                  )));
                        },
                        child: Container(
                          height: 130,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.0)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withAlpha(80),
                                    blurRadius: 3.0),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 12),
                            child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    placesList[index]['place_image_1'],
                                    width: 90.0,
                                    height: 80.0,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        placesList[index]['place_name'],
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        placesList[index]['place_city'],
                                        style: const TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 17,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                              "images/assets/star_fill.svg"),
                                          Text(
                                            placesList[index]['rating']
                                                .toString(),
                                            style: const TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 24,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                            ]),
                          ),
                        )),
                  );
                }))
      ]),
    );
  }
}
