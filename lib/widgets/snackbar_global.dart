import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

ColorPalette colorPalette = ColorPalette();
Widget getSnackBar(String msg) {
  return SnackBar(
    content: Text(
      '$msg',
      style: TextStyle(color: Colors.white, fontSize: 16.0),
    ),
    backgroundColor: colorPalette.navyBlue,
    duration: Duration(seconds: 2),
  );
}
