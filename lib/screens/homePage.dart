import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/search.dart';
import 'package:bookmrk/screens/Home/allVendors.dart';
import 'package:bookmrk/screens/Home/filter.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/cart/addAddress.dart';
import 'package:bookmrk/screens/cart/changeAddress.dart';
import 'package:bookmrk/screens/cart/editAddress.dart';
import 'package:bookmrk/screens/tabs/cart.dart';
import 'package:bookmrk/screens/tabs/category.dart';
import 'package:bookmrk/screens/tabs/home.dart';
import 'package:bookmrk/screens/tabs/notificationPage.dart';
import 'package:bookmrk/screens/tabs/school.dart';
import 'package:bookmrk/screens/tabs/user.dart';
import 'package:bookmrk/screens/user/change_mobilenumber.dart';
import 'package:bookmrk/screens/user/change_password.dart';
import 'package:bookmrk/screens/user/edit_profile.dart';
import 'package:bookmrk/screens/user/feedback.dart';
import 'package:bookmrk/screens/user/my_address.dart';
import 'package:bookmrk/screens/user/my_orders.dart';
import 'package:bookmrk/screens/user/new_password.dart';
import 'package:bookmrk/screens/user/order_details.dart';
import 'package:bookmrk/screens/user/order_traking.dart';
import 'package:bookmrk/screens/user/user_add_address.dart';
import 'package:bookmrk/screens/user/user_edit_address.dart';
import 'package:bookmrk/screens/user/user_otp.dart';
import 'package:bookmrk/screens/user/wishlist.dart';
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
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Scaffold(
          appBar: data.selectedString == "ChangeAddress" ||
                  data.selectedString == "AddAddress" ||
                  data.selectedString == "EditAddress" ||
                  data.selectedString == "SearchProducts" ||
                  data.selectedString == "Filter" ||
                  data.selectedString == "UserEditAddress" ||
                  data.selectedString == "UserAddAddress" ||
                  data.selectedString == "OrderTracking"
              ? SimpleAppBar(
                  actionIcon: data.selectedString == "AddAddress" ||
                          data.selectedString == "EditAddress" ||
                          data.selectedString == "SearchProducts" ||
                          data.selectedString == "Filter" ||
                          data.selectedString == "UserEditAddress" ||
                          data.selectedString == "UserAddAddress" ||
                          data.selectedString == "OrderTracking"
                      ? null
                      : Icons.add,
                  actionTap: () {
                    homeProvider.selectedString =
                        data.selectedString == "ChangeAddress"
                            ? "AddAddress"
                            : "Cart";
                  },
                  context: context,
                  onTap: () {
                    homeProvider.selectedString = data.selectedString ==
                            "AddAddress"
                        ? "ChangeAddress"
                        : data.selectedString == "EditAddress"
                            ? "ChangeAddress"
                            : data.selectedString == "SearchProducts"
                                ? "Home"
                                : data.selectedString == "Filter"
                                    ? "VendorInfo"
                                    : data.selectedString ==
                                                "UserEditAddress" ||
                                            data.selectedString ==
                                                "UserAddAddress"
                                        ? "MyAddress"
                                        : data.selectedString == "OrderTracking"
                                            ? "OrderDetails"
                                            : "Cart";
                  },
                  title: data.selectedString == "SearchProducts"
                      ? "Search Products"
                      : data.selectedString == "Filter"
                          ? "Filter By Categories"
                          : data.selectedString == "UserEditAddress"
                              ? "Edit Address"
                              : data.selectedString == "UserAddAddress"
                                  ? "Add Address"
                                  : data.selectedString == "OrderTracking"
                                      ? "Order Tracking"
                                      : "",
                  icon: Icons.close)
              : CustomAppBar(
                  blueCartIcon: data.blueCartIcon,
                  blueBellIcon: data.blueBellIcon,
                  onBellTap: () {
                    pageController.jumpToPage(5);

                    homeProvider.selectedString = "Notifications";
                    homeProvider.selectedBottomIndex = 5;
                    homeProvider.blueCartIcon = false;
                    homeProvider.blueBellIcon = true;
                  },
                  onCartTap: () {
                    pageController.jumpToPage(4);

                    homeProvider.selectedString = "Cart";
                    homeProvider.selectedBottomIndex = 4;
                    homeProvider.blueCartIcon = true;
                    homeProvider.blueBellIcon = false;
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
                                      homeProvider.selectedString =
                                          data.selectedString == "VendorInfo"
                                              ? "All Vendors"
                                              : data.selectedString ==
                                                          "ProductInfo" ||
                                                      data.selectedString ==
                                                          "SchoolInfo"
                                                  ? "VendorInfo"
                                                  : "Home";
                                    },
                                    iconSize: 30,
                                  ),
                                  Text(
                                    data.selectedString == "VendorInfo"
                                        ? ""
                                        : data.selectedString ==
                                                    "ProductInfo" ||
                                                data.selectedString ==
                                                    "SchoolInfo"
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
                                    backButton:
                                        data.selectedString == "Category"
                                            ? false
                                            : true,
                                    onBackTap: () {
                                      homeProvider.selectedString =
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
                                        backButton:
                                            data.selectedString == "School"
                                                ? false
                                                : true,
                                        onBackTap: () {
                                          homeProvider.selectedString =
                                              data.selectedString ==
                                                      "SchoolInfo"
                                                  ? "School"
                                                  : "School";
                                        },
                                      )
                                    : data.selectedString == "User" ||
                                            data.selectedString ==
                                                "EditProfile" ||
                                            data.selectedString ==
                                                "ChangeMobile" ||
                                            data.selectedString == "UserOTP" ||
                                            data.selectedString == "Wishlist" ||
                                            data.selectedString ==
                                                "MyAddress" ||
                                            data.selectedString == "MyOrders" ||
                                            data.selectedString ==
                                                "OrderDetails" ||
                                            data.selectedString ==
                                                "OrderTracking" ||
                                            data.selectedString ==
                                                "ChangePassword" ||
                                            data.selectedString == "NewPassword" ||
                        data.selectedString ==
                            "FeedBack"
                                        ? leadingAppBar(
                                            title: data.selectedString == "User"
                                                ? "Account"
                                                : data.selectedString ==
                                                        "EditProfile"
                                                    ? "Edit Profile"
                                                    : data.selectedString ==
                                                                "ChangeMobile" ||
                                                            data.selectedString ==
                                                                "UserOTP"
                                                        ? "Change Mobile Number"
                                                        : data.selectedString ==
                                                                "Wishlist"
                                                            ? "Wishlist"
                                                            : data.selectedString ==
                                                                    "MyAddress"
                                                                ? "My Addresses"
                                                                : data.selectedString ==
                                                                            "MyOrders" ||
                                                                        data.selectedString ==
                                                                            "OrderDetails"
                                                                    ? "My Orders"
                                                                    : data.selectedString == "ChangePassword" ||
                                                                            data.selectedString ==
                                                                                "NewPassword"
                                                                        ? "Change Password"
                                                                        : data.selectedString ==
                                                "FeedBack"?"Submit Feedback":"",
                                            backButton:
                                                data.selectedString == "User"
                                                    ? false
                                                    : true,
                                            onBackTap: () {
                                              homeProvider.selectedString = data
                                                          .selectedString ==
                                                      "EditProfile"
                                                  ? "User"
                                                  : data
                                                              .selectedString ==
                                                          "ChangeMobile"
                                                      ? "EditProfile"
                                                      : data.selectedString == "UserOTP"
                                                          ? "ChangeMobile"
                                                          : data.selectedString ==
                                                                      "Wishlist" ||
                                                                  data.selectedString ==
                                                                      "MyAddress" ||
                                                                  data.selectedString ==
                                                                      "MyOrders" ||
                                                                  data.selectedString ==
                                                                      "ChangePassword" ||
                                                                  data.selectedString ==
                                                                      "FeedBack"
                                                              ? "User"
                                                              : data.selectedString ==
                                                                      "OrderDetails"
                                                                  ? "MyOrders"
                                                                  : data.selectedString ==
                                                                          "NewPassword"
                                                                      ? "ChangePassword"
                                                                      : "";
                                            },
                                          )
                                        : data.selectedString == "Cart"
                                            ? leadingAppBar(
                                                backButton: false,
                                                title: "Cart")
                                            : leadingAppBar(
                                                backButton: false,
                                                title: "Notifications"),
                  ),
                ),
          extendBody: true,
          resizeToAvoidBottomInset: false,
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
                                          : data.selectedString == "Filter"
                                              ? Filter()
                                              : data.selectedString == "School"
                                                  ? School()
                                                  : data.selectedString=="Category"&& data.selectedBottomIndex==1?Category():data.selectedString=="CategoryInfo"?CategoryInfo():AllVendors(),
                      data.selectedString == "Category"
                          ? Category()
                          : data.selectedString == "ProductInfo"
                              ? ProductInfo()
                              : CategoryInfo(),
                      data.selectedString == "School" ? School() : SchoolInfo(),
                      data.selectedString == "EditProfile"
                          ? EditProfile()
                          : data.selectedString == "ChangeMobile"
                              ? ChangeMobile()
                              : data.selectedString == "UserOTP"
                                  ? UserOTP()
                                  : data.selectedString == "Wishlist"
                                      ? WishList()
                                      : data.selectedString == "MyAddress"
                                          ? MyAddress()
                                          : data.selectedString ==
                                                  "UserEditAddress"
                                              ? UserEditAddress()
                                              : data.selectedString ==
                                                      "UserAddAddress"
                                                  ? UserAddAddress()
                                                  : data.selectedString ==
                                                          "MyOrders"
                                                      ? MyOrders()
                                                      : data.selectedString ==
                                                              "OrderDetails"
                                                          ? OrderDetails()
                                                          : data.selectedString ==
                                                                  "OrderTracking"
                                                              ? OrderTracking()
                                                              : data.selectedString ==
                                                                      "ChangePassword"
                                                                  ? ChangePassword()
                                                                  : data.selectedString ==
                                                                          "NewPassword"
                                                                      ? NewPassword()
                                                                      : data.selectedString ==
                                                                              "FeedBack"
                                                                          ? FeedBack()
                                                                          : User(),
                      data.selectedString == "Cart"
                          ? Cart()
                          : data.selectedString == "AddAddress"
                              ? AddAddress()
                              : data.selectedString == "EditAddress"
                                  ? EditAddress()
                                  : ChangeAddress(),
                      NotificationPage(),
                    ],
                    onPageChanged: (value) {
                      homeProvider.selectedBottomIndex = value;
                    },
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: data.selectedString == "AddAddress" ||
                          data.selectedString == "EditAddress" ||
                          data.selectedString == "Filter" ||
                          data.selectedString == "UserEditAddress" ||
                          data.selectedString == "UserAddAddress"
                      ? Container(
                          padding: EdgeInsets.only(bottom: 10),
                          alignment: Alignment.center,
                          child: Text(
                            data.selectedString == "EditAddress" ||
                                    data.selectedString == "UserEditAddress"
                                ? "Save Update"
                                : data.selectedString == "Filter"
                                    ? "APPLY"
                                    : 'ADD',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          height: width / 5,
                          color: colorPalette.navyBlue,
                        )
                      : data.selectedString == "ChangeAddress"
                          ? SizedBox()
                          : Container(
                              padding: EdgeInsets.only(bottom: 10),
                              height: 90,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(35)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(1, -2),
                                    blurRadius: 8,
                                    color: Color(0xffE1E1E1),
                                  )
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(0);
                                      homeProvider.selectedBottomIndex = 0;
                                      homeProvider.selectedString = "Home";
                                      homeProvider.blueCartIcon = false;
                                      homeProvider.blueBellIcon = false;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          data.selectedBottomIndex == 0
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                      radius: width / 13,
                                      child: SvgPicture.asset(
                                        data.selectedBottomIndex == 0
                                            ? "assets/icons/activeHome.svg"
                                            : "assets/icons/Home.svg",
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(1);
                                      homeProvider.selectedBottomIndex = 1;
                                      homeProvider.selectedString = "Category";
                                      homeProvider.blueCartIcon = false;
                                      homeProvider.blueBellIcon = false;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          data.selectedBottomIndex == 1
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                      radius: width / 13,
                                      child: SvgPicture.asset(
                                        data.selectedBottomIndex == 1
                                            ? "assets/icons/activeCategory.svg"
                                            : "assets/icons/Category.svg",
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(2);
                                      homeProvider.selectedBottomIndex = 2;
                                      homeProvider.selectedString = "School";
                                      homeProvider.blueCartIcon = false;
                                      homeProvider.blueBellIcon = false;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          data.selectedBottomIndex == 2
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                      radius: width / 13,
                                      child: SvgPicture.asset(
                                        data.selectedBottomIndex == 2
                                            ? "assets/icons/activeSchool.svg"
                                            : "assets/icons/School.svg",
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pageController.jumpToPage(3);
                                      homeProvider.selectedBottomIndex = 3;
                                      homeProvider.selectedString = "User";
                                      homeProvider.blueCartIcon = false;
                                      homeProvider.blueBellIcon = false;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor:
                                          data.selectedBottomIndex == 3
                                              ? colorPalette.orange
                                              : Colors.transparent,
                                      radius: width / 13,
                                      child: SvgPicture.asset(
                                        data.selectedBottomIndex == 3
                                            ? "assets/icons/activeUser.svg"
                                            : "assets/icons/User.svg",
                                        color: data.selectedBottomIndex == 3
                                            ? Colors.black
                                            : null,
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
          fontSize: 20,
          color: const Color(0xff301869),
        ),
        textAlign: TextAlign.left,
      ),
    ],
  );
}
