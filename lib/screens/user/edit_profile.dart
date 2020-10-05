import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: height / 10,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(
                'assets/images/photo.png',
              ),
            ),
            Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 16,
                color: const Color(0xff301869),
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddressTextFields(width: width / 2.25, title: "First Name"),
                AddressTextFields(width: width / 2.25, title: "Last Name"),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddressTextFields(
                  width: width / 2.25,
                  title: "Date Of Birth",
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                AddressTextFields(
                    width: width / 2.25,
                    title: "Gender",
                    suffixIcon: Icon(Icons.keyboard_arrow_down)),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            AddressTextFields(width: width, title: "Email Address"),
            SizedBox(
              height: width / 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddressTextFields(
                  width: width / 1.3,
                  title: "Mobile Number",
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, top: 15),
                    child: Text(
                      '+91',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: const Color(0xff515c6f),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .selectedString = "ChangeMobile";
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, top: 25),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        color: const Color(0xff301869),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: width / 20,
            ),
            BlueLongButton(
              color: colorPalette.navyBlue,
              title: "Save Update",
              height: height,
              onTap: () {},
            ),
            SizedBox(
              height: width / 1.6,
            )
          ],
        ),
      ),
    );
  }
}
