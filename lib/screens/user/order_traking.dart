import 'package:flutter/material.dart';

class OrderTracking extends StatefulWidget {
  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
