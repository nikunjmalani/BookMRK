import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget Indicators({currentPage}) {
  ColorPalette colorPalette = ColorPalette();

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CircleAvatar(
        radius: 4,
        backgroundColor:
            currentPage == 0 ? colorPalette.navyBlue : colorPalette.orange,
      ),
      SizedBox(
        width: 5,
      ),
      CircleAvatar(
        radius: 4,
        backgroundColor:
            currentPage == 1 ? colorPalette.navyBlue : colorPalette.orange,
      ),
      SizedBox(
        width: 5,
      ),
      CircleAvatar(
        radius: 4,
        backgroundColor:
            currentPage == 2 ? colorPalette.navyBlue : colorPalette.orange,
      ),
    ],
  );
}
