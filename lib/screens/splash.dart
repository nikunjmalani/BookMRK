import 'package:bookmrk/res/images.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ImagePath imagePath = ImagePath();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          SharedPreferences _prefs = await SharedPreferences.getInstance();
          bool isLogin = _prefs.getBool("isLogin");
          if (isLogin) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => OnBoarding()));
          }
        },
        child: Center(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 48),
          child: imagePath.logo,
        )),
      ),
    );
  }
}
