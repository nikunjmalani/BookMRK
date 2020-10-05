import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';

class FeedBack extends StatefulWidget {
  @override
  _FeedBackState createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            'Feedback',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16,
              color: const Color(0xff747474),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: colorPalette.grey,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            maxLines: 7,
            decoration: InputDecoration(
              hintMaxLines: 7,
              contentPadding: EdgeInsets.all(10),
              hintText: "Mention Feedback Here.",
              border: InputBorder.none,
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: NavyBlueButton(
            title: "SEND",
            context: context,
            onClick: () {},
          ),
        )
      ],
    );
  }
}
