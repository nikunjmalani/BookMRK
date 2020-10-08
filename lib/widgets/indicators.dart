import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget Indicators({currentPage, pages}) {
  ColorPalette colorPalette = ColorPalette();

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      pages,
      (index) => Row(
        children: [
          CircleAvatar(
            radius: 4,
            backgroundColor: currentPage == index
                ? colorPalette.navyBlue
                : colorPalette.orange,
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    ),
  );
}
