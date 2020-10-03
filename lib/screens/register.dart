import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/screens/login.dart';
import 'package:bookmrk/screens/mobileverification.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SimpleTextfield("First Name"),
                      SizedBox(
                        height: 10,
                      ),
                      SimpleTextfield("Last Name"),
                      SizedBox(
                        height: 10,
                      ),
                      SuffixTextfield(
                          hintText: "Select Your gender",
                          suffixIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: colorPalette.midGrey,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      SimpleTextfield("Email Address"),
                      SizedBox(
                        height: 10,
                      ),
                      SimpleTextfield("Mobile Number"),
                      SizedBox(
                        height: 10,
                      ),
                      SuffixTextfield(
                          hintText: "Date of Birth",
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: colorPalette.navyBlue,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      SuffixTextfield(
                          hintText: "Password",
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: colorPalette.navyBlue,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      SuffixTextfield(
                          hintText: "Confirm Password",
                          suffixIcon: Icon(
                            Icons.remove_red_eye,
                            color: colorPalette.navyBlue,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                          ),
                          Text(
                            "Accept Terms and Conditions",
                            style: TextStyle(color: colorPalette.navyBlue),
                          ),
                        ],
                      ),
                      NavyBlueButton(
                          context: context,
                          onClick: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => MobileVerification())),
                          title: "CONTINUE")
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login())),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
