import 'package:flutter/material.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    required this.icon,
    required this.text,
    this.hasNavigation = true,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.05,
      // margin: EdgeInsets.symmetric(
      //   horizontal: screenWidth * 4,
      // ).copyWith(
      //   bottom: screenHeight * 2,
      // ),
      // padding: EdgeInsets.symmetric(
      //   horizontal: kSpacingUnit.w * 2,
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            // size: kSpacingUnit.w * 2.5,
          ),
          SizedBox(width: 16.0),
          Text(
            this.text,
            // style: kTitleTextStyle.copyWith(
            //   fontWeight: FontWeight.w500,
            // ),
          ),
          Spacer(),
          // if (this.hasNavigation)
          // Icon(
          //   // LineAwesomeIcons.angle_right,
          //   // size: kSpacingUnit.w * 2.5,
          // ),
        ],
      ),
    );
  }
}
