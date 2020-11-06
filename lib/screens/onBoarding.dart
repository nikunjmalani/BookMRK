import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/login.dart';
import 'package:bookmrk/screens/register.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  PageController pageController = PageController(initialPage: 0);
  List images = [
    "assets/images/search_engine.png",
    "assets/images/order_confirmation.png",
    "assets/images/online_payment.png",
  ];
  List description = [
    "Search stationary products from over\n 50000+ products.",
    "Easy to order desire stationary products",
    "Easy payment process, Facility to pay by UPI,\n and Wallet also",
    "On time and fast delivery",
  ];
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 48),
                  child: Image.asset("assets/images/logo.png"),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height / 12,
            ),
            Expanded(
              child: PageView.builder(
                itemCount: images.length + 1,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.20,
                        alignment: Alignment.center,
                        child: index < images.length
                            ? Image.asset(images[index])
                            : Container(
                                height: 250,
                                width: double.infinity,
                                child: Lottie.asset(
                                  "assets/images/dle.json",
                                  fit: BoxFit.fill,
                                  repeat: true,
                                  frameRate: FrameRate.max,
                                ),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 50),
                        child: Text(
                          description[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 18.0, color: Color(0xff9A9696)),
                        ),
                      ),
                    ],
                  );
                },
                scrollDirection: Axis.horizontal,
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 6,
                  backgroundColor: currentPage == 0
                      ? colorPalette.navyBlue
                      : colorPalette.orange,
                ),
                SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: currentPage == 1
                      ? colorPalette.navyBlue
                      : colorPalette.orange,
                ),
                SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: currentPage == 2
                      ? colorPalette.navyBlue
                      : colorPalette.orange,
                ),
                SizedBox(
                  width: 7,
                ),
                CircleAvatar(
                  radius: 6,
                  backgroundColor: currentPage == 3
                      ? colorPalette.navyBlue
                      : colorPalette.orange,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NavyBlueButton(
                      context: context,
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register()));
                      },
                      title: "SIGN UP"),
                  NavyBlueButton(
                      context: context,
                      onClick: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      title: "SIGN IN"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
