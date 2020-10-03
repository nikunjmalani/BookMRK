import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

Widget OtpBox(context) {
  ColorPalette colorPalette = ColorPalette();
  return Container(
    height: MediaQuery.of(context).size.width / 7,
    width: MediaQuery.of(context).size.width / 9,
    decoration: BoxDecoration(
        border: Border.all(color: colorPalette.borderGrey),
        borderRadius: BorderRadius.circular(13)),
  );
}

Widget ImageBox({height, width, image, title}) {
  ColorPalette colorPalette = ColorPalette();
  return Container(
    alignment: Alignment.bottomCenter,
    margin: EdgeInsets.only(left: 10, top: 15),
    height: height / 5,
    width: height / 5.5,
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffcfcfcf)),
      borderRadius: BorderRadius.circular(25),
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
    ),
    child: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        color: colorPalette.orange,
      ),
      height: 40,
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          backgroundColor: colorPalette.orange,
          fontFamily: 'Roboto',
          fontSize: 16,
          color: const Color(0xffffffff),
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget ProductBox({height, width, image, title, description, price, expanded}) {
  ColorPalette colorPalette = ColorPalette();
  return Stack(
    fit: expanded == true ? StackFit.expand : StackFit.loose,
    children: [
      Container(
        height: height / 3,
        width: width / 2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Color(0xffcfcfcf),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                image,
                fit: BoxFit.fill,
                height: height / 5.2,
              ),
            ),
            Container(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  color: const Color(0xff000000),
                ),
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5),
            ),
            SizedBox(
              height: 3,
            ),
            Container(
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 14,
                  color: const Color(0xff777777),
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.left,
              ),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 5),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 5,
                right: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 20,
                    width: 60,
                    decoration: BoxDecoration(
                      color: colorPalette.pinkOrange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'In Stock',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 13,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(
                    '₹ $price',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: const Color(0xff515c6f),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: 0,
        right: 0,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
            color: colorPalette.navyBlue,
          ),
        ),
      )
    ],
  );
}
