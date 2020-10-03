import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  onPressed: () {},
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
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          height: height / 4,
                          width: width,
                          color: Colors.white,
                          child: Column(
                            children: [
                              _priceDetail(),
                              SizedBox(
                                height: 15,
                              ),
                              _priceRow(
                                  title: "Price (2 Items) :", price: 869.00),
                              _priceRow(title: "Tax :", price: 00.00),
                              _priceRow(
                                  title: "Delivery Charges :", price: 50.00),
                              Divider(
                                indent: 10,
                                thickness: 1,
                                endIndent: 10,
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        color: const Color(0xff000000),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      '₹ 919.0',
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 18,
                                          color: Colors.black),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xff44349A),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin:
                              EdgeInsets.only(bottom: 110, left: 25, right: 25),
                          height: height / 15,
                          child: Text(
                            'PROCEED TO CHECKOUT',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 18,
                              color: const Color(0xffffffff),
                              letterSpacing: 0.8999999999999999,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.center,
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

Widget _priceDetail() {
  return Text(
    'Price Details',
    style: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16,
      color: const Color(0xffb7b7b7),
    ),
    textAlign: TextAlign.left,
  );
}

Widget _priceRow({String title, var price}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, top: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: const Color(0xff000000),
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.left,
        ),
        Text(
          '₹ ${price}',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 16,
            color: const Color(0xffbcbcbc),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  );
}
