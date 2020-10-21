import 'package:bookmrk/api/order_history_api.dart';
import 'package:bookmrk/model/order_details_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await OrderHistoryAPI.getOrderDetailsFromOrderId(
        widget.orderId.toString(), userId.toString());
    OrderDetailsModel _orderDetailsModel = OrderDetailsModel.fromJson(response);
    return _orderDetailsModel;
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
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                    children: List.generate(
                        snapshot.data.response[0].orderData.length, (index) {
                      var total = 0;
                      snapshot.data.response[0].orderData[index].orderDetail
                          .forEach((e) {
                        total = total + (int.parse(e.productSalePrice));
                      });
                      return Container(
                        height: snapshot.data.response[0].orderData[index]
                                    .orderDetail.length ==
                                0
                            ? width / 1.8
                            : width / 2.0,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: width / 24),
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
                                              color: colorPalette.pinkOrange,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
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
                                              "assets/images/Sharpner.png",
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
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.035,
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '₹ ${snapshot.data.response[0].orderData[index].orderDetail[indexP].productSalePrice}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035,
                                                color: const Color(0xff9f9f9f),
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
                                  BlueOutlineButton(
                                    width: width,
                                    onTap: () => homeProvider.selectedString =
                                        "OrderTracking",
                                    title: "TRACK",
                                  ),
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    height: width / 2.5,
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
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
