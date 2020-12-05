import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:developer';
import '../Components/profile_list_item.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dashboard.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({this.user});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScreenUtil.init(context, allowFontScaling: true);

    var profileInfo = Expanded(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.13,
            width: size.width * 0.24,
            margin: EdgeInsets.only(top: size.height * 0.03),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: size.width * 0.3,
                  backgroundImage: NetworkImage(
                      'https://i.pinimg.com/564x/53/66/38/536638de9f4d90ef23e8b51a36546968.jpg'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: size.height * 0.05,
                    width: size.width * 0.06,
                    decoration: BoxDecoration(
                      color: HexColor("#FC3E3F"),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        FlutterIcons.edit_ent,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Text(widget.user.displayName,
              style: TextStyle(
                fontFamily: "Barlow",
                fontWeight: FontWeight.w600,
              )),
          SizedBox(height: size.height * 0.009),
          Text(
            widget.user.email,
            style: TextStyle(
              fontFamily: "Barlow",
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * 0.025),
          Container(
            height: size.height * 0.05,
            width: size.height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * 0.05),
              color: HexColor("#FC3E3F"),
            ),
            child: Center(
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    var header = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        profileInfo,
      ],
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FlutterIcons.left_ant,
            color: Colors.black,
            size: size.width * 0.06,
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Dashboard(user: widget.user,))),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: size.height * 0.05),
          header,
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: size.height * 0.05),
              children: <Widget>[
                ProfileListItem(
                  icon: LineAwesomeIcons.user_shield,
                  text: 'Privacy',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.history,
                  text: 'Purchase History',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.question_circle,
                  text: 'Help & Support',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.cog,
                  text: 'Settings',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.user_plus,
                  text: 'Invite a Friend',
                ),
                ProfileListItem(
                  icon: LineAwesomeIcons.alternate_sign_out,
                  text: 'Logout',
                  tap: () {
                    _signOut().whenComplete(() {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                  hasNavigation: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future _signOut() async {
    await _auth.signOut();
  }
}
