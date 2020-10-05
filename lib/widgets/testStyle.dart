import 'package:flutter/material.dart';

Widget HeaderText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 25,
      color: const Color(0xff301869),
    ),
    textAlign: TextAlign.left,
  );
}

Widget Header2(title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 17,
      color: const Color(0xff3a3a3c),
      fontWeight: FontWeight.w700,
    ),
    textAlign: TextAlign.left,
  );
}

Widget title(title) {
  return Container(
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      title,
      style: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 13,
        color: const Color(0xffb7b7b7),
      ),
      textAlign: TextAlign.left,
    ),
  );
}

Widget descrip(title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14,
      color: const Color(0xff000000),
    ),
    textAlign: TextAlign.left,
  );
}

Widget BlueHeader(title) {
  return Text(
    title,
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 20,
      color: const Color(0xff000000),
      fontWeight: FontWeight.w700,
    ),
    textAlign: TextAlign.left,
  );
}
