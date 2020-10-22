import 'dart:convert';
import 'dart:io';

import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/model/user_profile_info_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ColorPalette colorPalette = ColorPalette();
  RegisterProvider _registerProvider;
  Permission _userStoragePermission = Permission.storage;

  /// TextFields...
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _registerDateOfBirth = TextEditingController();

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
    _registerDateOfBirth.text = _userProfileModel.response[0].dob.toString();

    _registerProvider.selectedGenderRegister =
        _userProfileModel.response[0].gender;
  }

  checkPermission() async {
    if (await _userStoragePermission.isGranted) {
      return uploadImage();
    } else {
      _userStoragePermission.request().then((value) {
        if (value.isGranted) {
          return uploadImage();
        } else {
          Scaffold.of(context)
              .showSnackBar(getSnackBar('Please Give Permission !'));
        }
      });
    }
  }

  getProfilePic() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await UserAPI.getAllUserInformation(userId.toString());
    UserProfileInfoModel _userProfileModel =
        UserProfileInfoModel.fromJson(response);

    return _userProfileModel;
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

    if (response['status'] == 200) {
      Scaffold.of(context)
          .showSnackBar(getSnackBar('Image uploaded Successfully !'));
    } else {
      Scaffold.of(context).showSnackBar(
          getSnackBar('failed to upload image please try again !'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    _registerProvider = Provider.of<RegisterProvider>(context);
    return Consumer<UserProvider>(
        builder: (_, _userProvider, child) => Stack(
              fit: StackFit.expand,
              children: [
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        FutureBuilder(
                            future: getProfilePic(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  imageUrl:
                                      snapshot.data.response[0].profilePic,
                                  height: height / 7,
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
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
                                  errorWidget: (context, err, sTrace) =>
                                      CircleAvatar(
                                    radius: height / 12,
                                    backgroundColor: colorPalette.navyBlue,
                                    child: Icon(
                                      Icons.person_outline,
                                      color: Colors.white,
                                      size: 100.0,
                                    ),
                                  ),
                                );
                              } else {
                                return CircleAvatar(
                                  radius: height / 14,
                                  backgroundColor: colorPalette.navyBlue,
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Colors.white,
                                    size: 100.0,
                                  ),
                                );
                              }
                            }),
                        SizedBox(height: 5.0),
                        GestureDetector(
                          onTap: () {
                            checkPermission();
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
                            AddressTextFields(
                                width: width / 2.25,
                                title: "First Name",
                                controller: _firstNameController),
                            AddressTextFields(
                                width: width / 2.25,
                                title: "Last Name",
                                controller: _lastNameController),
                          ],
                        ),
                        SizedBox(
                          height: width / 20,
                        ),
                        Consumer<RegisterProvider>(
                          builder: (_, _registerProvider, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Date Of Birth",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: const Color(0x80515c6f),
                                      letterSpacing: 0.9100000000000001,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width / 2.25,
                                    child: SuffixTextfield(
                                      obscureText: false,
                                      hintText: "Date of Birth",
                                      validator: (value) {
                                        if (value.toString().split('-')[0] ==
                                            DateTime.now()
                                                .toString()
                                                .split("-")[0]) {
                                          return "Date of Birth can not be current year";
                                        } else if (value == "" ||
                                            value == null) {
                                          return "Please fill Date of Birth";
                                        }
                                        try {
                                          DateTime.parse(value);
                                        } catch (e) {
                                          return "Please select valid Date";
                                        }
                                        return null;
                                      },
                                      controller: _registerDateOfBirth,
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime:
                                                  DateTime.parse("1900-01-01"),
                                              maxTime: DateTime.now().subtract(
                                                  Duration(days: 365)),
                                              onChanged: (date) {
                                            _registerDateOfBirth.text =
                                                date.toString().split(" ")[0];
                                          }, onConfirm: (date) {
                                            _registerDateOfBirth.text =
                                                date.toString().split(" ")[0];
                                          },
                                              currentTime: DateTime.now(),
                                              locale: LocaleType.en);
                                        },
                                        child: Icon(
                                          Icons.calendar_today,
                                          color: colorPalette.navyBlue,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      color: const Color(0x80515c6f),
                                      letterSpacing: 0.9100000000000001,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width / 2.25,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(13),
                                        border: Border.all(
                                            width: 0.0,
                                            color: Color(0xff333333))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: DropdownButton(
                                      items: [
                                        DropdownMenuItem(
                                          child: Text(
                                            "Male",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          value: "Male",
                                        ),
                                        DropdownMenuItem(
                                          child: Text(
                                            "Female",
                                            style: TextStyle(fontSize: 16.0),
                                          ),
                                          value: "Female",
                                        )
                                      ],
                                      isExpanded: true,
                                      underline: SizedBox(),
                                      onChanged: (value) {
//
                                        _registerProvider
                                                .selectedGenderRegister =
                                            value.toString();
                                      },
                                      value: _registerProvider
                                                      .selectedGenderRegister ==
                                                  "" ||
                                              _registerProvider
                                                      .selectedGenderRegister ==
                                                  null
                                          ? "Male"
                                          : _registerProvider
                                              .selectedGenderRegister,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: width / 20,
                        ),
                        AddressTextFields(
                            width: width,
                            title: "Email Address",
                            controller: _emailAddressController),
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
                              controller: _mobileNumberController,
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
                                _userProvider.mobileNumberToChange =
                                    _mobileNumberController.text;
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
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
                        Consumer<RegisterProvider>(
                          builder: (_, _registerProvider, child) =>
                              BlueLongButton(
                            color: colorPalette.navyBlue,
                            title: "Save Update",
                            height: height,
                            onTap: () async {
                              _userProvider.isProfileUpdateInProgress = true;

                              SharedPreferences _prefs =
                                  await SharedPreferences.getInstance();
                              int userId = _prefs.getInt('userId');
                              dynamic response =
                                  await UserAPI.changeUserInformation(
                                      userId.toString(),
                                      _firstNameController.text,
                                      _lastNameController.text,
                                      _dateOfBirthController.text,
                                      _registerProvider.selectedGenderRegister,
                                      _emailAddressController.text);

                              if (response['status'] == 200) {
                                _userProvider.isProfileUpdateInProgress = false;

                                /// profile updated successfully !
                                getCurrentDetailsOfUser();
                              } else {
                                _userProvider.isProfileUpdateInProgress = false;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: width / 1.6,
                        )
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: _userProvider.isProfileUpdateInProgress,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(colorPalette.navyBlue),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }
}
