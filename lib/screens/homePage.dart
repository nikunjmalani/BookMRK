import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/Search.dart';
import 'package:bookmrk/screens/Home/allVendors.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/tabs/cart.dart';
import 'package:bookmrk/screens/tabs/category.dart';
import 'package:bookmrk/screens/tabs/home.dart';
import 'package:bookmrk/screens/tabs/notificationPage.dart';
import 'package:bookmrk/screens/tabs/school.dart';
import 'package:bookmrk/screens/tabs/user.dart';
import 'package:bookmrk/widgets/appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'category/categoryInfo.dart';

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
        print(data.selectedBottomIndex);
        return Scaffold(
          appBar: CustomAppBar(
            blueCartIcon: data.blueCartIcon,
            blueBellIcon: data.blueBellIcon,
            onBellTap: () {
              pageController.jumpToPage(5);

              Provider.of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Notifications";
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 5;
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon = false;
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon = true;
            },
            onCartTap: () {
              pageController.jumpToPage(4);

              Provider.of<HomeScreenProvider>(context, listen: false)
                  .selectedString = "Cart";
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .selectedBottomIndex = 4;
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .blueCartIcon = true;
              Provider.of<HomeScreenProvider>(context, listen: false)
                  .blueBellIcon = false;
            },
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
              child: data.selectedBottomIndex == 0 &&
                      data.selectedString == "Home"
                  ? imagePath.logo
                  : data.selectedBottomIndex == 0
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
                      : data.selectedBottomIndex == 1 &&
                                  data.selectedString == "Category" ||
                              data.selectedString == "CategoryInfo" ||
                              data.selectedString == "ProductInfo"
                          ? leadingAppBar(
                              title: data.selectedString == "Category"
                                  ? "Category"
                                  : "",
                              backButton: data.selectedString == "Category"
                                  ? false
                                  : true,
                              onBackTap: () {
                                Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedString =
                                    data.selectedString == "CategoryInfo"
                                        ? "Category"
                                        : "CategoryInfo";
                              })
                          : data.selectedBottomIndex == 2 &&
                                      data.selectedString == "School" ||
                                  data.selectedString == "SchoolInfo"
                              ? leadingAppBar(
                                  title: data.selectedString == "School"
                                      ? "Schools"
                                      : "",
                                  backButton: data.selectedString == "School"
                                      ? false
                                      : true,
                                  onBackTap: () {
                                    Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString =
                                        data.selectedString == "SchoolInfo"
                                            ? "School"
                                            : "School";
                                  },
                                )
                              : data.selectedString == "User"
                                  ? leadingAppBar(
                                      title: data.selectedString == "User"
                                          ? "Account"
                                          : "",
                                      backButton: data.selectedString == "User"
                                          ? false
                                          : true,
                                    )
                                  : data.selectedString == "Cart"
                                      ? leadingAppBar(
                                          backButton: false, title: "Cart")
                                      : leadingAppBar(
                                          backButton: false,
                                          title: "Notifications"),
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
                      data.selectedString == "Category"
                          ? Category()
                          : data.selectedString == "ProductInfo"
                              ? ProductInfo()
                              : CategoryInfo(),
                      data.selectedString == "School" ? School() : SchoolInfo(),
                      User(),
                      Cart(),
                      NotificationPage(),
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
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(35)),
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
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedBottomIndex = 0;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "Home";
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueCartIcon = false;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueBellIcon = false;
                          },
                          child: CircleAvatar(
                            backgroundColor: currentPage == 0
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 13,
                            child: SvgPicture.asset(
                              currentPage == 0
                                  ? "assets/icons/activeHome.svg"
                                  : "assets/icons/Home.svg",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(1);
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedBottomIndex = 1;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "Category";
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueCartIcon = false;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueBellIcon = false;
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
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedBottomIndex = 2;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "School";
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueCartIcon = false;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueBellIcon = false;
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
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedBottomIndex = 3;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "User";
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueCartIcon = false;
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .blueBellIcon = false;
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

Widget leadingAppBar({bool backButton, title, onBackTap}) {
  return Row(
    children: [
      backButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: onBackTap,
              iconSize: 30,
            )
          : SizedBox(),
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 25,
          color: const Color(0xff301869),
        ),
        textAlign: TextAlign.left,
      ),
    ],
  );
}
