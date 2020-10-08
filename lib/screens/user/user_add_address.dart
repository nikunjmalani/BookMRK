import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAddAddress extends StatefulWidget {
  @override
  _UserAddAddressState createState() => _UserAddAddressState();
}

class _UserAddAddressState extends State<UserAddAddress> {
  /// TextFields
  TextEditingController _firstNameAddressController = TextEditingController();
  TextEditingController _lastNameAddressController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _contactNumberAddressController =
      TextEditingController();
  TextEditingController _zipCodeAddressController = TextEditingController();
  TextEditingController _countryCodeAddressController = TextEditingController();
  TextEditingController _stateNameAddressController = TextEditingController();
  TextEditingController _cityNameAddressController = TextEditingController();
  TextEditingController _firstAddressController = TextEditingController();
  TextEditingController _secondAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (_, _userProvider, child) => Stack(
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
                  AddressTextFields(
                      width: width,
                      title: "First Name",
                      controller: _firstNameAddressController),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Last Name",
                      controller: _lastNameAddressController),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Email",
                      controller: _emailAddressController),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Contact Number",
                      controller: _contactNumberAddressController),
                  SizedBox(
                    height: width / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddressTextFields(
                          width: width / 2.25,
                          title: "Zip Code",
                          controller: _zipCodeAddressController),
                      AddressTextFields(
                          width: width / 2.25,
                          title: "Country",
                          controller: _countryCodeAddressController),
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
                          title: "State/Region",
                          controller: _stateNameAddressController),
                      AddressTextFields(
                          width: width / 2.25,
                          title: "City",
                          controller: _cityNameAddressController),
                    ],
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Address Line 1",
                      controller: _firstAddressController),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Address Line 2",
                      controller: _secondAddressController),
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
              onTap: () async {
                _userProvider.isAddAddressInProcess = true;
                SharedPreferences _prefs =
                    await SharedPreferences.getInstance();
                int userId = _prefs.getInt('userId');
                print(' user id : $userId');
                print('first name : ${_firstNameAddressController.text}');
                print('last name : ${_lastNameAddressController.text}');
                print('email : ${_emailAddressController.text}');
                print(' contact : ${_contactNumberAddressController.text}');
                print(' zip : ${_zipCodeAddressController.text}');
                print(' country : ${_countryCodeAddressController.text}');
                print(' state : ${_stateNameAddressController.text}');
                print(' city : ${_cityNameAddressController.text}');
                print(' ad1 : ${_firstAddressController.text}');
                print(' ad2 : ${_secondAddressController.text}');

                dynamic response = await UserAPI.addNewUserAddress(
                  userId.toString(),
                  _firstNameAddressController.text,
                  _lastNameAddressController.text,
                  _emailAddressController.text,
                  _contactNumberAddressController.text,
                  _stateNameAddressController.text,
                  _cityNameAddressController.text,
                  _firstAddressController.text,
                  _secondAddressController.text,
                  _zipCodeAddressController.text,
                  _countryCodeAddressController.text,
                );

                print("data $response");
                if (response['status'] == 200) {
                  _userProvider.isAddAddressInProcess = false;
                  Scaffold.of(context)
                      .showSnackBar(getSnackBar('Address is added.'));
                } else {
                  _userProvider.isAddAddressInProcess = false;
                  Scaffold.of(context)
                      .showSnackBar(getSnackBar('Address not added !'));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  "ADD",
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
            visible: _userProvider.isAddAddressInProcess,
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
      ),
    );
  }
}
