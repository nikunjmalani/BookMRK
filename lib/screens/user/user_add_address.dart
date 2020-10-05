import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:flutter/material.dart';

class UserAddAddress extends StatefulWidget {
  @override
  _UserAddAddressState createState() => _UserAddAddressState();
}

class _UserAddAddressState extends State<UserAddAddress> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
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
                AddressTextFields(width: width / 2.25, title: "State/Region"),
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
    );
  }
}
