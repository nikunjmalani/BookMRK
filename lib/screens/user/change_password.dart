import 'package:bookmrk/api/register_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resetPassword.dart';

class ChangePassword extends StatefulWidget {
  final String userMobileNumber;

  const ChangePassword({this.userMobileNumber});

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ImagePath imagePath = ImagePath();
  ColorPalette colorPalette = ColorPalette();

  /// TextField controller for otp
  TextEditingController _otp1 = TextEditingController();
  TextEditingController _otp2 = TextEditingController();
  TextEditingController _otp3 = TextEditingController();
  TextEditingController _otp4 = TextEditingController();

  /// Focus Node for change otp box
  FocusNode _otpF1 = FocusNode();
  FocusNode _otpF2 = FocusNode();
  FocusNode _otpF3 = FocusNode();
  FocusNode _otpF4 = FocusNode();

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    return Consumer<ForgotPasswordProvider>(
        builder: (_, _forgotPasswordProvider, child) => Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      height: 250,
                      width: 250,
                      child: imagePath.otp,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: 52,
                        right: 48,
                        top: 50,
                      ),
                      child: Text(
                        "Please enter verification code",
                        style: TextStyle(
                          fontSize: 18,
                          color: colorPalette.darkgrey,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 48, right: 48, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OtpBox(context, _otp1, _otpF1),
                          OtpBox(context, _otp2, _otpF2),
                          OtpBox(context, _otp3, _otpF3),
                          OtpBox(context, _otp4, _otpF4),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 40, right: 40, top: 20),
                      child: Text(
                        "We have sent verification code on registered mobile number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: colorPalette.midGrey, fontSize: 13.6),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 40, right: 40, top: 40, bottom: 30),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Resend code",
                              style: TextStyle(
                                fontSize: 18,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                            TextSpan(
                              text: " 00:00",
                              style: TextStyle(
                                fontSize: 18,
                                color: colorPalette.midGrey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Builder(
                      builder: (context) => Consumer<RegisterProvider>(
                        builder: (_, _registerProvider, child) =>
                            NavyBlueButton(
                                context: context,
                                onClick: () async {
                                  _forgotPasswordProvider
                                      .isOTPVerificationInProgress = true;
                                  var otp =
                                      "${_otp1.text}${_otp2.text}${_otp3.text}${_otp4.text}";
                                  if (otp.length >= 4) {
                                    if (_registerProvider
                                        .isOTPVerificationPageFromRegisterUser) {
                                      /// when mobile number verification..
                                      bool login = prefs.read<bool>('isLogin');
                                      int userId;
                                      if (login) {
                                        userId =  prefs.read<int>('userId');
                                      }

                                      dynamic response =
                                          await RegisterAPI.verifyMobileWithOTP(
                                              widget.userMobileNumber,
                                              otp,
                                              userId.toString());

                                      if (response['status'] == 200) {
                                        _forgotPasswordProvider
                                            .forgotPasswordOTP = otp;
                                        _forgotPasswordProvider
                                                .forgotPasswordMobile =
                                            widget.userMobileNumber;
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPassword()));
                                      } else {
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Scaffold.of(context).showSnackBar(
                                            getSnackBar(
                                                '${response['message']}'));
                                      }
                                    } else {
                                      /// when forgot password !
                                      if (otp ==
                                          _forgotPasswordProvider
                                              .forgotPasswordOTP) {
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ResetPassword()));
                                      } else {
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Scaffold.of(context).showSnackBar(
                                            getSnackBar('OTP does not match'));
                                      }
                                    }
                                  } else {
                                    _forgotPasswordProvider
                                        .isOTPVerificationInProgress = false;

                                    Scaffold.of(context).showSnackBar(
                                        getSnackBar('Please fill valid OTP !'));
                                  }
                                },
                                title: "VERIFY"),
                      ),
                    )
                  ],
                ),
                Visibility(
                  visible: _forgotPasswordProvider.isOTPVerificationInProgress,
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
