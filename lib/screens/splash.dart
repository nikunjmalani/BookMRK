import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/onBoarding.dart';
import 'package:flutter/material.dart';

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
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => OnBoarding())),
        child: Center(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 48),
          child: imagePath.logo,
        )),
      ),
    );
  }
}
