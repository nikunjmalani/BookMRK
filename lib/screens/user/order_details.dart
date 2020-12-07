import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/no_data_cart_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/order_details_model.dart';
import 'package:bookmrk/model/track_order_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  final String orderId;

  OrderDetails(this.orderId);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  ColorPalette colorPalette = ColorPalette();

  /// get orderDetails...
  Future getOrderDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await OrderHistoryAPI.getOrderDetailsFromOrderId(
        widget.orderId.toString(), userId.toString());
    if (response['response'][0].length == 0) {
      NoDataCartModel _noOrderModel = NoDataCartModel.fromJson(response);
      return _noOrderModel;
    } else {
      OrderDetailsModel _orderDetailsModel =
          OrderDetailsModel.fromJson(response);
      return _orderDetailsModel;
    }
  }

  /// get Information to track order details...
  Future getTrackingInformation(String orderIdToTrack) async {
    int userId = prefs.read<int>('userId');
    dynamic response = await OrderHistoryAPI.getTrackingDetailsOfOrder(
        userId.toString(), orderIdToTrack);


    TrackOrderModel _trackOrderModel = TrackOrderModel.fromJson(response);
    return _trackOrderModel;
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getOrderDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              if (snapshot.data.response[0].length == 0) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/no_notification.svg',
                        height: 100,
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Order not found!',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: colorPalette.navyBlue,
                        ),
                      ),
                      SizedBox(height: 100.0),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Column(
                        children: List.generate(
                            snapshot.data.response[0].orderData.length,
                            (index) {
                          var total = 0.0;
                          snapshot.data.response[0].orderData[index].orderDetail
                              .forEach((e) {
                            try {
                              total =
                                  total + (double.parse(e.productSalePrice));
                              total = total.floorToDouble();
                            } catch (e) {
                              total = total + (int.parse(e.productSalePrice));
                            }
                          });
                          return Container(
                            height: snapshot.data.response[0].orderData[index]
                                        .orderDetail.length ==
                                    1
                                ? width / 2.0
                                : width / 1.5,
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: colorPalette.grey,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: colorPalette.purple,
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                  ),
                                  height: width / 6,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: width / 24),
                                        child: Text(
                                          'Order Id : ${snapshot.data.response[0].orderData[index].subOrderNo}\n${snapshot.data.response[0].orderData[index].orderConfirmedDate}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      Spacer(),
                                      snapshot.data.response[0].orderData[index]
                                                  .isManual !=
                                              "0"
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      colorPalette.pinkOrange,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  )),
                                              height: width / 16,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 7.0),
                                              child: Text(
                                                'Manual Shipping ',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              alignment: Alignment.center,
                                            )
                                          : SizedBox()
                                    ],
                                  ),
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 15),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemBuilder: (context, indexP) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/images/preload.png",
                                                  height: width / 5.5,
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.5,
                                                  child: Text(
                                                    '${snapshot.data.response[0].orderData[index].orderDetail[indexP].productName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                      color: const Color(
                                                          0xff000000),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  '₹ ${snapshot.data.response[0].orderData[index].orderDetail[indexP].productSalePrice}',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                    color:
                                                        const Color(0xff9f9f9f),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: snapshot.data.response[0]
                                        .orderData[index].orderDetail.length,
                                  ),
                                ),
                                Divider(
                                  indent: 15,
                                  endIndent: 15,
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Consumer<OrderProvider>(
                                        builder: (_, _orderProvider, child) =>
                                            BlueOutlineButton(
                                          width: width,
                                          onTap: snapshot
                                                      .data
                                                      .response[0]
                                                      .orderData[index]
                                                      .isManual ==
                                                  "1"
                                              ? () {

                                            _orderProvider
                                                .orderTrackExpandListSingleUpdate(
                                                index,
                                                !_orderProvider
                                                    .orderTrackExpandList[
                                                index]);
                                          }
                                              : () {

                                            try{
                                              _orderProvider
                                                  .orderIdToTrack =
                                              "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                              _orderProvider
                                                  .userDeliveryAddress =
                                                  LatLng(
                                                    double.parse(snapshot
                                                        .data
                                                        .response[0]
                                                        .userDeliveryAddress[
                                                    0]
                                                        .latitudes ==
                                                        "" ||
                                                        snapshot
                                                            .data
                                                            .response[0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .latitudes ==
                                                            null
                                                        ? "21.969138705424697"
                                                        : snapshot
                                                        .data
                                                        .response[0]
                                                        .userDeliveryAddress[
                                                    0]
                                                        .longitude),
                                                    double.parse(snapshot
                                                        .data
                                                        .response[0]
                                                        .userDeliveryAddress[
                                                    0]
                                                        .longitude ==
                                                        "" ||
                                                        snapshot
                                                            .data
                                                            .response[0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .longitude ==
                                                            null
                                                        ? "77.69074838608503"
                                                        : snapshot
                                                        .data
                                                        .response[0]
                                                        .userDeliveryAddress[
                                                    0]
                                                        .longitude),
                                                  );
                                              homeProvider.selectedString =
                                              "OrderTracking";
                                            }catch(e){
                                              _orderProvider
                                                  .orderIdToTrack =
                                              "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                              // _orderProvider
                                              //     .userDeliveryAddress =
                                              //     LatLng(
                                              //       double.parse(snapshot
                                              //           .data
                                              //           .response[0]
                                              //           .userDeliveryAddress[
                                              //       0]
                                              //           .latitudes ==
                                              //           "" ||
                                              //           snapshot
                                              //               .data
                                              //               .response[0]
                                              //               .userDeliveryAddress[
                                              //           0]
                                              //               .latitudes ==
                                              //               null
                                              //           ? "21.969138705424697"
                                              //           : snapshot
                                              //           .data
                                              //           .response[0]
                                              //           .userDeliveryAddress[
                                              //       0]
                                              //           .longitude),
                                              //       double.parse(snapshot
                                              //           .data
                                              //           .response[0]
                                              //           .userDeliveryAddress[
                                              //       0]
                                              //           .longitude ==
                                              //           "" ||
                                              //           snapshot
                                              //               .data
                                              //               .response[0]
                                              //               .userDeliveryAddress[
                                              //           0]
                                              //               .longitude ==
                                              //               null
                                              //           ? "77.69074838608503"
                                              //           : snapshot
                                              //           .data
                                              //           .response[0]
                                              //           .userDeliveryAddress[
                                              //       0]
                                              //           .longitude),
                                              //     );
                                              homeProvider.showMapInTrackingPage = false;
                                              homeProvider.selectedString =
                                              "OrderTracking";
                                            }

                                                },
                                          title: "TRACK",
                                        ),
                                      ),
                                      snapshot.data.response[0].orderData[index].isInvoiceMade == "1" ? BlueOutlineButton(
                                        width: width,
                                        onTap:  ( ) async {
                                          _launchInBrowser("${snapshot.data.response[0].orderData[index].invoiceLink}");
                                        },
                                        title: "INVOICE",
                                      ) : SizedBox(),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Total : ",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xff000000),
                                              ),
                                            ),
                                            TextSpan(
                                              text: "₹ $total",
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xff515c6f),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  padding: EdgeInsets.only(
                                      right: 15, bottom: 15, left: 15),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xffb7b7b7),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].fname} ${snapshot.data.response[0].userDeliveryAddress[0].lname} \n${snapshot.data.response[0].userDeliveryAddress[0].mobile} ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: const Color(0xff000000),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].address1},\n${snapshot.data.response[0].userDeliveryAddress[0].address2} \n${snapshot.data.response[0].userDeliveryAddress[0].city}, ${snapshot.data.response[0].userDeliveryAddress[0].state},\n${snapshot.data.response[0].userDeliveryAddress[0].pincode}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xffa9a9aa),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        height: width / 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Payment Mode : ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${snapshot.data.response[0].order[0].paymentMethod}",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff515c6f),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PriceDetail(
                        width: width,
                        height: height,
                        itemCount: snapshot.data.response[0].orderData.length,
                        totalOfItem:
                            '${snapshot.data.response[0].orderSummary[0].finalPrice}',
                        tax:
                            '${snapshot.data.response[0].orderSummary[0].finalTaxPrice}',
                        deliverCharge:
                            '${snapshot.data.response[0].orderSummary[0].finalDeliveryPrice}',
                        mainTotal:
                            '${snapshot.data.response[0].orderSummary[0].finalTotalPrice}',
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                );
              }
            } catch (e) {


              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Consumer<OrderProvider>(
                  builder: (_, _orderProvider, child) => Column(
                    children: [
                      Column(
                        children: List.generate(
                            snapshot.data.response[0].orderData.length,
                            (index) {
                          List<bool> expand = [];
                          var total = 0.0;
                          snapshot.data.response[0].orderData[index].orderDetail
                              .forEach((e) {
                            try {
                              total =
                                  total + (double.parse(e.productSalePrice));
                              total = total.floorToDouble();
                            } catch (e) {
                              total = total + (int.parse(e.productSalePrice));
                            }
                            _orderProvider.orderTrackExpandList.add(false);
                          });

                          return Column(
                            children: [
                              Container(
                                height: snapshot
                                            .data
                                            .response[0]
                                            .orderData[index]
                                            .orderDetail
                                            .length ==
                                        1
                                    ? width / 2.0
                                    : width / 1.5,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: colorPalette.grey,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: colorPalette.purple,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      height: width / 6,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: width / 24),
                                            child: Text(
                                              'Order Id : ${snapshot.data.response[0].orderData[index].subOrderNo}\n${snapshot.data.response[0].orderData[index].orderConfirmedDate}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 15,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Spacer(),
                                          snapshot
                                                      .data
                                                      .response[0]
                                                      .orderData[index]
                                                      .isManual !=
                                                  "0"
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      color: colorPalette
                                                          .pinkOrange,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      )),
                                                  height: width / 16,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 7.0),
                                                  child: Text(
                                                    'Manual Shipping ',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 12,
                                                      color: const Color(
                                                          0xffffffff),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  alignment: Alignment.center,
                                                )
                                              : SizedBox()
                                        ],
                                      ),
                                      alignment: Alignment.topLeft,
                                      padding: EdgeInsets.only(left: 15),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemBuilder: (context, indexP) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/preload.png",
                                                      height: width / 5.5,
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      child: Text(
                                                        '${snapshot.data.response[0].orderData[index].orderDetail[indexP].productName}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.035,
                                                          color: const Color(
                                                              0xff000000),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      '₹ ${snapshot.data.response[0].orderData[index].orderDetail[indexP].productSalePrice}',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.035,
                                                        color: const Color(
                                                            0xff9f9f9f),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: snapshot
                                            .data
                                            .response[0]
                                            .orderData[index]
                                            .orderDetail
                                            .length,
                                      ),
                                    ),
                                    Divider(
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Consumer<OrderProvider>(
                                            builder:
                                                (_, _orderProvider, child) =>
                                                    BlueOutlineButton(
                                              width: width,
                                              onTap: snapshot
                                                          .data
                                                          .response[0]
                                                          .orderData[index]
                                                          .isManual ==
                                                      "1"
                                                  ? () {

                                                      _orderProvider
                                                          .orderTrackExpandListSingleUpdate(
                                                              index,
                                                              !_orderProvider
                                                                      .orderTrackExpandList[
                                                                  index]);

                                                    }
                                                  : () {
                                                try{
                                                  _orderProvider
                                                      .orderIdToTrack =
                                                  "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                  _orderProvider
                                                      .userDeliveryAddress =
                                                      LatLng(
                                                        double.parse(snapshot
                                                            .data
                                                            .response[
                                                        0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .latitudes ==
                                                            "" ||
                                                            snapshot
                                                                .data
                                                                .response[
                                                            0]
                                                                .userDeliveryAddress[
                                                            0]
                                                                .latitudes ==
                                                                null
                                                            ? "21.969138705424697"
                                                            : snapshot
                                                            .data
                                                            .response[0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .longitude),
                                                        double.parse(snapshot
                                                            .data
                                                            .response[
                                                        0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .longitude ==
                                                            "" ||
                                                            snapshot
                                                                .data
                                                                .response[
                                                            0]
                                                                .userDeliveryAddress[
                                                            0]
                                                                .longitude ==
                                                                null
                                                            ? "77.69074838608503"
                                                            : snapshot
                                                            .data
                                                            .response[0]
                                                            .userDeliveryAddress[
                                                        0]
                                                            .longitude),
                                                      );
                                                  homeProvider
                                                      .selectedString =
                                                  "OrderTracking";
                                                }catch(e){
                                                  _orderProvider
                                                      .orderIdToTrack =
                                                  "${snapshot.data.response[0].orderData[index].subOrderNo}";
                                                  // _orderProvider
                                                  //     .userDeliveryAddress =
                                                  //     LatLng(
                                                  //       double.parse(snapshot
                                                  //           .data
                                                  //           .response[
                                                  //       0]
                                                  //           .userDeliveryAddress[
                                                  //       0]
                                                  //           .latitudes ==
                                                  //           "" ||
                                                  //           snapshot
                                                  //               .data
                                                  //               .response[
                                                  //           0]
                                                  //               .userDeliveryAddress[
                                                  //           0]
                                                  //               .latitudes ==
                                                  //               null
                                                  //           ? "21.969138705424697"
                                                  //           : snapshot
                                                  //           .data
                                                  //           .response[0]
                                                  //           .userDeliveryAddress[
                                                  //       0]
                                                  //           .longitude),
                                                  //       double.parse(snapshot
                                                  //           .data
                                                  //           .response[
                                                  //       0]
                                                  //           .userDeliveryAddress[
                                                  //       0]
                                                  //           .longitude ==
                                                  //           "" ||
                                                  //           snapshot
                                                  //               .data
                                                  //               .response[
                                                  //           0]
                                                  //               .userDeliveryAddress[
                                                  //           0]
                                                  //               .longitude ==
                                                  //               null
                                                  //           ? "77.69074838608503"
                                                  //           : snapshot
                                                  //           .data
                                                  //           .response[0]
                                                  //           .userDeliveryAddress[
                                                  //       0]
                                                  //           .longitude),
                                                  //     );
                                                  homeProvider.showMapInTrackingPage = false;
                                                  homeProvider
                                                      .selectedString =
                                                  "OrderTracking";
                                                }

                                                    },
                                              title: "TRACK",
                                            ),
                                          ),
                                          snapshot.data.response[0].orderData[index].isInvoiceMade == "1" ? BlueOutlineButton(
                                            width: width,
                                            onTap:  ( ) async {
                                              _launchInBrowser("${snapshot.data.response[0].orderData[index].invoiceLink}");
                                            },
                                            title: "INVOICE",
                                          ) : SizedBox(),
                                          SizedBox(width: 20.0,),
                                          RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "Total : ",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xff000000),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "₹ $total",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xff515c6f),
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      padding: EdgeInsets.only(
                                          right: 15, bottom: 15, left: 15),
                                    ),
                                  ],
                                ),
                              ),
                              _orderProvider.orderTrackExpandList[index]
                                  ? FutureBuilder(
                                      future: getTrackingInformation(
                                          "${snapshot.data.response[0].orderData[index].subOrderNo}"),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Order Packed Date : ${snapshot.data.response[0].orderPackedDate}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                          colorPalette.navyBlue,
                                                      fontWeight:
                                                          FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Tracking Number : ${snapshot.data.response[0].trackingNumber}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                      colorPalette.navyBlue,
                                                      fontWeight:
                                                      FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Shipping Date : ${snapshot.data.response[0].shippingInfoDate}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                      colorPalette.navyBlue,
                                                      fontWeight:
                                                      FontWeight.w200),
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "Order Shipping Info : ${snapshot.data.response[0].shippingInfo}",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color:
                                                      colorPalette.navyBlue,
                                                      fontWeight:
                                                      FontWeight.w200),
                                                ),
                                                SizedBox(height: 20),
                                                Divider(
                                                  height: 20,
                                                  color: colorPalette.navyBlue,
                                                  thickness: 2,
                                                  indent: width / 2.5,
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      colorPalette.navyBlue),
                                            ),
                                          );
                                        }
                                      })
                                  : SizedBox(),
                            ],
                          );
                        }),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Delivery Address',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: const Color(0xffb7b7b7),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].fname} ${snapshot.data.response[0].userDeliveryAddress[0].lname} \n${snapshot.data.response[0].userDeliveryAddress[0].mobile} ',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16,
                                  color: const Color(0xff000000),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${snapshot.data.response[0].userDeliveryAddress[0].address1},\n${snapshot.data.response[0].userDeliveryAddress[0].address2} \n${snapshot.data.response[0].userDeliveryAddress[0].city}, ${snapshot.data.response[0].userDeliveryAddress[0].state},\n${snapshot.data.response[0].userDeliveryAddress[0].pincode}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: const Color(0xffa9a9aa),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        height: width / 10,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: colorPalette.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Payment Mode : ",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff000000),
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${snapshot.data.response[0].order[0].paymentMethod}",
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 15,
                                  color: const Color(0xff515c6f),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      PriceDetail(
                        width: width,
                        height: height,
                        itemCount: snapshot.data.response[0].orderData.length,
                        totalOfItem:
                            '${snapshot.data.response[0].orderSummary[0].finalPrice}',
                        tax:
                            '${snapshot.data.response[0].orderSummary[0].finalTaxPrice}',
                        deliverCharge:
                            '${snapshot.data.response[0].orderSummary[0].finalDeliveryPrice}',
                        mainTotal:
                            '${snapshot.data.response[0].orderSummary[0].finalTotalPrice}',
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              );
            }
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
  }
}
