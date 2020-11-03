import 'package:bookmrk/api/forgot_password_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'otpVerification.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  /// TextField Controllers..
  TextEditingController _mobileNumberForgotPassword = TextEditingController();

  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ForgotPasswordProvider>(
          builder: (_, _forgotPasswordProvider, child) => Stack(
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
                          onPressed: () => Navigator.pop(context),
                          iconSize: 40,
                          color: colorPalette.navyBlue,
                          icon: Icon(Icons.arrow_back_ios),
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Text(
                          "Forgot Password",
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
                      controller: _mobileNumberForgotPassword,
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
                      builder: (context) => Consumer<RegisterProvider>(
                        builder: (_, _registerProvider, child) =>
                            NavyBlueButton(
                                context: context,
                                onClick: () async {
                                  //
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             OtpVerification()));

                                  _forgotPasswordProvider
                                          .isMobileNumberCheckingForgotPassword =
                                      true;
                                  if (_mobileNumberForgotPassword.text != "" &&
                                      _mobileNumberForgotPassword.text !=
                                          null) {
                                    int userId = prefs.read<int>('userId');

                                    dynamic response =
                                        await ForgotPasswordAPI.forgotPassword(
                                            _mobileNumberForgotPassword.text,
                                            userId);

                                    if (response['status'] == 200) {
                                      _forgotPasswordProvider
                                              .isMobileNumberCheckingForgotPassword =
                                          false;

                                      _forgotPasswordProvider
                                              .forgotPasswordMobile =
                                          _mobileNumberForgotPassword.text;
                                      _forgotPasswordProvider
                                              .forgotPasswordOTP =
                                          response['response'][0]['otp']
                                              .toString();
                                      _registerProvider
                                              .isOTPVerificationPageFromRegisterUser =
                                          false;

                                      prefs.write(
                                          'userId',
                                          int.parse(
                                              '${response['response'][0]['user_id'].toString()}'));
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  OtpVerification()));
                                    } else {
                                      _forgotPasswordProvider
                                              .isMobileNumberCheckingForgotPassword =
                                          false;

                                      Scaffold.of(context).showSnackBar(
                                          getSnackBar(
                                              '${response['message']}'));
                                    }
                                  } else {
                                    _forgotPasswordProvider
                                            .isMobileNumberCheckingForgotPassword =
                                        false;

                                    Scaffold.of(context).showSnackBar(
                                        getSnackBar(
                                            'Please fill mobile number'));
                                  }
                                },
                                title: "NEXT"),
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                  visible: _forgotPasswordProvider
                      .isMobileNumberCheckingForgotPassword,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(colorPalette.navyBlue),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
