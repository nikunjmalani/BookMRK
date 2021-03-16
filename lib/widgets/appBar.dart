import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

Widget CustomAppBar(BuildContext context,
    {width,
    bool blueCartIcon,
    bool blueBellIcon,
    imagePath,
    colorPalette,
    child,
    color,
    bool whiteIcon,
    onCartTap,
    onBellTap}) {
  return AppBar(
    brightness: Brightness.light,
    automaticallyImplyLeading: false,
    elevation: 0.5,
    backgroundColor: color,
    flexibleSpace: Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 35),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 8,
          color: Color(0xff676767).withOpacity(0.05),
        ),
      ], color: color),
      child: Row(
        children: [
          Container(
            width: width / 1.9,
            child: child,
          ),

          Spacer(),
          InkWell(
            child:           Icon(Icons.search,size: 30,color: Colors.black45,),

            onTap: (){
              Provider.of<HomeScreenProvider>(context,
                  listen: false)
                  .selectedString = "SearchProducts";
              Provider.of<HomeScreenProvider>(context,
                  listen: false)
                  .findHomeScreenProduct = "";
            },
          ),
          GestureDetector(
            onTap: onCartTap,
            child: Stack(
              alignment: Alignment.topRight,
              children: [

                CircleAvatar(
                  child: SvgPicture.asset(
                    "assets/icons/Cart.svg",
                    height: 30,
                    width: 30,
                    color: whiteIcon == true
                        ? Colors.white
                        : blueCartIcon == true
                            ? colorPalette.navyBlue
                            : null,
                  ),
                  radius: 25,
                  backgroundColor: Colors.transparent,
                ),
                Consumer<HomeScreenProvider>(
                    builder: (_, _homeScreenProvider, child) {
                  return _homeScreenProvider.totalNumberOfOrdersInCart == 0
                      ? SizedBox()
                      : CircleAvatar(
                          radius: 10,
                          child: Text(
                            '${_homeScreenProvider.totalNumberOfOrdersInCart}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          backgroundColor: colorPalette.pinkOrange,
                        );
                })
              ],
            ),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: onBellTap,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                CircleAvatar(
                  child: SvgPicture.asset(
                    "assets/icons/bell.svg",
                    height: 30,
                    width: 30,
                    color: whiteIcon == true
                        ? Colors.white
                        : blueBellIcon == true
                            ? colorPalette.navyBlue
                            : null,
                  ),
                  radius: 25,
                  backgroundColor: Colors.transparent,
                ),
                Consumer<HomeScreenProvider>(
                    builder: (_, _homeScreenProvider, child) {
                  return _homeScreenProvider.totalNewNotifications == 0
                      ? SizedBox()
                      : CircleAvatar(
                          radius: 10,
                          child: Text(
                            '${_homeScreenProvider.totalNewNotifications}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 13,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          backgroundColor: colorPalette.pinkOrange,
                        );
                })
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget MaintananceAppBar(BuildContext context, child) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0.5,
    backgroundColor: colorPalette.navyBlue,
    flexibleSpace: Container(
      padding: EdgeInsets.only(left: 16, right: 16, top: 35),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 8,
          color: Color(0xff676767).withOpacity(0.05),
        ),
      ], color: colorPalette.navyBlue),
      child: Row(
        children: [
          Container(
            child: child,
            alignment: Alignment.centerLeft,
          ),
        ],
      ),
    ),
  );
}

Widget SimpleAppBar({context, onTap, title, icon, actionTap, actionIcon}) {
  ColorPalette colorPalette = ColorPalette();

  return AppBar(
    elevation: 0.5,
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    flexibleSpace: Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12, top: 35, right: 12),
      child: Row(
        children: [
          IconButton(
            onPressed: onTap,
            iconSize: 40,
            color: colorPalette.navyBlue,
            icon: Icon(icon),
          ),
          Spacer(
            flex: 3,
          ),
          Text(
            title,
            style: TextStyle(color: colorPalette.navyBlue, fontSize: 24),
          ),
          Spacer(
            flex: 6,
          ),
          IconButton(
            onPressed: actionTap,
            iconSize: 40,
            color: colorPalette.navyBlue,
            icon: Icon(actionIcon),
          ),
        ],
      ),
    ),
  );
}

Widget PurpleAppBar(context, color) {
  ColorPalette colorPalette = ColorPalette();

  return Container(
    padding: EdgeInsets.only(left: 16, right: 16),
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        offset: Offset(0, 1),
        blurRadius: 8,
        color: Color(0xff676767).withOpacity(0.05),
      ),
    ], color: color),
    child: Row(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Provider.of<HomeScreenProvider>(context, listen: false)
                .selectedString = "Home";
          },
          iconSize: 30,
        ),
        Spacer(),
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                "assets/icons/Cart.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              radius: 25,
              backgroundColor: Colors.transparent,
            ),
            CircleAvatar(
              radius: 10,
              child: Text(
                '3',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: colorPalette.pinkOrange,
            )
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            CircleAvatar(
              child: SvgPicture.asset(
                "assets/icons/bell.svg",
                height: 30,
                width: 30,
                color: Colors.white,
              ),
              radius: 25,
              backgroundColor: Colors.transparent,
            ),
            CircleAvatar(
              radius: 10,
              child: Text(
                '8',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                ),
                textAlign: TextAlign.left,
              ),
              backgroundColor: colorPalette.pinkOrange,
            )
          ],
        ),
      ],
    ),
  );
}
