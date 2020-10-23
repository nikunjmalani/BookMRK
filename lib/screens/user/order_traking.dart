import 'dart:async';

import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/model/track_order_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/map_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderTracking extends StatefulWidget {
  final String orderIdToTrack;

  const OrderTracking({this.orderIdToTrack});

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  ColorPalette colorPalette = ColorPalette();

  /// get Information to track order details...
  Future getTrackingInformation() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await OrderHistoryAPI.getTrackingDetailsOfOrder(
        userId.toString(), widget.orderIdToTrack);
    TrackOrderModel _trackOrderModel = TrackOrderModel.fromJson(response);
    print(response);
    return _trackOrderModel;
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return FutureBuilder(
            future: getTrackingInformation(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      child: Text(
                        snapshot.data.response[0].inTransit == "1"
                            ? 'Live Tracking'
                            : 'Live tracking will be enable when order will in transit',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: const Color(0xff3a3a3c),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    snapshot.data.response[0].inTransit == "1"
                        ? Container(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Consumer<MapProvider>(
                                builder: (_, _mapProvider, child) => GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      target: _mapProvider.selectedLatLng,
                                      zoom: 14.0),
                                  mapType: MapType.terrain,
                                  onTap: (value) {
                                    print(value);
                                    _mapProvider.selectedLatLng = value;
                                  },
                                  minMaxZoomPreference:
                                      MinMaxZoomPreference(14, 17),
                                  mapToolbarEnabled: true,
                                  markers: {
                                    Marker(
                                      markerId: MarkerId("1"),
                                      visible: true,
                                      position: _mapProvider.selectedLatLng,
                                      draggable: true,
                                    )
                                  },
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              OrderTrackIcons(
                                  context: context,
                                  title: "Order Confirmed",
                                  time:
                                      "${snapshot.data.response[0].orderConfirmedDate}",
                                  flag: snapshot.data.response[0]
                                              .orderConfirmed ==
                                          "1"
                                      ? true
                                      : false),
                              DottedDivider(),
                              OrderTrackIcons(
                                  context: context,
                                  title: "Order Packed",
                                  time:
                                      "${snapshot.data.response[0].orderPackedDate}",
                                  flag: snapshot.data.response[0].orderPacked ==
                                          "1"
                                      ? true
                                      : false),
                              DottedDivider(),
                              OrderTrackIcons(
                                  context: context,
                                  title: "Order Pickup",
                                  time:
                                      "${snapshot.data.response[0].orderPickupDate}",
                                  flag: snapshot.data.response[0].orderPickup ==
                                          "1"
                                      ? true
                                      : false),
                              DottedDivider(),
                              OrderTrackIcons(
                                  context: context,
                                  title: "In Transit",
                                  time:
                                      "${snapshot.data.response[0].inTransitDate}",
                                  flag:
                                      snapshot.data.response[0].inTransit == "1"
                                          ? true
                                          : false),
                              DottedDivider(),
                              OrderTrackIcons(
                                  context: context,
                                  title: "Out Of Delivery",
                                  time:
                                      "${snapshot.data.response[0].outOfDeliveryDate}",
                                  flag:
                                      snapshot.data.response[0].outOfDelivery ==
                                              "1"
                                          ? true
                                          : false),
                              DottedDivider(),
                              OrderTrackIcons(
                                  context: context,
                                  title: "Delivered",
                                  time:
                                      "${snapshot.data.response[0].deliveredDate}",
                                  flag:
                                      snapshot.data.response[0].delivered == "1"
                                          ? true
                                          : false),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                      text: 'your verification code is ',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        color: const Color(0xff3a3a3c),
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${snapshot.data.response[0].userVerifyCode} ',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        color: const Color(0xff3a3a3c),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
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
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                    ),
                  ),
                );
              }
            });
      },
    );
  }
}

Widget OrderTrackIcons({context, flag, title, time, onTap}) {
  return Row(
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
