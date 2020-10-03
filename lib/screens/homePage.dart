import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/Search.dart';
import 'package:bookmrk/screens/Home/allVendors.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/tabs/category.dart';
import 'package:bookmrk/screens/tabs/home.dart';
import 'package:bookmrk/screens/tabs/school.dart';
import 'package:bookmrk/screens/tabs/user.dart';
import 'package:bookmrk/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController(initialPage: 0);
  int currentPage = 0;
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: CustomAppBar(
            whiteIcon: data.selectedString == "VendorInfo" ? true : false,
            color: data.selectedString == "VendorInfo"
                ? colorPalette.purple
                : Colors.white,
            width: width,
            imagePath: imagePath,
            colorPalette: colorPalette,
            child: Container(
              height: width / 6,
              width: width / 2,
              child: data.selectedString == "Home"
                  ? imagePath.logo
                  : currentPage == 1
                      ? Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: data.selectedString == "VendorInfo"
                                    ? Colors.white
                                    : colorPalette.navyBlue,
                              ),
                              onPressed: () {
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .selectedString = data.selectedString ==
                                        "VendorInfo"
                                    ? "All Vendors"
                                    : data.selectedString == "ProductInfo" ||
                                            data.selectedString == "SchoolInfo"
                                        ? "VendorInfo"
                                        : "Home";
                              },
                              iconSize: 30,
                            ),
                            Text(
                              data.selectedString == "VendorInfo"
                                  ? ""
                                  : data.selectedString == "ProductInfo" ||
                                          data.selectedString == "SchoolInfo"
                                      ? ""
                                      : 'All Vendors',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 25,
                                color: const Color(0xff301869),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        )
                      : Icon(Icons.add),
            ),
          ),
          extendBody: true,
          body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Container(
                  child: PageView(
                    controller: pageController,
                    children: [
                      data.selectedString == "Home"
                          ? Home()
                          : data.selectedString == "SearchProducts"
                              ? Search()
                              : data.selectedString == "VendorInfo"
                                  ? VendorsInfo()
                                  : data.selectedString == "ProductInfo"
                                      ? ProductInfo()
                                      : data.selectedString == "SchoolInfo"
                                          ? SchoolInfo()
                                          : AllVendors(),
                      Category(),
                      School(),
                      User(),
                      AllVendors(),
                    ],
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    },
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 10),
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(1, -2),
                          blurRadius: 8,
                          color: Color(0xffE1E1E1),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(0);
                          },
                          child: CircleAvatar(
                            backgroundColor:
                                currentPage == 0 || currentPage == 4
                                    ? colorPalette.orange
                                    : Colors.transparent,
                            radius: width / 13,
                            child: SvgPicture.asset(
                              currentPage == 0 || currentPage == 4
                                  ? "assets/icons/activeHome.svg"
                                  : "assets/icons/Home.svg",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(1);
                          },
                          child: CircleAvatar(
                            backgroundColor: currentPage == 1
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 13,
                            child: SvgPicture.asset(
                              currentPage == 1
                                  ? "assets/icons/activeCategory.svg"
                                  : "assets/icons/Category.svg",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(2);
                          },
                          child: CircleAvatar(
                            backgroundColor: currentPage == 2
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 13,
                            child: SvgPicture.asset(
                              currentPage == 2
                                  ? "assets/icons/activeSchool.svg"
                                  : "assets/icons/School.svg",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(3);
                          },
                          child: CircleAvatar(
                            backgroundColor: currentPage == 3
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 13,
                            child: SvgPicture.asset(
                              currentPage == 3
                                  ? "assets/icons/activeUser.svg"
                                  : "assets/icons/User.svg",
                              color: currentPage == 3 ? Colors.black : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
