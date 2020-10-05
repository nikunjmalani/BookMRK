import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget NavyBlueButton({BuildContext context, Function onClick, String title}) {
  ColorPalette colorPalette = ColorPalette();
  return GestureDetector(
    onTap: onClick,
    child: Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.width / 8,
      width: MediaQuery.of(context).size.width / 2.4,
      decoration: BoxDecoration(
          color: colorPalette.navyBlue,
          borderRadius: BorderRadius.circular(13)),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    ),
  );
}

Widget ViewAll({onClick}) {
  ColorPalette colorPalette = ColorPalette();
  return GestureDetector(
    onTap: onClick,
    child: Container(
      alignment: Alignment.center,
      height: 25,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: colorPalette.navyBlue,
          width: 1,
        ),
      ),
      child: Text(
        'View All',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 14,
          color: const Color(0xff301869),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}

Widget CategoryButtons(width, title, color, borderColor) {
  ColorPalette colorPalette = ColorPalette();
  return Container(
    margin: EdgeInsets.only(left: 14, top: 15),
    height: width / 8,
    width: width / 3.4,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: color,
      border: Border.all(color: borderColor, width: 5),
    ),
    alignment: Alignment.center,
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 18,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget BlueLongButton({height, title, onTap, color}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        color: color ?? Color(0xff44349A),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 110, left: 25, right: 25),
      height: height / 15,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: const Color(0xffffffff),
          letterSpacing: 0.8999999999999999,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
      alignment: Alignment.center,
    ),
  );
}

Widget BlueOutlineButton({width, onTap, title}) {
  ColorPalette colorPalette = ColorPalette();
  return InkWell(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: width / 15,
      width: width / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: colorPalette.navyBlue,
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: const Color(0xff301868),
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
