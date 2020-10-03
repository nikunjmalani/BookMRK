import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/screens/otpVerification.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
                    onPressed: () => Navigator.pop(context),
                    iconSize: 40,
                    color: colorPalette.navyBlue,
                    icon: Icon(Icons.arrow_back_ios),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "Forgot Password",
                    style:
                        TextStyle(color: colorPalette.navyBlue, fontSize: 24),
                  ),
                  Spacer(
                    flex: 5,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 50, right: 48, top: 40),
              alignment: Alignment.centerLeft,
              child: Text(
                "Mobile Number",
                style: TextStyle(color: colorPalette.darkgrey, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48, right: 48, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: "Enter Mobile Number",
                  hintStyle: TextStyle(
                    color: colorPalette.lightGrey,
                    fontSize: 16,
                  ),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "+91",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 48, right: 48),
              child: Text(
                "We will send verification code on entered mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(color: colorPalette.darkgrey, fontSize: 13.9),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: NavyBlueButton(
                  context: context,
                  onClick: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OtpVerification())),
                  title: "NEXT"),
            )
          ],
        ),
      ),
    );
  }
}
