import 'package:bookmrk/api/register_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'otpVerification.dart';

class MobileVerification extends StatefulWidget {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {
  /// Mobile verify TextField
  TextEditingController _mobileVerification = TextEditingController();

  ColorPalette colorPalette = ColorPalette();

  autoFillFields(){
    _mobileVerification.text = Provider.of<RegisterProvider>(context, listen: false).verificationMobileNumberForRegister;
  }

  @override
  void initState() {
    super.initState();
    autoFillFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<RegisterProvider>(
          builder: (_, _registerProvider, child) => Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 12, top: 5, right: 12),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 40,
                          color: colorPalette.navyBlue,
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          "Mobile Number Verification",
                          style: TextStyle(
                              color: colorPalette.navyBlue, fontSize: 24),
                        ),
                        Spacer(
                          flex: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 48, top: 40),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mobile Number",
                      style:
                          TextStyle(color: colorPalette.darkgrey, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 48, right: 48, top: 10),
                    child: TextField(
                      controller: _mobileVerification,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Enter Mobile Number",
                        hintStyle: TextStyle(
                          color: colorPalette.lightGrey,
                          fontSize: 16,
                        ),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "+91",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down),
                            SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 48, right: 48),
                    child: Text(
                      "We will send verification code on entered mobile number",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: colorPalette.darkgrey, fontSize: 13.9),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Builder(
                      builder: (context) => NavyBlueButton(
                          context: context,
                          onClick: () async {
                            _registerProvider
                                    .verificationMobileNumberForRegister =
                                _mobileVerification.text;
                            _registerProvider.isMobileVerificationProcess =
                                true;
                            if (_mobileVerification.text != "" &&
                                _mobileVerification.text != null) {
                              int userId = prefs.read<int>('userId');
                              dynamic response =
                                  await RegisterAPI.verifyMobileNumber(
                                      _mobileVerification.text,
                                      userId.toString());

                              if (response['status'] == 200) {
                                try {
                                  _registerProvider
                                      .isMobileVerificationProcess = false;
                                  _registerProvider.mobileVerificationOTP =
                                      response['response'][0]['otp'].toString();

                                  if (response['response'][0]['otp'] != null) {

                                    _registerProvider.mobileVerificationOTP =
                                        response['response'][0]['otp'].toString();



                                    _registerProvider
                                            .isOTPVerificationPageFromRegisterUser =
                                        true;

                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OtpVerification()));
                                  } else {

                                    _registerProvider
                                        .isMobileVerificationProcess = false;
                                    Scaffold.of(context).showSnackBar(
                                        getSnackBar('${response['message']}'));
                                  }
                                } catch (e) {

                                  _registerProvider
                                      .isMobileVerificationProcess = false;
                                  Scaffold.of(context).showSnackBar(
                                      getSnackBar('${response['message']}'));
                                }
                              } else {
                                _registerProvider.isMobileVerificationProcess =
                                    false;

                                Scaffold.of(context).showSnackBar(
                                    getSnackBar('${response['message']}'));
                              }
                            } else {
                              _registerProvider.isMobileVerificationProcess =
                                  false;
                              Scaffold.of(context).showSnackBar(getSnackBar(
                                  'Please fill mobile number to verify !'));
                            }
                          },
                          title: "NEXT"),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _registerProvider.isMobileVerificationProcess,
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
        ),
      ),
    );
  }
}
