import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Screens/splashscreen.dart';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
    //RenderErrorBox.backgroundColor = Colors.transparent;
    //RenderErrorBox.textStyle = ui.TextStyle(color: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor("#FC3E3F"),
      
      systemNavigationBarDividerColor: Colors.black,
      systemNavigationBarColor: Colors.white70,
      systemNavigationBarIconBrightness: Brightness.dark));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: HexColor("#FC3E3F"),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
