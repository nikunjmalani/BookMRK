import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/order_history_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  /// get order history...
  Future getOrderList(String status) async {
    int userId = prefs.read<int>('userId');

    dynamic response =
        await OrderHistoryAPI.getOrderHistoryDetails(userId.toString(), status);

    if (response['response'].length == 0) {
      NoDataOrderModel _noDataOrder = NoDataOrderModel.fromJson(response);
      return _noDataOrder;
    } else {
      OrderHistoryModel _orderHistoryModel =
          OrderHistoryModel.fromJson(response);
      return _orderHistoryModel;
    }
  }

  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Column(
          children: [
            Tabs(
              firstTitle: "Current Orders",
              secondTitle: "Past Orders",
              height: height,
              width: width,
              firstTap: () => homeProvider.currentPastOrderIndex = 0,
              secondTap: () => homeProvider.currentPastOrderIndex = 1,
              currentIndex: data.currentPastOrderIndex,
            ),
            homeProvider.currentPastOrderIndex == 0
                ? FutureBuilder(
                    future: getOrderList("C"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.response.length != 0) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 70.0),
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  List data = [];
                                  snapshot.data.response[index].orderData
                                      .forEach((element) {
                                    element.orderDetail.forEach((b) {
                                      data.add(b);

                                    });
                                  });

                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {

                                          Provider.of<OrderProvider>(context,
                                                      listen: false)
                                                  .orderId =
                                              "${snapshot.data.response[index].orderNo}";

                                          homeProvider.selectedString =
                                              "OrderDetails";
                                        },
                                        child: Container(
                                          height: data.length > 1
                                              ? width / 1.8
                                              : width / 2.5,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                height: width / 7,
                                                child: Text(
                                                  'Order Id : ${snapshot.data.response[index].orderNo}\n${snapshot.data.response[index].orderDateTime}',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
//                                                            Image.asset(
//                                                              "assets/images/Sharpner.png",
//                                                              height: width / 7,
//                                                            ),
//                                                            SizedBox(
//                                                              width: 15,
//                                                            ),
                                                              Container(
                                                                height: 25.0,
                                                                width: 25.0,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: colorPalette
                                                                        .navyBlue),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "${index + 1}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Container(
                                                                height:
                                                                    width / 10,
                                                                width:
                                                                    width / 1.4,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  '${data[index].productName}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize: 18,
                                                                    color: const Color(
                                                                        0xff000000),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemCount: data.length,
                                                ),
                                              ),
                                              Divider(
                                                indent: 15,
                                                endIndent: 15,
                                              ),
                                              Container(
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Total : ",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "₹ ${snapshot.data.response[index].orderTotalCost}",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff515c6f),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(
                                                    right: 15, bottom: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
//                                    index == 1
//                                        ? Positioned(
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  color:
//                                                      colorPalette.pinkOrange,
//                                                  borderRadius:
//                                                      BorderRadius.only(
//                                                    bottomLeft:
//                                                        Radius.circular(20),
//                                                    topRight:
//                                                        Radius.circular(20),
//                                                  )),
//                                              height: width / 16,
//                                              width: width / 3,
//                                              child: Text(
//                                                'Manual Shipping ',
//                                                style: TextStyle(
//                                                  fontFamily: 'Roboto',
//                                                  fontSize: 12,
//                                                  color:
//                                                      const Color(0xffffffff),
//                                                ),
//                                                textAlign: TextAlign.left,
//                                              ),
//                                              alignment: Alignment.center,
//                                            ),
//                                            top: 10,
//                                            right: 16,
//                                          )
//                                        : SizedBox(),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data.response.length,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              child: Text('No Orders !'),
                            ),
                          );
                        }
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 100.0,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    colorPalette.navyBlue),
                              ),
                            ),
                          ],
                        );
                      }
                    })
                : FutureBuilder(
                    future: getOrderList("P"),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.response.length != 0) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 70),
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  List data = [];
                                  snapshot.data.response[index].orderData
                                      .forEach((element) {
                                    element.orderDetail.forEach((b) {
                                      data.add(b);
                                    });
                                  });

                                  return Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Provider.of<OrderProvider>(context,
                                              listen: false)
                                              .orderId =
                                          "${snapshot.data.response[index].orderNo}";
                                          homeProvider.selectedString =
                                              "OrderDetails";
                                        },
                                        child: Container(
                                          height: width / 1.8,
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(20),
                                                  ),
                                                ),
                                                height: width / 7,
                                                child: Text(
                                                  'Order Id : ${snapshot.data.response[index].orderNo}\n${snapshot.data.response[index].orderDateTime}',
                                                  style: TextStyle(
                                                    fontFamily: 'Segoe UI',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    EdgeInsets.only(left: 15),
                                              ),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemBuilder: (context, index) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
//                                                            Image.asset(
//                                                              "assets/images/Sharpner.png",
//                                                              height: width / 7,
//                                                            ),
//                                                            SizedBox(
//                                                              width: 15,
//                                                            ),
                                                              Container(
                                                                height: 25.0,
                                                                width: 25.0,
                                                                decoration: BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: colorPalette
                                                                        .navyBlue),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "${index + 1}",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  width: 10.0),
                                                              Container(
                                                                height:
                                                                    width / 10,
                                                                width:
                                                                    width / 1.4,
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  '${data[index].productName}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Roboto',
                                                                    fontSize: 18,
                                                                    color: const Color(
                                                                        0xff000000),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  itemCount: data.length,
                                                ),
                                              ),
                                              Divider(
                                                indent: 15,
                                                endIndent: 15,
                                              ),
                                              Container(
                                                child: RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text: "Total : ",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff000000),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "₹ ${snapshot.data.response[index].orderTotalCost}",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xff515c6f),
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                alignment: Alignment.centerRight,
                                                padding: EdgeInsets.only(
                                                    right: 15, bottom: 15),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
//                                    index == 1
//                                        ? Positioned(
//                                            child: Container(
//                                              decoration: BoxDecoration(
//                                                  color:
//                                                      colorPalette.pinkOrange,
//                                                  borderRadius:
//                                                      BorderRadius.only(
//                                                    bottomLeft:
//                                                        Radius.circular(20),
//                                                    topRight:
//                                                        Radius.circular(20),
//                                                  )),
//                                              height: width / 16,
//                                              width: width / 3,
//                                              child: Text(
//                                                'Manual Shipping ',
//                                                style: TextStyle(
//                                                  fontFamily: 'Roboto',
//                                                  fontSize: 12,
//                                                  color:
//                                                      const Color(0xffffffff),
//                                                ),
//                                                textAlign: TextAlign.left,
//                                              ),
//                                              alignment: Alignment.center,
//                                            ),
//                                            top: 10,
//                                            right: 16,
//                                          )
//                                        : SizedBox(),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data.response.length,
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Container(
                              child: Text('No Orders !'),
                            ),
                          );
                        }
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: 100.0,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    colorPalette.navyBlue),
                              ),
                            ),
                          ],
                        );
                      }
                    })
          ],
        );
      },
    );
  }
}
