import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/Home/allVendors.dart';
import 'package:bookmrk/screens/Home/filter.dart';
import 'package:bookmrk/screens/Home/filter_category_class.dart';
import 'package:bookmrk/screens/Home/filter_category_publisher.dart';
import 'package:bookmrk/screens/Home/filter_category_subject.dart';
import 'package:bookmrk/screens/Home/productInfo.dart';
import 'package:bookmrk/screens/Home/schoolInfo.dart';
import 'package:bookmrk/screens/Home/search.dart';
import 'package:bookmrk/screens/Home/search_from_category.dart';
import 'package:bookmrk/screens/Home/vendorsInfo.dart';
import 'package:bookmrk/screens/cart/addAddress.dart';
import 'package:bookmrk/screens/cart/changeAddress.dart';
import 'package:bookmrk/screens/cart/editAddress.dart';
import 'package:bookmrk/screens/category/subcategory_info.dart';
import 'package:bookmrk/screens/tabs/all_publisher_page.dart';
import 'package:bookmrk/screens/tabs/all_subjects_page.dart';
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
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'category/categoryInfo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // PageController pageController = PageController(initialPage: 0);
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  HomeScreenProvider _setHomeScreenProvider;


  /// get data for home page..
  Future<HomePageModel> getHomePageDetails() async {
    dynamic data = await HomePageApi.getHomePageDetails();
    HomePageModel _homePageDetails = HomePageModel.fromJson(data);
    return _homePageDetails;
  }


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

        return FutureBuilder(
          future: getHomePageDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.response[0].appScreen[0].show == "1") {
                return Scaffold(
                  appBar: MaintananceAppBar(
                      context, imagePath.logo
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          child: SvgPicture.asset(
                            'assets/icons/404.svg',
                            height: 100.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text(
                        '${snapshot.data.response[0].appScreen[0].message == ""
                            ? "Page Not Found !"
                            : snapshot.data.response[0].appScreen[0].message}',
                        style: TextStyle(
                          color: colorPalette.navyBlue,
                          fontSize: 18.0,
                        ),
                      )
                    ],
                  ),
                );
              } else {
                if (snapshot.data.response[0].maintenanceScreen[0].show ==
                    "1") {
                  return Scaffold(appBar: MaintananceAppBar(
                      context, imagePath.logo
                  ),
                    body: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            child: SvgPicture.asset(
                              'assets/icons/maintanance.svg',
                              height: 150.0,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(
                          '${snapshot.data.response[0].maintenanceScreen[0]
                              .message == ""
                              ? "Application under maintenance !"
                              : snapshot.data.response[0].maintenanceScreen[0]
                              .message}',
                          style: TextStyle(
                            color: colorPalette.navyBlue,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Stack(
                    children: [
                      WillPopScope(
                        onWillPop: () async {
                          if (_homeScreenProvider.selectedString == "Home") {
                            Get.dialog(Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 300.0),
                              child: Material(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Container(

                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Text(
                                        'Are you sure you want to exit ?',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: colorPalette.navyBlue,
                                        ),
                                      ),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          FlatButton(onPressed: () {
                                            Navigator.pop(context);
                                          },
                                              child: Text(
                                                'NO', style: TextStyle(
                                                  color: colorPalette.navyBlue,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w900
                                              ),)),
                                          RaisedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              SystemNavigator.pop();
                                            },
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .circular(
                                                    5.0)),
                                            color: colorPalette.navyBlue,
                                            child: Text('YES', style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w900
                                            ),),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),);
                          }

                          else if (_homeScreenProvider.selectedString ==
                              "Category") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else
                          if (_homeScreenProvider.selectedString == "School") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else
                          if (_homeScreenProvider.selectedString == "User") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          } else if (_homeScreenProvider.selectedString ==
                              "Notifications") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          }else if (_homeScreenProvider.selectedString ==
                              "Cart") {
                            _homeScreenProvider.selectedString = "Home";
                            _homeScreenProvider.selectedBottomIndex = 0;
                            _homeScreenProvider.pageController.jumpToPage(0);
                          }

                          /// check when home page is selected......
                          _homeScreenProvider.selectedBottomIndex == 0 &&
                              _homeScreenProvider.selectedString == "Home"
                              ? imagePath.logo
                              : _homeScreenProvider.selectedBottomIndex == 0
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString == "VendorInfo"
                              ? "Home"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo"
                              ? "Home"
                              : _homeScreenProvider.selectedString ==
                              "FilterS"
                              ? "AllSubjects" : _homeScreenProvider
                              .selectedString ==
                              "FilterP"
                              ? "AllPublishers" :
                          _homeScreenProvider.selectedString ==
                              "SubCategoryInfo"
                              ? "CategoryInfo" : "Home"

                          /// check when category page is selected......
                              : _homeScreenProvider.selectedBottomIndex == 1 &&
                              (_homeScreenProvider.selectedString ==
                                  "Category" ||
                                  _homeScreenProvider.selectedString ==
                                      "CategoryInfo" || _homeScreenProvider
                                  .selectedString ==
                                  "SubCategoryInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "ProductInfo")
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString == "CategoryInfo"
                              ? "Category"
                              : _homeScreenProvider.selectedString ==
                              "SubCategoryInfo"
                              ? "CategoryInfo"
                              : "Category"

                          /// check when school page is selected.......
                              : _homeScreenProvider.selectedBottomIndex == 2 &&
                              (_homeScreenProvider.selectedString ==
                                  "ProductInfo" ||
                                  _homeScreenProvider.selectedString ==
                                      "School" ||
                                  _homeScreenProvider.selectedString ==
                                      "SchoolInfo")
                              ? _setHomeScreenProvider.selectedString =
                          _homeScreenProvider.selectedString ==
                              "SchoolInfo"
                              ? "School"
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo" ? "SchoolInfo" : "School"

                          /// check when user is selected........
                              : _homeScreenProvider.selectedString == "User" ||
                              (_homeScreenProvider.selectedString ==
                                  "EditProfile" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangeMobile" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserOTP" ||
                                  _homeScreenProvider.selectedString ==
                                      "Wishlist" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "MyOrders" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderDetails" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTracking" ||
                                  _homeScreenProvider.selectedString ==
                                      "ChangePassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "NewPassword" ||
                                  _homeScreenProvider.selectedString ==
                                      "FeedBack"
                                  || _homeScreenProvider.selectedString ==
                                      "ProductInfo")
                              ? _setHomeScreenProvider.selectedString =
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
                              : _homeScreenProvider.selectedString ==
                              "ProductInfo"
                              ? "Wishlist"
                              : "User" : "User";

                          /// ============================================================

                          return false;
                        },
                        child: Scaffold(
                          appBar: _homeScreenProvider.selectedString ==
                              "ChangeAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "AddAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "EditAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "SearchProducts" ||
                              _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ||
                              _homeScreenProvider.selectedString == "Filter" ||
                              _homeScreenProvider.selectedString ==
                                  "UserEditAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "UserAddAddress" ||
                              _homeScreenProvider.selectedString ==
                                  "OrderTracking"
                              ? SimpleAppBar(
                              actionIcon: _homeScreenProvider.selectedString ==
                                  "AddAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "EditAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts" ||
                                  _homeScreenProvider.selectedString ==
                                      "SearchProducts2" ||
                                  _homeScreenProvider.selectedString ==
                                      "Filter" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserEditAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "UserAddAddress" ||
                                  _homeScreenProvider.selectedString ==
                                      "OrderTracking"
                                  ? null
                                  : Icons.add,
                              actionTap: () {
                                _setHomeScreenProvider.selectedString =
                                _homeScreenProvider.selectedString ==
                                    "ChangeAddress"
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
                                    : _homeScreenProvider.selectedString ==
                                    "Filter"
                                    ? "VendorInfo"
                                    : _homeScreenProvider.selectedString ==
                                    "UserEditAddress" ||
                                    _homeScreenProvider.selectedString ==
                                        "UserAddAddress"
                                    ? "MyAddress"
                                    : _homeScreenProvider.selectedString ==
                                    "OrderTracking"
                                    ? "OrderDetails"
                                    : _homeScreenProvider.selectedString ==
                                    "SearchProducts2"
                                    ? "Category"
                                    : "Cart";
                              },
                              title: _homeScreenProvider.selectedString ==
                                  "SearchProducts"
                                  ? "Search Products"
                                  : _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ?
                              "Search Products"
                                  : _homeScreenProvider.selectedString ==
                                  "SearchProducts2" ?
                              "Search Products" : _homeScreenProvider
                                  .selectedString ==
                                  "Filter"
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
                              : _homeScreenProvider.selectedString ==
                              "VendorInfo"
                              ? PreferredSize(
                              child: Container(), preferredSize: Size(0.0, 0.0))
                              : CustomAppBar(
                            context,
                            blueCartIcon: _homeScreenProvider.blueCartIcon,
                            blueBellIcon: _homeScreenProvider.blueBellIcon,
                            onBellTap: () {
                              _homeScreenProvider.pageController.jumpToPage(5);

                              _setHomeScreenProvider.selectedString =
                              "Notifications";
                              _setHomeScreenProvider.selectedBottomIndex = 5;
                              _setHomeScreenProvider.blueCartIcon = false;
                              _setHomeScreenProvider.blueBellIcon = true;
                            },
                            onCartTap: () {
                              _homeScreenProvider.pageController.jumpToPage(4);

                              _setHomeScreenProvider.selectedString = "Cart";
                              _setHomeScreenProvider.selectedBottomIndex = 4;
                              _setHomeScreenProvider.blueCartIcon = true;
                              _setHomeScreenProvider.blueBellIcon = false;
                            },
                            whiteIcon: _homeScreenProvider.selectedString ==
                                "VendorInfo" ? true : false,
                            color: _homeScreenProvider.selectedString ==
                                "VendorInfo"
                                ? colorPalette.purple
                                : Colors.white,
                            width: width,
                            imagePath: imagePath,
                            colorPalette: colorPalette,
                            child: Container(
                              height: width / 6,
                              width: width / 2,
                              alignment: Alignment.centerLeft,

                              /// home page appbar...
                              child: _homeScreenProvider.selectedBottomIndex ==
                                  0 &&
                                  _homeScreenProvider.selectedString == "Home"
                                  ? imagePath.logo
                                  : _homeScreenProvider.selectedBottomIndex == 0
                                  ? Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: _homeScreenProvider
                                          .selectedString ==
                                          "VendorInfo"
                                          ? Colors.white
                                          : colorPalette.navyBlue,
                                    ),
                                    onPressed: () {
                                      _setHomeScreenProvider.selectedString =
                                      _homeScreenProvider.selectedString ==
                                          "VendorInfo"
                                          ? "All Vendors"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo"
                                          ? "Home"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterS"
                                          ? "AllSubjects" : _homeScreenProvider
                                          .selectedString ==
                                          "FilterP"
                                          ? "AllPublishers" :
                                      _homeScreenProvider.selectedString ==
                                          "SubCategoryInfo"
                                          ? "CategoryInfo" : "Home";
                                    },
                                    iconSize: 30,
                                  ),
                                  Container(
                                    width: width / 2.8,
                                    child: Text(
                                      _homeScreenProvider.selectedString ==
                                          "VendorInfo"
                                          ? ""
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo" ? "${_homeScreenProvider.selectedTitle}" :
                                      _homeScreenProvider.selectedString ==
                                          "SchoolInfo"
                                          ? "${_homeScreenProvider.selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllSubjects"
                                          ? "All Subjects"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "CategoryInfo"
                                          ? "${_homeScreenProvider.selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "SubCategoryInfo"
                                          ? "SubCategory"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllPublishers"
                                          ? "All Publishers"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterS"
                                          ? "${_homeScreenProvider.selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterP"
                                          ? "${_homeScreenProvider.selectedTitle}"
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterC"
                                          ? "${_homeScreenProvider.selectedTitle}"
                                          : 'All Vendors',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xff301869),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              )

                              /// category page appbar...
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  1 &&
                                  (_homeScreenProvider.selectedString ==
                                      "Category" ||
                                      _homeScreenProvider.selectedString ==
                                          "CategoryInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "SubCategoryInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "ProductInfo")
                                  ? leadingAppBar(
                                  title: _homeScreenProvider.selectedString ==
                                      "Category"
                                      ? "Category"
                                      : _homeScreenProvider.selectedString ==
                                      "SubCategoryInfo"
                                      ? "SubCategory" : "${_homeScreenProvider.selectedTitle}",
                                  backButton:
                                  _homeScreenProvider.selectedString ==
                                      "Category"
                                      ? false
                                      : true,
                                  onBackTap: () {
                                    _setHomeScreenProvider.selectedString =
                                    _homeScreenProvider.selectedString ==
                                        "CategoryInfo"
                                        ? "Category"
                                        : _homeScreenProvider.selectedString ==
                                        "SubCategoryInfo"
                                        ? "CategoryInfo" : "Category";
                                  })

                              /// school page appbar ....
                                  : _homeScreenProvider.selectedBottomIndex ==
                                  2 &&
                                  (_homeScreenProvider.selectedString ==
                                      "ProductInfo" ||
                                      _homeScreenProvider.selectedString ==
                                          "School" ||
                                      _homeScreenProvider.selectedString ==
                                          "SchoolInfo")
                                  ? leadingAppBar(
                                title: _homeScreenProvider.selectedString ==
                                    "School"
                                    ? "Schools"
                                    : "${_homeScreenProvider.selectedTitle}",
                                backButton:
                                _homeScreenProvider.selectedString == "School"
                                    ? false
                                    : true,
                                onBackTap: () {
                                  _setHomeScreenProvider.selectedString =
                                  _homeScreenProvider.selectedString ==
                                      "SchoolInfo"
                                      ? "School"
                                      : _homeScreenProvider.selectedString ==
                                      "ProductInfo" ? "SchoolInfo" : "School";
                                },
                              )


                              /// user page appbar...
                                  : _homeScreenProvider.selectedString ==
                                  "User" ||
                                  (_homeScreenProvider.selectedString ==
                                      "EditProfile" ||
                                      _homeScreenProvider.selectedString ==
                                          "ChangeMobile" ||
                                      _homeScreenProvider.selectedString ==
                                          "UserOTP" ||
                                      _homeScreenProvider.selectedString ==
                                          "Wishlist" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyAddress" ||
                                      _homeScreenProvider.selectedString ==
                                          "MyOrders" ||
                                      _homeScreenProvider.selectedString ==
                                          "OrderDetails" ||
                                      _homeScreenProvider.selectedString ==
                                          "OrderTracking" ||
                                      _homeScreenProvider.selectedString ==
                                          "ChangePassword" ||
                                      _homeScreenProvider.selectedString ==
                                          "NewPassword" ||
                                      _homeScreenProvider.selectedString ==
                                          "FeedBack"
                                      || _homeScreenProvider.selectedString ==
                                          "ProductInfo")
                                  ? leadingAppBar(
                                title: _homeScreenProvider.selectedString ==
                                    "User"
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
                                      : _homeScreenProvider.selectedString ==
                                      "UserOTP"
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
                                      : _homeScreenProvider.selectedString ==
                                      "ProductInfo"
                                      ? "Wishlist"
                                      : "";
                                },
                              )

                              /// cart page appbar....
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
                                    controller: _homeScreenProvider
                                        .pageController,
                                    children: [

                                      /// home page..
                                      _homeScreenProvider.selectedString ==
                                          "Home"
                                          ? Home()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "SearchProducts"
                                          ? Search()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllSubjects"
                                          ? Consumer<FilterCategoryProvider>(
                                          builder: (_, _filterCategoryProvider,
                                              child) =>
                                              AllSubjects(
                                                  subjects: _filterCategoryProvider
                                                      .allFilterSubjectsList))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterS"
                                          ? Consumer<FilterCategoryProvider>(
                                          builder: (_, _filterCategoryProvider,
                                              child) =>
                                              FilterCategorySubject(
                                                  _filterCategoryProvider
                                                      .selectedFilterCategorySubjectSlug))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterC"
                                          ? Consumer<FilterCategoryProvider>(
                                          builder: (_, _filterCategoryProvider,
                                              child) =>
                                              FilterCategoryClass(
                                                  _filterCategoryProvider
                                                      .selectedFilterCategoryClassSlug))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FilterP"
                                          ? Consumer<FilterCategoryProvider>(
                                          builder: (_, _filterCategoryProvider,
                                              child) =>
                                              FilterCategoryPublisher(
                                                  _filterCategoryProvider
                                                      .selectedFilterCategoryPublisherSlug))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AllPublishers"
                                          ? Consumer<FilterCategoryProvider>(
                                          builder: (_, _filterCategoryProvider,
                                              child) =>
                                              AllPublisher(
                                                  publisher: _filterCategoryProvider
                                                      .allPublisherList))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "VendorInfo"
                                          ? Consumer<VendorProvider>(
                                          builder: (_, _vendorProvider,
                                              child) =>
                                              VendorsInfo(
                                                  vendorSlug: _vendorProvider
                                                      .selectedVendorName))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo"
                                          ? Consumer<HomeScreenProvider>(
                                          builder: (_, _homeScreenProvider,
                                              child) {
                                            return ProductInfo(
                                              selectedProductSlug: _homeScreenProvider
                                                  .selectedProductSlug,);
                                          }
                                      )
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "SchoolInfo"
                                          ? Consumer<SchoolProvider>(
                                          builder: (_, _schoolProvider,
                                              child) =>
                                              SchoolInfo(
                                                schoolSlug: _schoolProvider
                                                    .selectedSchoolSlug,))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "Filter"
                                          ? Filter()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "School"
                                          ? SchoolTab()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "Category" &&
                                          _homeScreenProvider
                                              .selectedBottomIndex ==
                                              1
                                          ? CategoryTab()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "CategoryInfo"
                                          ? Consumer<CategoryProvider>(
                                        builder: (_, _categoryProvider,
                                            child) =>
                                            CategoryInfo(
                                                _categoryProvider
                                                    .selectedCategoryName),)
                                          :
                                      _homeScreenProvider
                                          .selectedString ==
                                          "SearchProducts2"
                                          ? Search2()
                                          :
                                      // _homeScreenProvider
                                      //     .selectedString ==
                                      //     "SubCategoryInfo"
                                      //     ? Consumer<CategoryProvider>(
                                      //   builder: (_, _categoryProvider,
                                      //       child) =>
                                      //       SubCategoryInfo(
                                      //           _categoryProvider
                                      //               .selectedSubCategory),)
                                      //     :
                                      AllVendors(),

                                      /// category page...
                                      _homeScreenProvider.selectedString ==
                                          "Category"
                                          ? CategoryTab()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo"
                                          ? Consumer<HomeScreenProvider>(
                                          builder: (_, _homeScreenProvider,
                                              child) =>
                                              ProductInfo(
                                                  selectedProductSlug: _homeScreenProvider
                                                      .selectedProductSlug))
                                          :
                                      // _homeScreenProvider
                                      //     .selectedString ==
                                      //     "SubCategoryInfo"
                                      //     ? Consumer<CategoryProvider>(
                                      //   builder: (_, _categoryProvider,
                                      //       child) =>
                                      //       SubCategoryInfo(
                                      //           _categoryProvider
                                      //               .selectedSubCategory),)
                                      //     :
                                      _homeScreenProvider
                                          .selectedString ==
                                          "SearchProducts2"
                                          ? Search2()
                                          : Consumer<
                                          CategoryProvider>(
                                        builder: (_, _categoryProvider,
                                            child) =>
                                            CategoryInfo(
                                                _categoryProvider
                                                    .selectedCategoryName),),


                                      /// school page...
                                      _homeScreenProvider.selectedString ==
                                          "School"
                                          ? SchoolTab()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "SchoolInfo"
                                          ? Consumer<SchoolProvider>(
                                          builder: (_, _schoolProvider,
                                              child) =>
                                              SchoolInfo(
                                                  schoolSlug: _schoolProvider
                                                      .selectedSchoolSlug))
                                          : Consumer<HomeScreenProvider>(
                                          builder: (_, _homeScreenProvider,
                                              child) =>
                                              ProductInfo(
                                                  selectedProductSlug: _homeScreenProvider
                                                      .selectedProductSlug)),

                                      /// user page...
                                      _homeScreenProvider.selectedString ==
                                          "EditProfile"
                                          ? EditProfile()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ChangeMobile"
                                          ? Consumer<UserProvider>(
                                          builder: (_, _userProvider, child) =>
                                              ChangeMobile(
                                                selectedMobileNumber: _userProvider
                                                    .mobileNumberToChange,))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "UserOTP"
                                          ? UserOTP()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "Wishlist"
                                          ? WishList()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "MyAddress"
                                          ? MyAddress()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "UserEditAddress"
                                          ? Consumer<UserProvider>(
                                          builder: (_, _userProvider, child) =>
                                              UserEditAddress(
                                                userAddressId: _userProvider
                                                    .selectedUserAddressId,))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "UserAddAddress"
                                          ? UserAddAddress()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "MyOrders"
                                          ? MyOrders()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "OrderDetails"
                                          ? Consumer<OrderProvider>(
                                          builder: (_, _orderProvider, child) =>
                                              OrderDetails(
                                                  _orderProvider.orderId
                                                      .toString()))
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "OrderTracking"
                                          ? Consumer<OrderProvider>(
                                          builder: (_, _orderProvider, child) =>
                                              OrderTracking(
                                                orderIdToTrack: _orderProvider
                                                    .orderIdToTrack,
                                                userAddressToDeliver: _orderProvider
                                                    .userDeliveryAddress,)
                                      )
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ChangePassword"
                                          ? Consumer<UserProvider>(
                                        builder: (_, _userProvider, child) =>
                                            ChangePassword(
                                              userMobileNumber: _userProvider
                                                  .mobileNumberToSendOtp,),)
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "NewPassword"
                                          ? NewPassword()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "FeedBack"
                                          ? FeedBack()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "ProductInfo"
                                          ? Consumer<HomeScreenProvider>(
                                          builder: (_, _homeScreenProvider,
                                              child) =>
                                              ProductInfo(
                                                selectedProductSlug: _homeScreenProvider
                                                    .selectedProductSlug,))
                                          : User(),

                                      /// cart page...
                                      _homeScreenProvider.selectedString ==
                                          "Cart"
                                          ? Cart()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "AddAddress"
                                          ? AddAddress()
                                          : _homeScreenProvider
                                          .selectedString ==
                                          "EditAddress"
                                          ? Consumer<UserProvider>(
                                          builder: (_, _userProvider, child) =>
                                              EditAddress(
                                                userAddressId: _userProvider
                                                    .selectedUserAddressId,))
                                          : ChangeAddress(),

                                      /// notification page...
                                      NotificationPage(),
                                    ],
                                    onPageChanged: (value) {
                                      _setHomeScreenProvider
                                          .selectedBottomIndex =
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
                                      _homeScreenProvider.selectedString ==
                                          "Filter" ||
                                      _homeScreenProvider.selectedString ==
                                          "UserEditAddress" ||
                                      _homeScreenProvider
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
                                            _homeScreenProvider.pageController
                                                .jumpToPage(0);
                                            _setHomeScreenProvider
                                                .selectedBottomIndex =
                                            0;
                                            _setHomeScreenProvider
                                                .selectedString =
                                            "Home";
                                            _setHomeScreenProvider
                                                .blueCartIcon =
                                            false;
                                            _setHomeScreenProvider
                                                .blueBellIcon =
                                            false;
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            _homeScreenProvider
                                                .selectedBottomIndex == 0
                                                ? colorPalette.orange
                                                : Colors.transparent,
                                            radius: width / 17,
                                            child: SvgPicture.asset(
                                              _homeScreenProvider
                                                  .selectedBottomIndex ==
                                                  0
                                                  ? "assets/icons/activeHome.svg"
                                                  : "assets/icons/Home.svg",
                                              height: 25.0,

                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _homeScreenProvider.pageController
                                                .jumpToPage(1);
                                            _setHomeScreenProvider
                                                .selectedBottomIndex =
                                            1;
                                            _setHomeScreenProvider
                                                .selectedString =
                                            "Category";
                                            _setHomeScreenProvider
                                                .blueCartIcon =
                                            false;
                                            _setHomeScreenProvider
                                                .blueBellIcon =
                                            false;
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            _homeScreenProvider
                                                .selectedBottomIndex == 1
                                                ? colorPalette.orange
                                                : Colors.transparent,
                                            radius: width / 17,
                                            child: SvgPicture.asset(
                                              _homeScreenProvider
                                                  .selectedBottomIndex ==
                                                  1
                                                  ? "assets/icons/activeCategory.svg"
                                                  : "assets/icons/Category.svg",
                                              height: 25.0,

                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _homeScreenProvider.pageController
                                                .jumpToPage(2);
                                            _setHomeScreenProvider
                                                .selectedBottomIndex =
                                            2;
                                            _setHomeScreenProvider
                                                .selectedString =
                                            "School";
                                            _setHomeScreenProvider
                                                .blueCartIcon =
                                            false;
                                            _setHomeScreenProvider
                                                .blueBellIcon =
                                            false;
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            _homeScreenProvider
                                                .selectedBottomIndex == 2
                                                ? colorPalette.orange
                                                : Colors.transparent,
                                            radius: width / 17,
                                            child: SvgPicture.asset(
                                              _homeScreenProvider
                                                  .selectedBottomIndex ==
                                                  2
                                                  ? "assets/icons/activeSchool.svg"
                                                  : "assets/icons/School.svg",
                                              height: 25.0,

                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            _homeScreenProvider.pageController
                                                .jumpToPage(3);
                                            _setHomeScreenProvider
                                                .selectedBottomIndex =
                                            3;
                                            _setHomeScreenProvider
                                                .selectedString =
                                            "User";
                                            _setHomeScreenProvider
                                                .blueCartIcon =
                                            false;
                                            _setHomeScreenProvider
                                                .blueBellIcon =
                                            false;
                                          },
                                          child: CircleAvatar(
                                            backgroundColor:
                                            _homeScreenProvider
                                                .selectedBottomIndex == 3
                                                ? colorPalette.orange
                                                : Colors.transparent,
                                            radius: width / 17,
                                            child: SvgPicture.asset(

                                              _homeScreenProvider
                                                  .selectedBottomIndex ==
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
                        ),
                      ),
                      snapshot.data.response[0].popupScreen[0].show == "1" &&
                          _homeScreenProvider.homeScreenMainPopupShow
                          ? Material(
                        color: Colors.transparent,
                        child: Container(
                          color: Colors.black26,
                          alignment: Alignment.center,
                          child: Container(
                            height: 180,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width - 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.all(15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data.response[0].popupScreen[0]
                                      .title}',
                                  style: TextStyle(
                                    color: colorPalette.navyBlue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  '${snapshot.data.response[0].popupScreen[0]
                                      .message}',
                                  style: TextStyle(
                                    color: colorPalette.navyBlue,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    RaisedButton(
                                      onPressed: () {
                                        _homeScreenProvider
                                            .homeScreenMainPopupShow = false;
                                      },
                                      child: Text(
                                        'OK',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w900,
                                            fontSize: 16.0),
                                      ),
                                      color: colorPalette.navyBlue,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(8.0)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                          : SizedBox()
                    ],
                  );
                }
              }
            } else {
              return Scaffold(
                body: Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/loading.svg', width: 150.0,),
                    SizedBox(height: 20.0),
                    Text('Loading...', style: TextStyle(color: colorPalette
                        .navyBlue, fontSize: 18.0),)
                  ],
                )),
              );
            }
          },
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
      Container(
        width: Get.width / 2.6,
        child: Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: const Color(0xff301869),
          ),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
