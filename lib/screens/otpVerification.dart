import 'dart:async';

import 'package:bookmrk/api/forgot_password_api.dart';
import 'package:bookmrk/api/register_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/forgot_password_provider.dart';
import 'package:bookmrk/provider/register_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/login.dart';
import 'package:bookmrk/screens/resetPassword.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtpVerification extends StatefulWidget {
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  /// TextField controller for otp
  TextEditingController _otp1 = TextEditingController();
  TextEditingController _otp2 = TextEditingController();
  TextEditingController _otp3 = TextEditingController();
  TextEditingController _otp4 = TextEditingController();

  Timer timer;

  /// Focus Node for change otp box
  FocusNode _otpF1 = FocusNode();
  FocusNode _otpF2 = FocusNode();
  FocusNode _otpF3 = FocusNode();
  FocusNode _otpF4 = FocusNode();

  ImagePath imagePath = ImagePath();
  ColorPalette colorPalette = ColorPalette();

  setTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {

      Provider.of<RegisterProvider>(context, listen: false)
          .timeRemainingInTimer = t.tick;
      if (t.tick == 30) {
        timer.cancel();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ForgotPasswordProvider>(
          builder: (_, _forgotPasswordProvider, child) => Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
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
                            "OTP Verification",
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
                      child: imagePath.otp,
                    ),
                    Container(
                      alignment: Alignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          OtpBox(context, _otp1, _otpF1),
                          OtpBox(context, _otp2, _otpF2),
                          OtpBox(context, _otp3, _otpF3),
                          Consumer<RegisterProvider>(
                            builder: (_, _registerProvider, child)=>OtpBox(context, _otp4, _otpF4, doneCallBack: () async {
                              _forgotPasswordProvider
                                  .isOTPVerificationInProgress = true;
                              var otp =
                                  "${_otp1.text}${_otp2.text}${_otp3.text}${_otp4.text}";
                              if (otp.length >= 4) {
                                if (_registerProvider
                                    .isOTPVerificationPageFromRegisterUser) {

                                  /// when mobile number verification..

                                  int userId = prefs.read<int>('userId');

                                  dynamic response =
                                  await RegisterAPI.verifyMobileWithOTP(
                                      _registerProvider
                                          .verificationMobileNumberForRegister,
                                      otp,
                                      userId.toString());

                                  if (response['status'] == 200) {
                                    _forgotPasswordProvider
                                        .forgotPasswordFromPage =
                                    "MobileVerification";
                                    _forgotPasswordProvider
                                        .isOTPVerificationInProgress =
                                    false;
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Login()));
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
                                        .forgotPasswordFromPage =
                                    "ForgotPassword";
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
                            }),
                          ),
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
                    Builder(
                      builder: (context) => Padding(
                        padding: const EdgeInsets.only(
                            left: 40, right: 40, top: 40, bottom: 30),
                        child: Consumer<ForgotPasswordProvider>(
                          builder: (_, _forgotPassword, child) =>
                              Consumer<RegisterProvider>(
                            builder: (_, _registerProvider, child) =>
                                GestureDetector(
                              onTap: _registerProvider.timeRemainingInTimer ==
                                      30
                                  ? () async {
                                      _forgotPasswordProvider
                                          .isOTPVerificationInProgress = true;

                                      int userId = prefs.read<int>('userId');

                                      dynamic response = await ForgotPasswordAPI
                                          .forgotPassword(
                                              _forgotPassword
                                                  .forgotPasswordMobile,
                                              userId);

                                      if (response['status'] == 200) {
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        setTimer();
                                        Scaffold.of(context).showSnackBar(
                                            getSnackBar('OTP Sent !'));
                                      } else {
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Scaffold.of(context).showSnackBar(
                                            getSnackBar(
                                                '${response['message']}'));
                                      }
                                    }
                                  : () {},
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    _registerProvider.timeRemainingInTimer == 30
                                        ? TextSpan(
                                            text: "Resend code ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: colorPalette.navyBlue,
                                            ),
                                          )
                                        : TextSpan(
                                            text: "Resend after ",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: colorPalette.navyBlue,
                                            ),
                                          ),
                                    _registerProvider.timeRemainingInTimer != 30
                                        ? TextSpan(
                                            text:
                                                " 00:${30 - (_registerProvider.timeRemainingInTimer)}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: colorPalette.midGrey,
                                            ),
                                          )
                                        : TextSpan(),
                                  ],
                                ),
                              ),
                            ),
                          ),
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

                                      int userId = prefs.read<int>('userId');

                                      dynamic response =
                                          await RegisterAPI.verifyMobileWithOTP(
                                              _registerProvider
                                                  .verificationMobileNumberForRegister,
                                              otp,
                                              userId.toString());

                                      if (response['status'] == 200) {
                                        _forgotPasswordProvider
                                                .forgotPasswordFromPage =
                                            "MobileVerification";
                                        _forgotPasswordProvider
                                                .isOTPVerificationInProgress =
                                            false;
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Login()));
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
                                                .forgotPasswordFromPage =
                                            "ForgotPassword";
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
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _forgotPasswordProvider.isOTPVerificationInProgress,
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
