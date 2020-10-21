import 'package:bookmrk/api/notification_api.dart';
import 'package:bookmrk/model/notification_model.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  /// get all the notification ....
  Future getNotifications() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response =
        await NotificationAPI.getAllNotification(userId.toString());
    NotificationModel _notificationModel = NotificationModel.fromJson(response);
    return _notificationModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(left: 7),
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  height: height / 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xff707070),
                    ),
                    color: snapshot.data.response[index].isSeen == "0"
                        ? Color(0xffe9e9e9)
                        : Colors.white,
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/bellIcon.svg",
                        height: height / 16,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: width / 1.4,
                            child: Text(
                              '${snapshot.data.response[index].msg}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xff000000),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text(
                            '${snapshot.data.response[index].datetime}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 11,
                              color: const Color(0xff717171),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.response.length,
            );
          } else {
            return Container(
              color: Colors.transparent,
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            );
          }
        });
  }
}
