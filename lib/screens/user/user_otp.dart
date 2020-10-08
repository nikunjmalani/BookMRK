import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';

class UserOTP extends StatefulWidget {
  @override
  _UserOTPState createState() => _UserOTPState();
}

class _UserOTPState extends State<UserOTP> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40),
          height: 250,
          width: 250,
          child: imagePath.otp,
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 52,
            right: 48,
            top: 50,
          ),
          child: Text(
            "Please enter verification code",
            style: TextStyle(
              fontSize: 18,
              color: colorPalette.darkgrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 48, right: 48, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
//              OtpBox(context),
//              OtpBox(context),
//              OtpBox(context),
//              OtpBox(context),
//              OtpBox(context),
//              OtpBox(context),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, top: 20),
          child: Text(
            "We have sent verification code on registered mobile number",
            textAlign: TextAlign.center,
            style: TextStyle(color: colorPalette.midGrey, fontSize: 13.6),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 30),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Resend code",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPalette.navyBlue,
                  ),
                ),
                TextSpan(
                  text: " 00:00",
                  style: TextStyle(
                    fontSize: 18,
                    color: colorPalette.midGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
        NavyBlueButton(context: context, onClick: () {}, title: "VERIFY")
      ],
    );
  }
}
