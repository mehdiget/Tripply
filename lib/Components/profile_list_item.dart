import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;
  final VoidCallback tap;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
    this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialButton(
      child: Container(
        height: size.height * 0.09,
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.00,
        ).copyWith(bottom: size.height * 0.0),
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height * 0.0),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              this.icon,
              size: size.width * 0.07,
              color: Colors.black87,
            ),
            SizedBox(width: size.width * 0.07),
            Text(
              this.text,
              style: TextStyle(
                fontFamily: "Barlow",
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black54,
              ),
            ),
            Spacer(),
            if (this.hasNavigation)
              Icon(
                LineAwesomeIcons.angle_right,
                size: size.width * 0.06,
                color: Colors.black87,
              ),
          ],
        ),
      ),
      onPressed: tap,
    );
  }
}
