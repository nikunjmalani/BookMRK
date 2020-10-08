import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';
import 'onBoarding.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ImagePath imagePath = ImagePath();
  HomeScreenProvider _homeScreenProvider;

  navigateToAnotherScreen() async {
    await Future.delayed(Duration(seconds: 2), () async {
      _homeScreenProvider.selectedString = "Home";
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      bool isLogin = _prefs.getBool("isLogin");
      if (isLogin ?? false) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => OnBoarding()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigateToAnotherScreen();
  }

  @override
  Widget build(BuildContext context) {
    _homeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);
    return Scaffold(
      body: GestureDetector(
        onTap: () async {
//          SharedPreferences _prefs = await SharedPreferences.getInstance();
//          bool isLogin = _prefs.getBool("isLogin");
//          if (isLogin) {
//            Navigator.of(context).pushReplacement(
//                MaterialPageRoute(builder: (context) => HomePage()));
//          } else {
//            Navigator.of(context).pushReplacement(
//                MaterialPageRoute(builder: (context) => OnBoarding()));
//          }
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
