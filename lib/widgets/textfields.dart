import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget SimpleTextfield(hintText,
    {TextEditingController controller, Function validator}) {
  ColorPalette colorPalette = ColorPalette();

  if (validator == null) {
    validator = (value) {
      if (value == "" || value == null) {
        return "Please Fill $hintText";
      } else {
        return null;
      }
    };
  }

  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      hintText: hintText,
      errorStyle: TextStyle(
        color: Colors.red,
      ),
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

Widget SuffixTextfield({
  String hintText,
  Widget suffixIcon,
  TextEditingController controller,
  bool obscureText,
  Function validator,
}) {
  ColorPalette colorPalette = ColorPalette();


  if (validator == null) {
    validator = (value) {
      if (value == "" || value == null) {
        return "Please Fill $hintText";
      } else {
        return null;
      }
    };
  }

  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: obscureText,
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
