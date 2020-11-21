import 'package:bookmrk/api/notification_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/notification_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  /// get all the notification ....
  Future getNotifications() async {
    int userId = prefs.read<int>('userId');
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
            return Consumer<HomeScreenProvider>(
              builder: (_, _homeScreenProvider, child) => Stack(
                children: [
                  snapshot.data.count != 0
                      ? Column(
                          children: [
                            Container(
                              height: 30,
                              width: width,
                              padding: EdgeInsets.only(right: 20, top: 10),
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () async {
                                  _homeScreenProvider
                                      .markAllAsReadNotification = true;

                                  // dynamic response = await NotificationAPI.readNotification();
                                  for (int i = 0;
                                      i < snapshot.data.response.length;
                                      i++) {
                                    int userId = prefs.read<int>('userId');

                                    print("userId : $userId");
                                    if (snapshot.data.response[i].isSeen ==
                                        "0") {
                                      dynamic response = await NotificationAPI
                                          .notificationRead(
                                              userId.toString(),
                                              snapshot.data.response[i]
                                                  .notificationId
                                                  .toString());

                                      print(response);
                                    }
                                  }

                                  _homeScreenProvider
                                      .markAllAsReadNotification = false;
                                },
                                child: Text(
                                  'Mark All As Read',
                                  style: TextStyle(
                                      color: colorPalette.navyBlue,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 7, top: 10, bottom: 10),
                                    margin: EdgeInsets.only(
                                        top: 15, left: 15, right: 15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color(0xff707070),
                                      ),
                                      color: snapshot.data.response[index]
                                                  .isSeen ==
                                              "0"
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: width / 1.4,
                                              child: Text(
                                                '${snapshot.data.response[index].msg}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(height: 5.0),
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
                              ),
                            ),
                            SizedBox(height: 70,)
                          ],
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/no_notification.svg',
                                height: 100,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                'No Notification !',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: colorPalette.navyBlue,
                                ),
                              ),
                              SizedBox(height: 100.0),
                            ],
                          ),
                        ),
                  Visibility(
                    visible: _homeScreenProvider.markAllAsReadNotification,
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
              ),
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
