import 'dart:io';

import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/api/login_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/login_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/forgotPassword.dart';
import 'package:bookmrk/screens/mobileverification.dart';
import 'package:bookmrk/screens/register.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'homePage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();

  /// TextFields controllers
  TextEditingController _loginEmailAddress = TextEditingController();
  TextEditingController _loginPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Consumer<LoginProvider>(
        builder: (_, _loginProvider, child) => Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      padding: EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 48),
                        child: imagePath.logo,
                      )),
                  SizedBox(
                    height: 120,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: SimpleTextfield("Mobile Number / Email Address",
                        controller: _loginEmailAddress),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      child: SuffixTextfield(
                        hintText: "Password",
                        obscureText: _loginProvider.isPasswordVisible,
                        controller: _loginPassword,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            _loginProvider.isPasswordVisible =
                                !_loginProvider.isPasswordVisible;
                          },
                          child: Icon(
                            _loginProvider.isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: colorPalette.navyBlue,
                          ),
                        ),
                      )),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPassword())),
                    child: Container(
                      margin: EdgeInsets.only(right: 50, top: 10),
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: colorPalette.navyBlue, fontSize: 16),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Builder(
                        builder: (context) => NavyBlueButton(
                            context: context,
                            onClick: () async {
                              _loginProvider.isPasswordChecking = true;

                              dynamic response = await LoginAPI.checkLogin(
                                  email: _loginEmailAddress.text,
                                  password: _loginPassword.text);

                              if (response['status'] == 200) {
                                if (response['data'][0]['is_mobile_verified'] ==
                                    "1") {
                                  prefs.write('isLogin', true);
                                  prefs.write(
                                      'userId',
                                      int.parse(response['data'][0]['user_id']
                                          .toString()));

                                  /// get device information....
                                  DeviceInfoPlugin deviceInfo =
                                      DeviceInfoPlugin();
                                  dynamic deviceId;
                                  dynamic osInfo;
                                  dynamic modelName;
                                  dynamic moreInfo = {
                                    "date": "${DateTime.now()}"
                                  };

                                  if (Platform.isAndroid) {
                                    AndroidDeviceInfo androidInfo =
                                        await deviceInfo.androidInfo;
                                    osInfo = Platform.operatingSystem;
                                    modelName = androidInfo.model;
                                  } else {
                                    IosDeviceInfo iosInfo =
                                        await deviceInfo.iosInfo;
                                    osInfo = Platform.operatingSystem;
                                    modelName = iosInfo.model;
                                  }

                                  /// get firebase token....
                                  await FirebaseMessaging()
                                      .getToken()
                                      .then((value) {
                                    deviceId = value.toString();
                                  });

                                  debugPrint('emulator device id : $deviceId');

                                  int userId = prefs.read<int>('userId');
                                  dynamic updateAppResponse =
                                      await HomePageApi.updateApplicationInfo(
                                          userId.toString(),
                                          deviceId.toString(),
                                          osInfo.toString(),
                                          modelName.toString(),
                                          kAppVersion.toString(),
                                          moreInfo.toString());

                                  _loginProvider.isPasswordChecking = false;

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                } else {
                                  _loginProvider.isPasswordChecking = false;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MobileVerification()));
                                }
                              } else {
                                _loginProvider.isPasswordChecking = false;

                                Scaffold.of(context).showSnackBar(
                                    getSnackBar('${response['message']}'));
                              }
                            },
                            title: "LOGIN"),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Register())),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Don't Have Account?",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: " Register Here",
                              style: TextStyle(
                                fontSize: 16,
                                color: colorPalette.navyBlue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: _loginProvider.isPasswordChecking,
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
