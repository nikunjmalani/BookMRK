import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliver to Ovi Mahajan 411037',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 13,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    '15 B, Near Black Well, Chavhan Nagar, Lacknow',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: const Color(0xffa9a9aa),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Container(
                width: width / 4.5,
                child: FlatButton(
                  onPressed: () {
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .selectedString = "ChangeAddress";
                  },
                  color: colorPalette.navyBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'CHANGE',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 12,
                      color: const Color(0xffffffff),
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return index <= 2
                  ? Container(
                      margin: EdgeInsets.all(10),
                      height: width / 2.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: colorPalette.grey,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 5, top: 0),
                                child: Image.asset(
                                  "assets/images/Sharpner.png",
                                  height: width / 3.5,
                                  width: width / 3.5,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Eduvate Book Kit',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'By Circle Enterprises ',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      color: const Color(0xffa9a9aa),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            indent: 20,
                            thickness: 1,
                            endIndent: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/delete.svg",
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '₹ 859.00',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xff515c6f),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        PriceDetail(
                          width: width,
                          height: height,
                          itemCount: 2,
                          totalOfItem: 869.00,
                          tax: 0.00,
                          deliverCharge: 50.0,
                          mainTotal: 919.00,
                        ),
                        BlueLongButton(
                          title: "PROCESS TO CHECKOUT",
                          height: height,
                          onTap: () {},
                        )
                      ],
                    );
            },
            itemCount: 3 + 1,
          ),
        ),
      ],
    );
  }
}
