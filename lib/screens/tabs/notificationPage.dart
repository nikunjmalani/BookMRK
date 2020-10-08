import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

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
            color: index < 3 ? Color(0xffe9e9e9) : Colors.white,
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
                  Text(
                    'The order LP152482516 is pickup by Raj Das',
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '12/06/2020 18:22',
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
      itemCount: 8,
    );
  }
}
