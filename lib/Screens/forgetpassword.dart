import 'package:hexcolor/hexcolor.dart';

import 'dashboard.dart';
import 'login.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => new _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: 355,
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("images/assets/colonia.png"))),
                ),
                Positioned(
                  height: size.height * 0.33,
                  width: size.width * 0.68,
                  top: 100,
                  left: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("images/assets/forgetting.png"))),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: size.height * 0.05 , left: size.width *0.05 , right: size.width *0.05),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                ),
                SizedBox(height: size.height * 0.08),
                Container(
                  height:size.height * 0.06,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new Dashboard()));
                    },
                    child: Material(
                      borderRadius: BorderRadius.circular(20),
                      shadowColor: HexColor("#FC3E3F"),
                      color: HexColor("#FC3E3F"),
                      elevation: 3.0,
                      child: Center(
                        child: Text(
                          "Send Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.025),
                Container(
                  height: size.height * 0.06,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor("#FC3E3F"),
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => new Login()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Icon(
                                Icons.arrow_back,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Center(
                              child: Text(
                                "BACK",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
