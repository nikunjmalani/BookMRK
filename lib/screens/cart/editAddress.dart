import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  height: width / 20,
                ),
                AddressTextFields(width: width, title: "First Name"),
                SizedBox(
                  height: width / 20,
                ),
                AddressTextFields(width: width, title: "Contact Number"),
                SizedBox(
                  height: width / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddressTextFields(width: width / 2.25, title: "Zip Code"),
                    AddressTextFields(width: width / 2.25, title: "Country"),
                  ],
                ),
                SizedBox(
                  height: width / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AddressTextFields(
                        width: width / 2.25, title: "State/Region"),
                    AddressTextFields(width: width / 2.25, title: "City"),
                  ],
                ),
                SizedBox(
                  height: width / 20,
                ),
                AddressTextFields(width: width, title: "Address Line 1"),
                SizedBox(
                  height: width / 20,
                ),
                AddressTextFields(width: width, title: "Address Line 2"),
                SizedBox(
                  height: width / 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0.0,
          child: GestureDetector(
            onTap: () {
              /// change address from cart
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(bottom: 10),
              alignment: Alignment.center,
              child: Text(
                "Save Changes",
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
            ),
          ),
        ),
        Visibility(
          visible: true,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
