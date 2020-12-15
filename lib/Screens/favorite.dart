import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tester/API/DataManager.dart';
import 'package:flutter_tester/Components/StarsWidget.dart';
import 'dashboard.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';

import 'details.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  AnimationController _animationController;
  AnimationController _animationDeleteController;

  List favoritePlaces = [];

  Color _colorHeart = Colors.red;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 850));

    Timer(Duration(milliseconds: 200), () => _animationController.forward());

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchDatabaseList();
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  fetchDatabaseList() async {
    dynamic resultPlaces = await DataManager().getFavoriteScreenPlacesList();
    if (resultPlaces == null) {
    } else {
      setState(() {
        favoritePlaces = resultPlaces;
      });
    }
  }

  Tween<Offset> _offset = Tween(begin: Offset(3, 0), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: HexColor("#F1F1F1"),
          title: Text('Favorites',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Assistant",
                fontSize: 21,
                fontWeight: FontWeight.bold,
              )),
        ),
        body: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: HexColor("#F1F1F1"),
                child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: size.height * 0.02),
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
                                  cursorColor: Theme.of(context).accentColor,
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Search',
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
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: favoritePlaces.isEmpty
                          ? Padding(
                              padding:
                                  EdgeInsets.only(bottom: size.height * 0.3),
                              child: Image.asset("images/assets/loading3.gif"),
                            )
                          : AnimatedList(
                              key: _key,
                              initialItemCount: favoritePlaces.length,
                              itemBuilder: (context, index, animation) {
                                return _buildItem(
                                    context, _animationController, index);
                              })),
                ]))));
  }

  Widget _buildItem(BuildContext item, Animation animation, int index) {
    Size size = MediaQuery.of(context).size;

    return SlideTransition(
        position: animation.drive(_offset),
        child: SlideTransition(
            position: _animationController.drive(_offset),
            //  scale: _animationController,
            // alignment: _animationController,
            // sizeFactor: animation,
            // opacity: _animationController,
            child: Align(
                heightFactor: 1.1,
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new Details(
                                place_ID: favoritePlaces[index]['place_ID'],
                                place: favoritePlaces[index]['place_name'],
                                img: favoritePlaces[index]['place_image_1'],
                                country: favoritePlaces[index]['place_city'],
                                desc: favoritePlaces[index]
                                    ['place_description'],
                                way: favoritePlaces[index]['place_way'],
                                lat: favoritePlaces[index]['place_lat'],
                                lng: favoritePlaces[index]['place_lng'],
                              )));
                    },
                    child: Container(
                      height: size.height * 0.15,
                      width: size.width * 0.88,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: size.width * 0.04),
                              child: Container(
                                  height: size.height * 0.10,
                                  width: size.width * 0.23,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        favoritePlaces[index]['place_image_1'],
                                        fit: BoxFit.fill,
                                      )))),
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width * 0.03,
                                top: size.height * 0.022),
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(
                                        top: size.height * 0.007),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          favoritePlaces[index]["place_name"],
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontFamily: "Barlow",
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              height: size.height * 0.019,
                                              width: size.width * 0.32,
                                              child: StarsWidget(
                                                  rating: double.parse(
                                                      favoritePlaces[index]
                                                          ["rating"])),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: size.height * 0.012),
                                              child: Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.08,
                                                child: Text(
                                                  favoritePlaces[index]
                                                      ["rating"],
                                                  style: TextStyle(
                                                      fontFamily: "Barlow",
                                                      fontSize: 17,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: size.width * 0.04, bottom: 1),
                              child: Container(
                                child: IconButton(
                                  icon: new Icon(
                                    FlutterIcons.heart_ant,
                                    color: _colorHeart,
                                  ),
                                  color: Colors.red,
                                  onPressed: () {
                                    DataManager().deletePlaceFromFavorite(
                                        favoritePlaces[index]["place_ID"]);
                                    _removeSingleItems(index);
                                  },
                                ),
                              ))
                        ],
                      ),
                    )))));
  }

  void _removeSingleItems(int indexToRemove) {
    if (indexToRemove != favoritePlaces.length - 1) {
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        return _buildItem(context, animation, indexToRemove);
      };
      favoritePlaces.removeAt(indexToRemove);
      _key.currentState.removeItem(indexToRemove, builder);
    } else {
      AnimatedListRemovedItemBuilder builder = (context, animation) {
        return _buildItem(context, animation, indexToRemove);
      };
      _key.currentState.removeItem(indexToRemove, builder);
    }
  }
}
