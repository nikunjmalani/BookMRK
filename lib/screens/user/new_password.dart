import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          height: 250,
          width: 250,
          child: imagePath.reset,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 52,
            right: 48,
            top: 50,
          ),
          child: Text(
            "Please enter New Password",
            style: TextStyle(
              fontSize: 18,
              color: colorPalette.darkgrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 48, top: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              hintText: "New password",
              hintStyle: TextStyle(
                color: colorPalette.lightGrey,
                fontSize: 16,
              ),
              suffixIcon: Icon(
                Icons.remove_red_eye,
                color: colorPalette.navyBlue,
              ),
            ),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 48, right: 48, top: 20, bottom: 30),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              hintText: "Confirm Password",
              hintStyle: TextStyle(
                color: colorPalette.lightGrey,
                fontSize: 16,
              ),
              suffixIcon: Icon(
                Icons.remove_red_eye,
                color: colorPalette.navyBlue,
              ),
            ),
          ),
        ),
        NavyBlueButton(
            context: context,
            onClick: () => homeProvider.selectedString = "User",
            title: "CHANGE")
      ],
    );
  }
}
