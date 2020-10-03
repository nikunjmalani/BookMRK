import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget SimpleTextfield(hintText) {
  ColorPalette colorPalette = ColorPalette();

  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: colorPalette.lightGrey,
        fontSize: 16,
      ),
//      suffixIcon: Icon(
//        Icons.remove_red_eye,
//        color: colorPalette.navyBlue,
//      ),
    ),
  );
}

Widget SuffixTextfield({String hintText, Icon suffixIcon}) {
  ColorPalette colorPalette = ColorPalette();

  return TextField(
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: colorPalette.lightGrey,
        fontSize: 16,
      ),
      suffixIcon: suffixIcon,
    ),
  );
}
