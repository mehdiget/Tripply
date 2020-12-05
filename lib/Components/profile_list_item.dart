import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      child : Container (
      height: size.height * 0.07,
      margin: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
      ).copyWith(bottom: size.height * 0.022),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.5),
        color: Colors.black12,
      ),
      child: Row(
        children: <Widget>[
          Icon(this.icon, size: size.width * 0.07),
          SizedBox(width: size.width * 0.07),
          Text(
            this.text,
            style: TextStyle(
              fontFamily: "Barlow",
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              LineAwesomeIcons.angle_right,
              size: size.width * 0.06,
            ),
        ],
      ),
    ),
    onPressed: tap,
    );
  }
}
