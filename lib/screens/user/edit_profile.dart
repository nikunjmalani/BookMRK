import 'dart:convert';
import 'dart:io';

import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/model/user_profile_info_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ColorPalette colorPalette = ColorPalette();

  /// TextFields...
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  String profileImage = "";

  ///get user details ...
  Future getCurrentDetailsOfUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await UserAPI.getAllUserInformation(userId.toString());
    UserProfileInfoModel _userProfileModel =
        UserProfileInfoModel.fromJson(response);

    _firstNameController.text = _userProfileModel.response[0].fname;
    _lastNameController.text = _userProfileModel.response[0].lname;
    _dateOfBirthController.text = _userProfileModel.response[0].dob.toString();
    _emailAddressController.text = _userProfileModel.response[0].email;
    _mobileNumberController.text = _userProfileModel.response[0].mobile;
    profileImage = _userProfileModel.response[0].profilePic;
  }

  @override
  void initState() {
    super.initState();
    getCurrentDetailsOfUser();
  }

  void uploadImage() async {
    FilePickerResult pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    dynamic bytes = File(pickedFile.files[0].path).readAsBytesSync();
    dynamic data = base64Encode(bytes);
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response =
        await UserAPI.updateUserProfileImage(userId.toString(), data);

    print(response);
    if (response['status'] == 200) {
      print('upload success !');
      getCurrentDetailsOfUser();
      print(profileImage);
    } else {
      print('upload failed !');
    }
  }

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
            SizedBox(height: 10.0),
            CachedNetworkImage(
              imageUrl: profileImage,
              height: height / 7,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: height / 12,
                backgroundColor: colorPalette.navyBlue,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, Str) => CircleAvatar(
                radius: height / 12,
                backgroundColor: colorPalette.navyBlue,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
              errorWidget: (context, err, sTrace) => CircleAvatar(
                radius: height / 12,
                backgroundColor: colorPalette.navyBlue,
                child: Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 100.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Text(
                'Change Profile',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xff301869),
                ),
                textAlign: TextAlign.left,
              ),
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
