
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Text(
            'Privacy Policy',
            style: TextStyle(color: colorPalette.navyBlue, fontSize: 18.0),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: colorPalette.navyBlue,
            ),
          ),
        ),
        body: WebView(
          initialUrl: '$kSiteURL/terms_and_conditions',
        ),
      ),
    );
  }
}
