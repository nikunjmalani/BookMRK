import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/onBoarding.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  ImagePath imagePath = ImagePath();
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 12, top: 5, right: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    iconSize: 40,
                    color: colorPalette.navyBlue,
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Reset Password",
                    style:
                        TextStyle(color: colorPalette.navyBlue, fontSize: 24),
                  ),
                  Spacer(
                    flex: 6,
                  ),
                ],
              ),
            ),
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
              padding: const EdgeInsets.only(
                  left: 48, right: 48, top: 20, bottom: 30),
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
                onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OnBoarding())),
                title: "RESET")
          ],
        ),
      ),
    );
  }
}
