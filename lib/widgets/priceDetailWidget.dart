import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';

Widget PriceDetail(
    {height,
    width,
    int itemCount,
    String totalOfItem,
    String tax,
    String deliverCharge,
    String mainTotal}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    height: height / 3,
    width: width,
    child: Column(
      children: [
        priceDetail(),
        SizedBox(
          height: 15,
        ),
        priceRow(title: "Price (${itemCount} Items) :", price: totalOfItem),
        priceRow(title: "Tax :", price: tax),
        priceRow(title: "Delivery Charges :", price: deliverCharge),
        Divider(
          indent: 10,
          thickness: 1,
          endIndent: 10,
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                '₹ $mainTotal',
                style: TextStyle(
                    fontFamily: 'Roboto', fontSize: 18, color: Colors.black),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
}
