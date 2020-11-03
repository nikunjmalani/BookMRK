import 'package:bookmrk/api/feedback_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  /// TextField
  TextEditingController _feedBackController = TextEditingController();

  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, _userProvider, child) => Stack(
        fit: StackFit.expand,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: const Color(0xff747474),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: colorPalette.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: _feedBackController,
                  maxLines: 9,
                  decoration: InputDecoration(
                    hintMaxLines: 7,
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Mention Feedback Here.",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                child: NavyBlueButton(
                  title: "SEND",
                  context: context,
                  onClick: () async {
                    _userProvider.feedbackInProgress = true;

                    int userId = prefs.read<int>('userId');
                    dynamic response = await FeedBackAPI.giveFeedBack(
                        userId.toString(), _feedBackController.text);
                    if (response['status'] == 200) {
                      _userProvider.feedbackInProgress = false;
                      Scaffold.of(context).showSnackBar(
                          getSnackBar('feedback submit successfully !'));
                    } else {
                      _userProvider.feedbackInProgress = false;
                      Scaffold.of(context)
                          .showSnackBar(getSnackBar('${response['message']}'));
                    }
                  },
                ),
              )
            ],
          ),
          Visibility(
            visible: _userProvider.feedbackInProgress,
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
    );
  }
}
