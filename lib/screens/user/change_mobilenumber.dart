import 'package:bookmrk/api/forgot_password_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChangeMobile extends StatefulWidget {
  final String selectedMobileNumber;

  const ChangeMobile({this.selectedMobileNumber});

  @override
  _ChangeMobileState createState() => _ChangeMobileState();
}

class _ChangeMobileState extends State<ChangeMobile> {
  ColorPalette colorPalette = ColorPalette();

  /// TextField Controller...
  TextEditingController _mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mobileNumberController.text = widget.selectedMobileNumber;
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    return Consumer<UserProvider>(
        builder: (_, _userProvider, child) => Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 50, right: 48, top: 40),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobile Number",
                        style: TextStyle(
                            color: colorPalette.darkgrey, fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 48, right: 48, top: 10),
                      child: TextField(
                        controller: _mobileNumberController,
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
                      child: NavyBlueButton(
                          context: context,
                          onClick: () async {
                            _userProvider.isOtpSendingInProgress = true;

                            int userId = prefs.read<int>('userId');
                            dynamic response =
                                await ForgotPasswordAPI.forgotPassword(
                                    _mobileNumberController.text, userId);
                            if (response['status'] == 200) {
                              _userProvider.isOtpSendingInProgress = false;
                              _userProvider.otpForMobileChange =
                                  response['response'][0]['otp'];
                              homeProvider.selectedString = "UserOTP";
                            } else {
                              _userProvider.isOtpSendingInProgress = false;
                              Scaffold.of(context).showSnackBar(
                                  getSnackBar('${response['message']}'));
                            }
                          },
                          title: "NEXT"),
                    ),
                  ],
                ),
                Visibility(
                  visible: _userProvider.isOtpSendingInProgress,
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
