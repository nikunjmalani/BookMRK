import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: width / 1.5,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                  child: Text(
                    'Order Id : Ob15421546512\n12 June 2020  13:48',
                    style: TextStyle(
                      fontFamily: 'Roboto',
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
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                Text(
                                  'Eduvate Book Kit',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    color: const Color(0xff000000),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Spacer(),
                                Text(
                                  '₹ 859.00',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
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
                    itemCount: 2,
                  ),
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BlueOutlineButton(
                        width: width,
                        onTap: () =>
                            homeProvider.selectedString = "OrderTracking",
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
                              text: "₹ 869.00",
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
                  padding: EdgeInsets.only(right: 15, bottom: 15, left: 15),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            height: width / 2.6,
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
                    'Ovi Mahajan \n+915486589751',
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
                    '15 B, Near Black Well, Chavhan Nagar, \nLacknow, Uttar Pradesh\n411037',
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
                    text: "Wallet",
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
            itemCount: 2,
            totalOfItem: '869.00',
            tax: '0.00',
            deliverCharge: '50.0',
            mainTotal: '919.00',
          ),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
