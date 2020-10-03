import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchoolInfo extends StatefulWidget {
  @override
  _SchoolInfoState createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  PageController pageController = PageController(initialPage: 1);
  ColorPalette colorPalette = ColorPalette();
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Column(
          children: [
            Stack(
              children: [
                Container(
                  height: height / 5,
                  child: PageView.builder(
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    controller: pageController,
                    itemBuilder: (context, index) {
                      return Container(
                        height: height / 5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/schoolImage.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: 3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 7,
            ),
            Indicators(currentPage: currentPage),
            SizedBox(
              height: 10,
            ),
            BlueHeader("Central Public School"),
            SizedBox(
              height: 5,
            ),
            descrip("Adarsh Nagar, Lucknow, 457854"),
            SizedBox(
              height: 20,
            ),
            Container(
              height: height / 24,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == 0
                          ? colorPalette.navyBlue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    margin: EdgeInsets.only(
                      left: 10,
                    ),
                    height: 25,
                    width: 100,
                    child: Text(
                      'Grade ${index + 1}',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color:
                            index == 0 ? Color(0xffffffff) : Color(0xff727C8E),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  );
                },
                itemCount: 6,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                children: [
                  Text(
                    'Available Products ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 16,
                      color: const Color(0xffb7b7b7),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: () {},
                      child:
                          _tabs(title: "Products", color: Color(0xffb7b7b7))),
                  SizedBox(
                    width: 5,
                  ),
                  _tabs(title: "Kits", color: colorPalette.navyBlue),
                ],
              ),
            ),
            Container(
                height: height / 2.7,
                width: width,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedString = "ProductInfo";
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: ProductBox(
                          expanded: false,
                          height: height,
                          width: width,
                          title: "Circle Pencil Sharpner",
                          image: "assets/images/Sharpner.png",
                          description: "By Circle Enterprise",
                          price: 10,
                        ),
                      ),
                    );
                  },
                )),
          ],
        );
      },
    );
  }
}

Widget _tabs({title, color}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: color,
        ),
        textAlign: TextAlign.left,
      ),
    ],
  );
}
