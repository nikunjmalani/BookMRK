import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEditAddress extends StatefulWidget {
  final String userAddressId;

  const UserEditAddress({this.userAddressId});
  @override
  _UserEditAddressState createState() => _UserEditAddressState();
}

class _UserEditAddressState extends State<UserEditAddress> {
  /// TextFields...

  TextEditingController _firstNameEditAddress = TextEditingController();
  TextEditingController _lastNameEditAddress = TextEditingController();
  TextEditingController _emailEditAddress = TextEditingController();
  TextEditingController _contactEditAddress = TextEditingController();
  TextEditingController _zipEditAddress = TextEditingController();
  TextEditingController _countryEditAddress = TextEditingController();
  TextEditingController _stateEditAddress = TextEditingController();
  TextEditingController _cityEditAddress = TextEditingController();
  TextEditingController _firstAddressEdit = TextEditingController();
  TextEditingController _secondAddressEdit = TextEditingController();

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
                      controller: _firstNameEditAddress),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Last Name",
                      controller: _lastNameEditAddress),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "email Address",
                      controller: _emailEditAddress),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Contact Number",
                      controller: _contactEditAddress),
                  SizedBox(
                    height: width / 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AddressTextFields(
                          width: width / 2.25,
                          title: "Zip Code",
                          controller: _zipEditAddress),
                      AddressTextFields(
                          width: width / 2.25,
                          title: "Country",
                          controller: _countryEditAddress),
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
                          controller: _stateEditAddress),
                      AddressTextFields(
                          width: width / 2.25,
                          title: "City",
                          controller: _cityEditAddress),
                    ],
                  ),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Address Line 1",
                      controller: _firstAddressEdit),
                  SizedBox(
                    height: width / 20,
                  ),
                  AddressTextFields(
                      width: width,
                      title: "Address Line 2",
                      controller: _secondAddressEdit),
                  SizedBox(
                    height: width / 3,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Consumer<UserProvider>(
              builder: (_, _userProvider, child) => GestureDetector(
                onTap: () async {
                  _userProvider.userAddressEditInProgress = true;

                  /// change address from user profile..
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  int userId = _prefs.getInt('userId');

//                  print(' user id : $userId');
//                  print(
//                      ' user address id : ${_userProvider.selectedUserAddressId}');
//                  print('first name : ${_firstNameEditAddress.text}');
//                  print('last name : ${_lastNameEditAddress.text}');
//                  print('email : ${_emailEditAddress.text}');
//                  print(' contact : ${_contactEditAddress.text}');
//                  print(' zip : ${_zipEditAddress.text}');
//                  print(' country : ${_countryEditAddress.text}');
//                  print(' state : ${_stateEditAddress.text}');
//                  print(' city : ${_cityEditAddress.text}');
//                  print(' ad1 : ${_firstAddressEdit.text}');
//                  print(' ad2 : ${_secondAddressEdit.text}');

                  dynamic response = await UserAPI.editUserAddress(
                    userId.toString(),
                    _userProvider.selectedUserAddressId,
                    _firstNameEditAddress.text,
                    _lastNameEditAddress.text,
                    _emailEditAddress.text,
                    _contactEditAddress.text,
                    _stateEditAddress.text,
                    _cityEditAddress.text,
                    _firstAddressEdit.text,
                    _secondAddressEdit.text,
                    _zipEditAddress.text,
                  );

                  print(response);

                  if (response['status'] == 200) {
                    _userProvider.userAddressEditInProgress = false;
                    Scaffold.of(context)
                        .showSnackBar(getSnackBar('record Changed !'));
                  } else {
                    _userProvider.userAddressEditInProgress = false;
                    Scaffold.of(context)
                        .showSnackBar(getSnackBar('${response['message']}'));
                  }
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
          ),
          Visibility(
            visible: _userProvider.userAddressEditInProgress,
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
