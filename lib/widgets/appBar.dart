import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget CustomAppBar(
    {width, imagePath, colorPalette, child, color, bool whiteIcon}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.5,
    backgroundColor: color,
    flexibleSpace: Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 35),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 8,
          color: Color(0xff676767).withOpacity(0.05),
        ),
      ], color: color),
      child: Row(
        children: [
          child,
          Spacer(),
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                child: SvgPicture.asset(
                  "assets/icons/Cart.svg",
                  height: 30,
                  width: 30,
                  color: whiteIcon == true ? Colors.white : null,
                ),
                radius: 25,
                backgroundColor: Colors.transparent,
              ),
              CircleAvatar(
                radius: 10,
                child: Text(
                  '3',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                ),
                backgroundColor: colorPalette.pinkOrange,
              )
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Stack(
            alignment: Alignment.topRight,
            children: [
              CircleAvatar(
                child: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  height: 30,
                  width: 30,
                  color: whiteIcon == true ? Colors.white : null,
                ),
                radius: 25,
                backgroundColor: Colors.transparent,
              ),
              CircleAvatar(
                radius: 10,
                child: Text(
                  '8',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 13,
                    color: const Color(0xffffffff),
                  ),
                  textAlign: TextAlign.left,
                ),
                backgroundColor: colorPalette.pinkOrange,
              )
            ],
          ),
        ],
      ),
    ),
  );
}

Widget SimpleAppBar({context, onTap, title, icon}) {
  ColorPalette colorPalette = ColorPalette();

  return Container(
    alignment: Alignment.centerLeft,
    padding: EdgeInsets.only(left: 12, top: 5, right: 12),
    child: Row(
      children: [
        IconButton(
          onPressed: onTap,
          iconSize: 40,
          color: colorPalette.navyBlue,
          icon: Icon(icon),
        ),
        Spacer(
          flex: 3,
        ),
        Text(
          title,
          style: TextStyle(color: colorPalette.navyBlue, fontSize: 24),
        ),
        Spacer(
          flex: 6,
        ),
      ],
    ),
  );
}

Widget PurpleAppBar(context, color) {
  ColorPalette colorPalette = ColorPalette();

  return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 8,
        color: Color(0xff676767).withOpacity(0.05),
      ),
    ], color: color),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Provider.of<HomeScreenProvider>(context, listen: false)
                .selectedString = "Home";
          },
          iconSize: 30,
        ),
        Spacer(),
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                "assets/icons/Cart.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              radius: 25,
              backgroundColor: Colors.transparent,
            ),
            CircleAvatar(
              radius: 10,
              child: Text(
                '3',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: colorPalette.pinkOrange,
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                "assets/icons/bell.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              radius: 25,
              backgroundColor: Colors.transparent,
            ),
            CircleAvatar(
              radius: 10,
              child: Text(
                '8',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: colorPalette.pinkOrange,
            )
          ],
        ),
      ],
    ),
  );
}
