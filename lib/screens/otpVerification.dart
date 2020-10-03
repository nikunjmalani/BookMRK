import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/resetPassword.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OtpVerification extends StatefulWidget {
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
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
                    "OTP Verification",
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
                  OtpBox(context),
                  OtpBox(context),
                  OtpBox(context),
                  OtpBox(context),
                  OtpBox(context),
                  OtpBox(context),
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
              padding: const EdgeInsets.only(
                  left: 40, right: 40, top: 40, bottom: 30),
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
            NavyBlueButton(
                context: context,
                onClick: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ResetPassword())),
                title: "VERIFY")
          ],
        ),
      ),
    );
  }
}
