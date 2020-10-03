import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/forgotPassword.dart';
import 'package:bookmrk/screens/homePage.dart';
import 'package:bookmrk/screens/register.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 12, top: 5),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 40,
                color: colorPalette.navyBlue,
                icon: Icon(Icons.clear),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 50),
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 48),
                  child: imagePath.logo,
                )),
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: SimpleTextfield("Mobile Number / Email Address"),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: SuffixTextfield(
                  hintText: "Password",
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: colorPalette.navyBlue,
                  )),
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ForgotPassword())),
              child: Container(
                margin: EdgeInsets.only(right: 50, top: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password",
                  style: TextStyle(color: colorPalette.navyBlue, fontSize: 16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: NavyBlueButton(
                  context: context,
                  onClick: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())),
                  title: "LOGIN"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Register())),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't Have Account?",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: " Register Here",
                        style: TextStyle(
                          fontSize: 16,
                          color: colorPalette.navyBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
