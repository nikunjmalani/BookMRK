import 'package:flutter/material.dart';

Widget SearchBar({width, title, onTap}) {
  return Material(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      padding: EdgeInsets.only(left: 5, top: 3),
      height: width / 8,
      width: width,
      decoration: BoxDecoration(
        color: Color(0xfff3f3f3),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TextField(
        onTap: onTap,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: title,
          hintStyle: TextStyle(
            fontFamily: "Roboto",
            fontSize: 18,
            color: Color(0xff515C6F),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff515C6F),
          ),
        ),
      ),
    ),
  );
}
