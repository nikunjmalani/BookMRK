import 'dart:async';

import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/images.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

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
      prefs = GetStorage();
      _homeScreenProvider.selectedString = "Home";
      bool isLogin = prefs.read<bool>("isLogin");
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
    Timer.periodic(Duration(seconds: 10), (timer) {
      _homeScreenProvider.getNotification();
      _homeScreenProvider.getCartCount();
    });
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
