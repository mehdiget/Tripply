import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Screens/details.dart';
import 'Screens/Login.dart';
import 'Screens/favorite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'API/DataManager.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  MyHomePage({this.user});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  final SearchVX searchVX = SearchVX();

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List placesList = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  fetchDatabaseList() async {
    dynamic resultPlaces = await DataManager().getPlacesList();
    if (resultPlaces == null) {
      print("Unable to retrieve asi mehdi");
    } else {
      setState(() {
        print("able to retrieve asi mehdi");
        placesList = resultPlaces;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor("#3352A9"),
    ));
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.35;
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Color(0x1D39A9).withOpacity(1),
                        Color(0x5677FA).withOpacity(1)
                      ]),
                ),
                accountName: Text(widget.user.displayName),
                accountEmail: Text(widget.user.email),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    widget.user.displayName[0].toUpperCase(),
                    style: TextStyle(
                        fontSize: 40.0,
                        fontFamily: "Montserrat",
                        color: Colors.blueAccent[700]),
                  ),
                ),
              ),
              ListTile(
                title: Text("Dashboard"),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text("Favourite"),
                leading: Icon(Icons.favorite),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Favorite()));
                },
              ),
              ListTile(
                title: Text("Settings"),
                leading: Icon(Icons.settings),
              ),
              Divider(color: Colors.blue),
              ListTile(
                title: Text("Log out"),
                leading: Icon(Icons.exit_to_app),
                onTap: () {
                  _signOut().whenComplete(() {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  });
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: new Text(
            "Tripply",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: new IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            color: Colors.black,
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 7.0),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer ? 0 : 1,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  width: size.width,
                  alignment: Alignment.topCenter,
                  height: closeTopContainer ? 0 : categoryHeight,
                  child: categoriesScroller,
                ),
              ),
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        'All Trips',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          controller: controller,
                          physics: new BouncingScrollPhysics(),
                          itemCount: placesList.length,
                          itemBuilder: (context, index) {
                            double scale = 1.0;
                            if (topContainer > 0.5) {
                              scale = index + 0.5 - topContainer;
                              if (scale < 0) {
                                scale = 0;
                              } else if (scale > 1) {
                                scale = 1;
                              }
                            }
                            return Column(children: <Widget>[
                              Opacity(
                                opacity: scale,
                                child: Transform(
                                  transform: Matrix4.identity()
                                    ..scale(scale, scale),
                                  alignment: Alignment.bottomCenter,
                                  child: Align(
                                    heightFactor: 0.7,
                                    alignment: Alignment.topCenter,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Details(
                                                      place: placesList[index]
                                                          ['place_name'],
                                                      img: placesList[index]
                                                          ['place_image'],
                                                      country: placesList[index]
                                                          ['place_city'],
                                                      desc: placesList[index]
                                                          ['place_description'],
                                                      way: placesList[index]
                                                          ['place_way'],
                                                      lat: placesList[index]
                                                          ['place_lat'],
                                                      lng: placesList[index]
                                                          ['place_lng'])));
                                        },
                                        child: Container(
                                          height: 130,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 18, vertical: 7),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black
                                                        .withAlpha(100),
                                                    blurRadius: 7.0),
                                              ]),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 12),
                                            child: Row(children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 18.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    placesList[index]
                                                        ['place_image'],
                                                    width: 90.0,
                                                    height: 80.0,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        placesList[index]
                                                            ['place_name'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        placesList[index]
                                                            ['place_city'],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Montserrat',
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
                                                            placesList[index]
                                                                    ['rating']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Montserrat',
                                                                fontSize: 24,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  )),
                                            ]),
                                          ),
                                        )),
                                  ),
                                ),
                              )
                            ]);
                          }),
                    ),
                  ])),
            ],
          ),
        ),
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}

class SearchVX extends StatelessWidget {
  const SearchVX();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width - 30,
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(15.0),
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
                  cursorColor: Theme.of(context).accentColor,
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
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    var CategoryGallery = [
      {
        'name': 'Most Favorites',
        'count': '20 Items',
        'image': 'images/slider/fes.jpg'
      },
      {
        'name': 'Trending',
        'count': '20 Items',
        'image': 'images/slider/morocco.jpeg'
      },
      {
        'name': 'Coming Soon',
        'count': '10 Items',
        'image': 'images/slider/shop3.jpg'
      },
    ];

    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Column(children: <Widget>[
      SearchVX(),
      Expanded(
          child: ListView.builder(
              physics: new BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              scrollDirection: Axis.horizontal,
              itemCount: CategoryGallery.length,
              itemBuilder: (context, index) {
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20);
                return InkWell(
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                      child: Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              print("Container clicked");
                            },
                            child: Container(
                              width: 140,
                              margin: EdgeInsets.only(right: 20),
                              height: categoryHeight,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withAlpha(100),
                                        blurRadius: 10.0),
                                  ],
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                      CategoryGallery[index]['image'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0))),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.7),
                                          Colors.white.withOpacity(0.1)
                                        ]),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        CategoryGallery[index]['name'],
                                        // "Most\nFavorites",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        CategoryGallery[index]['count'],
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.white),
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
                  ),
                );
              })),
    ]);
  }
}
