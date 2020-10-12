import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/model/order_history_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  /// get order history...
  Future getOrderList(String status) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response =
        await OrderHistoryAPI.getOrderHistoryDetails(userId.toString(), status);
    OrderHistoryModel _orderHistoryModel = OrderHistoryModel.fromJson(response);
    return _orderHistoryModel;
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
                        return Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      homeProvider.selectedString =
                                          "OrderDetails";
                                    },
                                    child: Container(
                                      height: width / 1.8,
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
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            padding: EdgeInsets.only(left: 15),
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
                                                          Image.asset(
                                                            "assets/images/Sharpner.png",
                                                            height: width / 7,
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            'Eduvate Book Kit',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 13,
                                                              color: const Color(
                                                                  0xff000000),
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            '₹ 859.00',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 12,
                                                              color: const Color(
                                                                  0xff9f9f9f),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                              itemCount: 2,
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
                                                    color:
                                                        const Color(0xff000000),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: "₹ 869.00",
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 15,
                                                    color:
                                                        const Color(0xff515c6f),
                                                    fontWeight: FontWeight.w700,
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
                                  index == 1
                                      ? Positioned(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: colorPalette.pinkOrange,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                )),
                                            height: width / 16,
                                            width: width / 3,
                                            child: Text(
                                              'Manual Shipping ',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 12,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            alignment: Alignment.center,
                                          ),
                                          top: 10,
                                          right: 16,
                                        )
                                      : SizedBox(),
                                ],
                              );
                            },
                            itemCount: snapshot.data.response.length,
                          ),
                        );
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
                : Container()
          ],
        );
      },
    );
  }
}
