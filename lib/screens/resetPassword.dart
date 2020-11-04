import 'package:bookmrk/api/reset_password_api.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/reset_password_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onBoarding.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  /// TextFields for reset password
  TextEditingController _resetNewPassword = TextEditingController();
  TextEditingController _resetConfirmPassword = TextEditingController();

  /// Form key to validate form
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ImagePath imagePath = ImagePath();
  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ResetPasswordProvider>(
          builder: (_, _resetPasswordProvider, child) => Stack(
            fit: StackFit.expand,
            children: [
              Form(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
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
                              flex: 3,
                            ),
                            Text(
                              "Reset Password",
                              style: TextStyle(
                                  color: colorPalette.navyBlue, fontSize: 24),
                            ),
                            Spacer(
                              flex: 6,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 250,
                        width: 250,
                        child: imagePath.reset,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 52,
                          right: 48,
                          top: 50,
                        ),
                        child: Text(
                          "Please enter New Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: colorPalette.darkgrey,
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 48, right: 48, top: 20),
                        child: TextFormField(
                          validator: (value) {
                            if (value.length < 8) {
                              return "Password is to short! enter at least 8 characters";
                            } else if (value.length > 15) {
                              return "Password is to long ! enter maximum 15 characters";
                            }
                            return null;
                          },
                          obscureText:
                              _resetPasswordProvider.isResetPasswordVisible,
                          controller: _resetNewPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            hintText: "New password",
                            hintStyle: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _resetPasswordProvider.isResetPasswordVisible =
                                    !_resetPasswordProvider
                                        .isResetPasswordVisible;
                              },
                              child: Icon(
                                _resetPasswordProvider.isResetPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 48, right: 48, top: 20, bottom: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value != _resetNewPassword.text) {
                              return "Password does not match !";
                            } else if (value.length < 8) {
                              return "Password is to short! enter at least 8 characters";
                            } else if (value.length > 15) {
                              return "Password is to long ! enter maximum 15 characters";
                            }
                            return null;
                          },
                          obscureText:
                              _resetPasswordProvider.isResetPasswordVisible,
                          controller: _resetConfirmPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(13),
                            ),
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                _resetPasswordProvider.isResetPasswordVisible =
                                    !_resetPasswordProvider
                                        .isResetPasswordVisible;
                              },
                              child: Icon(
                                _resetPasswordProvider.isResetPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Consumer<HomeScreenProvider>(
                        builder: (_, _homeScreenProvider, child) => Builder(
                            builder: (context) =>
                                Consumer<ForgotPasswordProvider>(
                                  builder: (_, _forgotPasswordProvider, child) =>
                                      NavyBlueButton(
                                          context: context,
                                          onClick: () async {
                                            _resetPasswordProvider
                                                .isPasswordResetInProcess = true;
                                            // check for the password validation
                                            if (_formKey.currentState
                                                .validate()) {
                                              dynamic response =
                                                  await ResetPasswordAPI
                                                      .resetPassword(
                                                _forgotPasswordProvider
                                                    .forgotPasswordOTP,
                                                _forgotPasswordProvider
                                                    .forgotPasswordMobile,
                                                _resetNewPassword.text,
                                                _resetConfirmPassword.text,
                                              );
                                              if (response['status'] == 200) {
                                                if (_forgotPasswordProvider
                                                        .forgotPasswordFromPage ==
                                                    "Account") {
                                                  _resetPasswordProvider
                                                          .isPasswordResetInProcess =
                                                      false;

                                                  _homeScreenProvider
                                                      .selectedString = "Account";
                                                  Navigator.pop(context);
                                                } else if (_forgotPasswordProvider
                                                        .forgotPasswordFromPage ==
                                                    "ForgotPassword") {
                                                  _resetPasswordProvider
                                                          .isPasswordResetInProcess =
                                                      false;

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OnBoarding()));
                                                } else if (_forgotPasswordProvider
                                                        .forgotPasswordFromPage ==
                                                    "MobileVerification") {
                                                  _resetPasswordProvider
                                                          .isPasswordResetInProcess =
                                                      false;

                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OnBoarding()));
                                                }
                                              } else {
                                                _resetPasswordProvider
                                                        .isPasswordResetInProcess =
                                                    false;

                                                Scaffold.of(context).showSnackBar(
                                                    getSnackBar(
                                                        '${response['message']}'));
                                              }
                                            } else {
                                              _resetPasswordProvider
                                                      .isPasswordResetInProcess =
                                                  false;
                                            }
                                          },
                                          title: "RESET"),
                                )),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _resetPasswordProvider.isPasswordResetInProcess,
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
