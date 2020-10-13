import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/allVendors.dart';
import 'package:bookmrk/screens/Home/filter.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/search.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/cart/addAddress.dart';
import 'package:bookmrk/screens/cart/changeAddress.dart';
import 'package:bookmrk/screens/cart/editAddress.dart';
import 'package:bookmrk/screens/tabs/cart.dart';
import 'package:bookmrk/screens/tabs/category_tab.dart';
import 'package:bookmrk/screens/tabs/home.dart';
import 'package:bookmrk/screens/tabs/notificationPage.dart';
import 'package:bookmrk/screens/tabs/school_tab.dart';
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
  HomeScreenProvider _setHomeScreenProvider;


  @override
  Widget build(BuildContext context) {
    _setHomeScreenProvider =
        Provider.of<HomeScreenProvider>(context, listen: false);

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;

    return Consumer<HomeScreenProvider>(
      builder: (context, _homeScreenProvider, child) {
        return Scaffold(
          appBar: _homeScreenProvider.selectedString ==
              "ChangeAddress" ||
              _homeScreenProvider.selectedString == "AddAddress" ||
              _homeScreenProvider.selectedString == "EditAddress" ||
              _homeScreenProvider.selectedString == "SearchProducts" ||
              _homeScreenProvider.selectedString == "Filter" ||
              _homeScreenProvider.selectedString == "UserEditAddress" ||
              _homeScreenProvider.selectedString == "UserAddAddress" ||
              _homeScreenProvider.selectedString == "OrderTracking"
              ? SimpleAppBar(
              actionIcon: _homeScreenProvider.selectedString ==
                  "AddAddress" ||
                  _homeScreenProvider.selectedString == "EditAddress" ||
                  _homeScreenProvider.selectedString ==
                      "SearchProducts" ||
                  _homeScreenProvider.selectedString == "Filter" ||
                  _homeScreenProvider.selectedString ==
                      "UserEditAddress" ||
                  _homeScreenProvider.selectedString ==
                      "UserAddAddress" ||
                  _homeScreenProvider.selectedString == "OrderTracking"
                  ? null
                  : Icons.add,
              actionTap: () {
                _setHomeScreenProvider.selectedString =
                _homeScreenProvider.selectedString == "ChangeAddress"
                    ? "AddAddress"
                    : "Cart";
              },
              context: context,
              onTap: () {
                _setHomeScreenProvider.selectedString =
                _homeScreenProvider.selectedString ==
                    "AddAddress"
                    ? "ChangeAddress"
                    : _homeScreenProvider.selectedString ==
                    "EditAddress"
                    ? "ChangeAddress"
                    : _homeScreenProvider.selectedString ==
                    "SearchProducts"
                    ? "Home"
                    : _homeScreenProvider.selectedString == "Filter"
                    ? "VendorInfo"
                    : _homeScreenProvider.selectedString ==
                    "UserEditAddress" ||
                    _homeScreenProvider.selectedString ==
                        "UserAddAddress"
                    ? "MyAddress"
                    : _homeScreenProvider.selectedString ==
                    "OrderTracking"
                    ? "OrderDetails"
                    : "Cart";
              },
              title: _homeScreenProvider.selectedString ==
                  "SearchProducts"
                  ? "Search Products"
                  : _homeScreenProvider.selectedString == "Filter"
                  ? "Filter By Categories"
                  : _homeScreenProvider.selectedString ==
                  "UserEditAddress"
                  ? "Edit Address"
                  : _homeScreenProvider.selectedString ==
                  "UserAddAddress"
                  ? "Add Address"
                  : _homeScreenProvider.selectedString ==
                  "OrderTracking"
                  ? "Order Tracking"
                  : "",
              icon: Icons.close)
              : CustomAppBar(
            blueCartIcon: _homeScreenProvider.blueCartIcon,
            blueBellIcon: _homeScreenProvider.blueBellIcon,
            onBellTap: () {
              pageController.jumpToPage(5);

              _setHomeScreenProvider.selectedString = "Notifications";
              _setHomeScreenProvider.selectedBottomIndex = 5;
              _setHomeScreenProvider.blueCartIcon = false;
              _setHomeScreenProvider.blueBellIcon = true;
            },
            onCartTap: () {
              pageController.jumpToPage(4);

              _setHomeScreenProvider.selectedString = "Cart";
              _setHomeScreenProvider.selectedBottomIndex = 4;
              _setHomeScreenProvider.blueCartIcon = true;
              _setHomeScreenProvider.blueBellIcon = false;
            },
            whiteIcon: _homeScreenProvider.selectedString ==
                "VendorInfo" ? true : false,
            color: _homeScreenProvider.selectedString == "VendorInfo"
                ? colorPalette.purple
                : Colors.white,
            width: width,
            imagePath: imagePath,
            colorPalette: colorPalette,
            child: Container(
              height: width / 6,
              width: width / 2,
              child: _homeScreenProvider.selectedBottomIndex == 0 &&
                  _homeScreenProvider.selectedString == "Home"
                  ? imagePath.logo
                  : _homeScreenProvider.selectedBottomIndex == 0
                  ? Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: _homeScreenProvider.selectedString ==
                          "VendorInfo"
                          ? Colors.white
                          : colorPalette.navyBlue,
                    ),
                    onPressed: () {
                      _setHomeScreenProvider.selectedString =
                      _homeScreenProvider.selectedString == "VendorInfo"
                          ? "All Vendors"
                          : _homeScreenProvider.selectedString ==
                          "ProductInfo" ||
                          _homeScreenProvider.selectedString ==
                              "SchoolInfo"
                          ? "VendorInfo"
                          : "Home";
                    },
                    iconSize: 30,
                  ),
                  Text(
                    _homeScreenProvider.selectedString == "VendorInfo"
                        ? ""
                        : _homeScreenProvider.selectedString ==
                        "ProductInfo" ||
                        _homeScreenProvider.selectedString ==
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
                  : _homeScreenProvider.selectedBottomIndex == 1 &&
                  _homeScreenProvider.selectedString == "Category" ||
                  _homeScreenProvider.selectedString ==
                      "CategoryInfo" ||
                  _homeScreenProvider.selectedString == "ProductInfo"
                  ? leadingAppBar(
                  title: _homeScreenProvider.selectedString ==
                      "Category"
                      ? "Category"
                      : "",
                  backButton:
                  _homeScreenProvider.selectedString == "Category"
                      ? false
                      : true,
                  onBackTap: () {
                    _setHomeScreenProvider.selectedString =
                    _homeScreenProvider.selectedString == "CategoryInfo"
                        ? "Category"
                        : "CategoryInfo";
                  })
                  : _homeScreenProvider.selectedBottomIndex == 2 &&
                  _homeScreenProvider.selectedString == "School" ||
                  _homeScreenProvider.selectedString == "SchoolInfo"
                  ? leadingAppBar(
                title: _homeScreenProvider.selectedString == "School"
                    ? "Schools"
                    : "",
                backButton:
                _homeScreenProvider.selectedString == "School"
                    ? false
                    : true,
                onBackTap: () {
                  _setHomeScreenProvider.selectedString =
                  _homeScreenProvider.selectedString ==
                      "SchoolInfo"
                      ? "School"
                      : "School";
                },
              )
                  : _homeScreenProvider.selectedString == "User" ||
                  _homeScreenProvider.selectedString ==
                      "EditProfile" ||
                  _homeScreenProvider.selectedString ==
                      "ChangeMobile" ||
                  _homeScreenProvider.selectedString == "UserOTP" ||
                  _homeScreenProvider.selectedString == "Wishlist" ||
                  _homeScreenProvider.selectedString ==
                      "MyAddress" ||
                  _homeScreenProvider.selectedString == "MyOrders" ||
                  _homeScreenProvider.selectedString ==
                      "OrderDetails" ||
                  _homeScreenProvider.selectedString ==
                      "OrderTracking" ||
                  _homeScreenProvider.selectedString ==
                      "ChangePassword" ||
                  _homeScreenProvider.selectedString == "NewPassword" ||
                  _homeScreenProvider.selectedString ==
                      "FeedBack"
                  ? leadingAppBar(
                title: _homeScreenProvider.selectedString == "User"
                    ? "Account"
                    : _homeScreenProvider.selectedString ==
                    "EditProfile"
                    ? "Edit Profile"
                    : _homeScreenProvider.selectedString ==
                    "ChangeMobile" ||
                    _homeScreenProvider.selectedString ==
                        "UserOTP"
                    ? "Change Mobile Number"
                    : _homeScreenProvider.selectedString ==
                    "Wishlist"
                    ? "Wishlist"
                    : _homeScreenProvider.selectedString ==
                    "MyAddress"
                    ? "My Addresses"
                    : _homeScreenProvider.selectedString ==
                    "MyOrders" ||
                    _homeScreenProvider.selectedString ==
                        "OrderDetails"
                    ? "My Orders"
                    : _homeScreenProvider.selectedString ==
                    "ChangePassword" ||
                    _homeScreenProvider.selectedString ==
                        "NewPassword"
                    ? "Change Password"
                    : _homeScreenProvider.selectedString ==
                    "FeedBack" ? "Submit Feedback" : "",
                backButton:
                _homeScreenProvider.selectedString == "User"
                    ? false
                    : true,
                onBackTap: () {
                  _setHomeScreenProvider.selectedString =
                  _homeScreenProvider
                      .selectedString ==
                      "EditProfile"
                      ? "User"
                      : _homeScreenProvider
                      .selectedString ==
                      "ChangeMobile"
                      ? "EditProfile"
                      : _homeScreenProvider.selectedString == "UserOTP"
                      ? "ChangeMobile"
                      : _homeScreenProvider.selectedString ==
                      "Wishlist" ||
                      _homeScreenProvider.selectedString ==
                          "MyAddress" ||
                      _homeScreenProvider.selectedString ==
                          "MyOrders" ||
                      _homeScreenProvider.selectedString ==
                          "ChangePassword" ||
                      _homeScreenProvider.selectedString ==
                          "FeedBack"
                      ? "User"
                      : _homeScreenProvider.selectedString ==
                      "OrderDetails"
                      ? "MyOrders"
                      : _homeScreenProvider.selectedString ==
                      "NewPassword"
                      ? "ChangePassword"
                      : "";
                },
              )
                  : _homeScreenProvider.selectedString == "Cart"
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
                      _homeScreenProvider.selectedString == "Home"
                          ? Home()
                          : _homeScreenProvider.selectedString ==
                          "SearchProducts"
                          ? Search()
                          : _homeScreenProvider.selectedString ==
                          "VendorInfo"
                          ? Consumer<VendorProvider>(
                          builder: (_, _vendorProvider, child) =>
                              VendorsInfo(vendorSlug: _vendorProvider
                                  .selectedVendorName))
                          : _homeScreenProvider.selectedString ==
                          "ProductInfo"
                          ? Consumer<HomeScreenProvider>(
                          builder: (_, _homeScreenProvider, child) =>
                              ProductInfo(
                                selectedProductSlug: _homeScreenProvider
                                    .selectedProductSlug,))
                          : _homeScreenProvider.selectedString ==
                          "SchoolInfo"
                          ? Consumer<SchoolProvider>(
                          builder: (_, _schoolProvider, child) =>
                              SchoolInfo(schoolSlug: _schoolProvider
                                  .selectedSchoolSlug,))
                          : _homeScreenProvider.selectedString ==
                          "Filter"
                          ? Filter()
                          : _homeScreenProvider.selectedString ==
                          "School"
                          ? SchoolTab()
                          : _homeScreenProvider.selectedString ==
                          "Category" &&
                          _homeScreenProvider.selectedBottomIndex == 1
                          ? CategoryTab()
                          : _homeScreenProvider.selectedString ==
                          "CategoryInfo"
                          ? Consumer<CategoryProvider>(
                        builder: (_, _categoryProvider, child) =>
                            CategoryInfo(
                                _categoryProvider.selectedCategoryId),)
                          : AllVendors(),
                      _homeScreenProvider.selectedString == "Category"
                          ? CategoryTab()
                          : _homeScreenProvider.selectedString ==
                          "ProductInfo"
                          ? Consumer<HomeScreenProvider>(
                          builder: (_, _homeScreenProvider, child) =>
                              ProductInfo(
                                  selectedProductSlug: _homeScreenProvider
                                      .selectedProductSlug))
                          : Consumer<CategoryProvider>(
                        builder: (_, _categoryProvider, child) =>
                            CategoryInfo(
                                _categoryProvider.selectedCategoryId),),
                      _homeScreenProvider.selectedString == "School"
                          ? SchoolTab()
                          : Consumer<SchoolProvider>(
                          builder: (_, _schoolProvider, child) =>
                              SchoolInfo(schoolSlug: _schoolProvider
                                  .selectedSchoolSlug)),
                      _homeScreenProvider.selectedString ==
                          "EditProfile"
                          ? EditProfile()
                          : _homeScreenProvider.selectedString ==
                          "ChangeMobile"
                          ? Consumer<UserProvider>(
                          builder: (_, _userProvider, child) =>
                              ChangeMobile(
                                selectedMobileNumber: _userProvider
                                    .mobileNumberToChange,))
                          : _homeScreenProvider.selectedString ==
                          "UserOTP"
                          ? UserOTP()
                          : _homeScreenProvider.selectedString ==
                          "Wishlist"
                          ? WishList()
                          : _homeScreenProvider.selectedString ==
                          "MyAddress"
                          ? MyAddress()
                          : _homeScreenProvider.selectedString ==
                          "UserEditAddress"
                          ? Consumer<UserProvider>(
                          builder: (_, _userProvider, child) =>
                              UserEditAddress(
                                userAddressId: _userProvider
                                    .selectedUserAddressId,))
                          : _homeScreenProvider.selectedString ==
                          "UserAddAddress"
                          ? UserAddAddress()
                          : _homeScreenProvider.selectedString ==
                          "MyOrders"
                          ? MyOrders()
                          : _homeScreenProvider.selectedString ==
                          "OrderDetails"
                          ? OrderDetails()
                          : _homeScreenProvider.selectedString ==
                          "OrderTracking"
                          ? OrderTracking()
                          : _homeScreenProvider.selectedString ==
                          "ChangePassword"
                          ? Consumer<UserProvider>(
                        builder: (_, _userProvider, child) =>
                            ChangePassword(
                              userMobileNumber: _userProvider
                                  .mobileNumberToSendOtp,),)
                          : _homeScreenProvider.selectedString ==
                          "NewPassword"
                          ? NewPassword()
                          : _homeScreenProvider.selectedString ==
                          "FeedBack"
                          ? FeedBack()
                          : User(),
                      _homeScreenProvider.selectedString == "Cart"
                          ? Cart()
                          : _homeScreenProvider.selectedString ==
                          "AddAddress"
                          ? AddAddress()
                          : _homeScreenProvider.selectedString ==
                          "EditAddress"
                          ? Consumer<UserProvider>(
                          builder: (_, _userProvider, child) =>
                              EditAddress(userAddressId: _userProvider
                                  .selectedUserAddressId,))
                          : ChangeAddress(),
                      NotificationPage(),
                    ],
                    onPageChanged: (value) {
                      _setHomeScreenProvider.selectedBottomIndex =
                          value;
                    },
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _homeScreenProvider.selectedString ==
                      "AddAddress" ||
                      _homeScreenProvider.selectedString ==
                          "EditAddress" ||
                      _homeScreenProvider.selectedString == "Filter" ||
                      _homeScreenProvider.selectedString ==
                          "UserEditAddress" || _homeScreenProvider
                      .selectedString ==
                      "ChangeAddress" || _homeScreenProvider
                      .selectedString ==
                      "UserAddAddress"
                      ? SizedBox()
                      : Container(
                    padding: EdgeInsets.only(bottom: 10),
                    height: 70,
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
                            _setHomeScreenProvider.selectedBottomIndex =
                            0;
                            _setHomeScreenProvider.selectedString =
                            "Home";
                            _setHomeScreenProvider.blueCartIcon = false;
                            _setHomeScreenProvider.blueBellIcon = false;
                          },
                          child: CircleAvatar(
                            backgroundColor:
                            _homeScreenProvider.selectedBottomIndex == 0
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 17,
                            child: SvgPicture.asset(
                              _homeScreenProvider.selectedBottomIndex ==
                                  0
                                  ? "assets/icons/activeHome.svg"
                                  : "assets/icons/Home.svg", height: 25.0,

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(1);
                            _setHomeScreenProvider.selectedBottomIndex =
                            1;
                            _setHomeScreenProvider.selectedString =
                            "Category";
                            _setHomeScreenProvider.blueCartIcon = false;
                            _setHomeScreenProvider.blueBellIcon = false;
                          },
                          child: CircleAvatar(
                            backgroundColor:
                            _homeScreenProvider.selectedBottomIndex == 1
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 17,
                            child: SvgPicture.asset(
                              _homeScreenProvider.selectedBottomIndex ==
                                  1
                                  ? "assets/icons/activeCategory.svg"
                                  : "assets/icons/Category.svg", height: 25.0,

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(2);
                            _setHomeScreenProvider.selectedBottomIndex =
                            2;
                            _setHomeScreenProvider.selectedString =
                            "School";
                            _setHomeScreenProvider.blueCartIcon = false;
                            _setHomeScreenProvider.blueBellIcon = false;
                          },
                          child: CircleAvatar(
                            backgroundColor:
                            _homeScreenProvider.selectedBottomIndex == 2
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 17,
                            child: SvgPicture.asset(
                              _homeScreenProvider.selectedBottomIndex ==
                                  2
                                  ? "assets/icons/activeSchool.svg"
                                  : "assets/icons/School.svg", height: 25.0,

                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            pageController.jumpToPage(3);
                            _setHomeScreenProvider.selectedBottomIndex =
                            3;
                            _setHomeScreenProvider.selectedString =
                            "User";
                            _setHomeScreenProvider.blueCartIcon = false;
                            _setHomeScreenProvider.blueBellIcon = false;
                          },
                          child: CircleAvatar(
                            backgroundColor:
                            _homeScreenProvider.selectedBottomIndex == 3
                                ? colorPalette.orange
                                : Colors.transparent,
                            radius: width / 17,
                            child: SvgPicture.asset(

                              _homeScreenProvider.selectedBottomIndex ==
                                  3
                                  ? "assets/icons/activeUser.svg"
                                  : "assets/icons/User.svg",
                              color: _homeScreenProvider
                                  .selectedBottomIndex == 3
                                  ? Colors.black
                                  : null,
                              height: 25.0,
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
