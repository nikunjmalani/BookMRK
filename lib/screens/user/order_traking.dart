import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OrderTracking extends StatefulWidget {
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Live Tracking',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: const Color(0xff3a3a3c),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Image.asset("assets/images/map.png"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Order Status',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: const Color(0xff3a3a3c),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      OrderTrackIcons(
                          onTap: () => homeProvider.confirmedFlag =
                              !homeProvider.confirmedFlag,
                          context: context,
                          title: "Order Confirmed",
                          time: "17-06-2020 12:10",
                          flag: data.confirmedFlag),
                      DottedDivider(),
                      OrderTrackIcons(
                          onTap: () => homeProvider.packedFlag =
                              !homeProvider.packedFlag,
                          context: context,
                          title: "Order Packed",
                          time: "17-06-2020 12:10",
                          flag: data.packedFlag),
                      DottedDivider(),
                      OrderTrackIcons(
                          onTap: () => homeProvider.pickupFlag =
                              !homeProvider.pickupFlag,
                          context: context,
                          title: "Order Pickup",
                          time: "17-06-2020 12:10",
                          flag: data.pickupFlag),
                      DottedDivider(),
                      OrderTrackIcons(
                          onTap: () => homeProvider.inTransistFlag =
                              !homeProvider.inTransistFlag,
                          context: context,
                          title: "In Transit",
                          time: "17-06-2020 12:10",
                          flag: data.inTransistFlag),
                      DottedDivider(),
                      OrderTrackIcons(
                          onTap: () => homeProvider.outForDeliveryFlag =
                              !homeProvider.outForDeliveryFlag,
                          context: context,
                          title: "Out For Delivery",
                          time: "17-06-2020 12:10",
                          flag: data.outForDeliveryFlag),
                      DottedDivider(),
                      OrderTrackIcons(
                          onTap: () => homeProvider.deliveredFlag =
                              !homeProvider.deliveredFlag,
                          context: context,
                          title: "Delivered",
                          time: "17-06-2020 12:10",
                          flag: data.deliveredFlag),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

Widget OrderTrackIcons({context, flag, title, time, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        flag
            ? SvgPicture.asset(
                "assets/icons/check.svg",
                height: 50,
                width: 50,
              )
            : SvgPicture.asset(
                "assets/icons/notCheck.svg",
                height: 50,
                width: 50,
              ),
        SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 18,
                color: const Color(0xff3a3a3c),
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              time,
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 14,
                color: const Color(0xffb8b8b8),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        )
      ],
    ),
  );
}

Widget DottedDivider() {
  return Column(
    children: [
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Color(0xff707070),
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Colors.transparent,
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Color(0xff707070),
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Colors.transparent,
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Color(0xff707070),
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Colors.transparent,
          thickness: 4,
          width: 50,
        ),
      ),
      Container(
        alignment: Alignment.centerLeft,
        height: 5,
        child: VerticalDivider(
          color: Color(0xff707070),
          thickness: 4,
          width: 50,
        ),
      ),
    ],
  );
}
