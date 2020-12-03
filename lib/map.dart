import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Map extends StatefulWidget {
  String name;
  String country;
  String img;
  String desc;
  double lat;
  double lng;
  Map(
      {this.name,
      this.country,
      this.img,
      this.desc,
      @required this.lat,
      @required this.lng});

  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
  PageController _pageController;
  MapType _currentMapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    List<Marker> allMarkers = [
      Marker(
          markerId: MarkerId('FirstMarker'),
          position: LatLng(widget.lat, widget.lng),
          infoWindow: InfoWindow(title: widget.name, snippet: widget.country))
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 10,
        title: Text("Map",
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
            )),
        centerTitle: true,
      ),
      body: Stack(children: <Widget>[
        Container(
          child: widget.lat == ""
              ? Text(
                  "Sorry, No Location Found",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              : GoogleMap(
                  markers: Set.from(allMarkers),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(widget.lat, widget.lng),
                    zoom: 12.0,
                  ),
                  mapType: _currentMapType,
                ),
        ),
        Positioned(
          bottom: 35.0,
          child: Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return _coffeeShopList();
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                button(_onMapTypeButtonPressed, Icons.map),
                SizedBox(
                  height: 16.0,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget button(Function function, IconData icon) {
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: HexColor("#2B55F8"),
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  _coffeeShopList() {
    return InkWell(
        onTap: () {
          // moveCamera();
        },
        child: Stack(children: [
          Center(
              child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  height: 90.0,
                  width: 275.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 10.0,
                        ),
                      ]),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: Row(children: [
                        Container(
                            height: 90.0,
                            width: 90.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    topLeft: Radius.circular(10.0)),
                                image: DecorationImage(
                                    image: AssetImage(widget.img),
                                    fit: BoxFit.cover))),
                        SizedBox(width: 5.0),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.name,
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.country,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              Container(
                                width: 170.0,
                                child: Text(
                                  widget.desc,
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ])
                      ])))),
        ]));
  }
}
