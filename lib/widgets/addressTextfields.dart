import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget AddressTextFields({width, title, suffixIcon, prefixIcon, controller, readOnly = false}) {
  ColorPalette colorPalette = ColorPalette();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 13,
          color: const Color(0x80515c6f),
          letterSpacing: 0.9100000000000001,
        ),
        textAlign: TextAlign.left,
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        width: width,
        child: TextField(
          readOnly: readOnly,
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints.tight(Size.square(35)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
            ),
            hintText: "Enter $title",
            hintStyle: TextStyle(
              color: colorPalette.lightGrey,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ],
  );
}
