import 'package:bookmrk/api/register_api.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/login.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'mobileverification.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();

  /// TextField Controllers.
  TextEditingController _registerFirstName = TextEditingController();
  TextEditingController _registerLastName = TextEditingController();
  TextEditingController _registerEmailAddress = TextEditingController();
  TextEditingController _registerMobileNumber = TextEditingController();
  TextEditingController _registerDateOfBirth = TextEditingController();
  TextEditingController _registerPassword = TextEditingController();
  TextEditingController _registerConfirmPassword = TextEditingController();

  /// form key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<RegisterProvider>(
        builder: (context, _registerProvider, child) => Stack(
          fit: StackFit.expand,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 12, top: 5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 40,
                        color: colorPalette.navyBlue,
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 0),
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 48),
                          child: imagePath.logo,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SimpleTextfield("First Name",
                                controller: _registerFirstName),
                            SizedBox(
                              height: 10,
                            ),
                            SimpleTextfield("Last Name",
                                controller: _registerLastName),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(13),
                                  border: Border.all(
                                      width: 0.0, color: Color(0xff333333))),
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
                                  _registerProvider.selectedGenderRegister =
                                      value.toString();
                                },
                                value:
                                    _registerProvider.selectedGenderRegister ??
                                        "Male",
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SimpleTextfield("Email Address",
                                controller: _registerEmailAddress),
                            SizedBox(
                              height: 10,
                            ),
                            SimpleTextfield("Mobile Number",
                                controller: _registerMobileNumber),
                            SizedBox(
                              height: 10,
                            ),
                            SuffixTextfield(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.parse("1900-01-01"),
                                    maxTime: DateTime.now()
                                        .subtract(Duration(days: 365)),
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
                              obscureText: false,
                              hintText: "Date of Birth",
                              validator: (value) {
                                if (value.toString().split('-')[0] ==
                                    DateTime.now().toString().split("-")[0]) {
                                  return "Date of Birth can not be current year";
                                } else if (value == "" || value == null) {
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
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SuffixTextfield(
                                hintText: "Password",
                                controller: _registerPassword,
                                obscureText:
                                    _registerProvider.isRegisterPasswordVisible,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _registerProvider
                                            .isRegisterPasswordVisible =
                                        !_registerProvider
                                            .isRegisterPasswordVisible;
                                  },
                                  child: Icon(
                                    _registerProvider.isRegisterPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: colorPalette.navyBlue,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            SuffixTextfield(
                                obscureText:
                                    _registerProvider.isRegisterConfirmPasswordVisible,
                                hintText: "Confirm Password",
                                controller: _registerConfirmPassword,
                                validator: (value) {
                                  if (value != _registerPassword.text) {
                                    return "Password does not match !";
                                  } else if (value.length < 8) {
                                    return "Password is to short! enter at least 8 characters";
                                  } else if (value.length > 15) {
                                    return "Password is to long ! enter maximum 15 characters";
                                  }
                                  return null;
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    _registerProvider
                                            .isRegisterConfirmPasswordVisible =
                                        !_registerProvider
                                            .isRegisterConfirmPasswordVisible;
                                  },
                                  child: Icon(
                                    _registerProvider.isRegisterConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: colorPalette.navyBlue,
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _registerProvider
                                      .isTermAndConditionAccepted,
                                  onChanged: (value) => _registerProvider
                                      .isTermAndConditionAccepted = value,
                                  checkColor: colorPalette.navyBlue,
                                  activeColor: Colors.white,
                                ),
                                Text(
                                  "Accept Terms and Conditions",
                                  style:
                                      TextStyle(color: colorPalette.navyBlue),
                                ),
                              ],
                            ),
                            Builder(
                              builder: (context) => NavyBlueButton(
                                  context: context,
                                  onClick: () async {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MobileVerification(),
                                      ),
                                    );
//                                     _registerProvider.isRegisterInProcess =
//                                         true;
//                                     // check for terms and conditions accepted or not...
//                                     if (_registerProvider
//                                         .isTermAndConditionAccepted) {
//                                       // check for fields validation...
//                                       if (_formKey.currentState.validate()) {
//                                         // call register use API...
//
//                                         dynamic response =
//                                             await RegisterAPI.registerNewUser(
//                                           firstName: _registerFirstName.text,
//                                           lastName: _registerLastName.text,
//                                           gender: _registerProvider
//                                               .selectedGenderRegister,
//                                           email: _registerEmailAddress.text,
//                                           mobile: _registerMobileNumber.text,
//                                           dob: _registerDateOfBirth.text,
//                                           password: _registerPassword.text,
//                                           confirmPassword:
//                                               _registerConfirmPassword.text,
//                                         );
//                                         if (response['status'] == 200) {
//                                           if (response['response'][0]
//                                                   ['already_exists'] !=
//                                               "0") {
//                                             _registerProvider
//                                                 .isRegisterInProcess = false;
//
//                                             Scaffold.of(context).showSnackBar(
//                                                 getSnackBar(
//                                                     '${response['message']}'));
//                                           } else {
//                                             _registerProvider
//                                                 .isRegisterInProcess = false;
//                                             Navigator.of(context).pushReplacement(
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         MobileVerification()));
//                                           }
//                                         }
//                                       } else {
//                                         _registerProvider.isRegisterInProcess =
//                                             false;
//                                       }
//                                     } else {
//                                       _registerProvider.isRegisterInProcess =
//                                           false;
//
//                                       Scaffold.of(context).showSnackBar(getSnackBar(
//                                           'Please check terms and conditions'));
//                                     }
                                  },
                                  title: "CONTINUE"),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Login())),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Already Registered?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: " Login Here",
                              style: TextStyle(
                                fontSize: 16,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: _registerProvider.isRegisterInProcess,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
