import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserOTP extends StatefulWidget {
  @override
  _UserOTPState createState() => _UserOTPState();
}

class _UserOTPState extends State<UserOTP> {
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

  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
        builder: (_, _userProvider, child) => Stack(
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
                    NavyBlueButton(
                        context: context,
                        onClick: () async {
                          _userProvider.isOtpVerifyingInProgress = true;
                          var otp =
                              "${_otp1.text}${_otp2.text}${_otp3.text}${_otp4.text}";
                          if (otp.length >= 4) {
                            /// when forgot password !
                            if (otp == _userProvider.otpForMobileChange) {
                              int userId = prefs.read<int>('userId');
                              dynamic response =
                                  await UserAPI.changeUserProfileMobilNumber(
                                      userId.toString(),
                                      _userProvider.mobileNumberToChange);
                              if (response['status'] == 200) {
                                _userProvider.isOtpVerifyingInProgress = false;
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .selectedString = "EditProfile";
                              } else {
                                _userProvider.isOtpVerifyingInProgress = false;
                                Scaffold.of(context).showSnackBar(
                                    getSnackBar('${response['message']}'));
                              }
                            } else {
                              _userProvider.isOtpVerifyingInProgress = false;
                              Scaffold.of(context).showSnackBar(
                                  getSnackBar('OTP does not match'));
                            }
                          } else {
                            _userProvider.isOtpVerifyingInProgress = false;

                            Scaffold.of(context).showSnackBar(
                                getSnackBar('Please fill valid OTP !'));
                          }
                        },
                        title: "VERIFY")
                  ],
                ),
                Visibility(
                  visible: _userProvider.isOtpVerifyingInProgress,
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
