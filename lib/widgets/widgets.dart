import 'package:bookmrk/res/colorPalette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget OtpBox(context, TextEditingController controller, FocusNode fn) {
  ColorPalette colorPalette = ColorPalette();
  return Container(
    height: MediaQuery.of(context).size.width / 7,
    width: MediaQuery.of(context).size.width / 9,
    decoration: BoxDecoration(
        border: Border.all(color: colorPalette.borderGrey),
        borderRadius: BorderRadius.circular(13)),
    padding: EdgeInsets.only(bottom: 5.0),
    alignment: Alignment.center,
    child: TextFormField(
      controller: controller,
      inputFormatters: [LengthLimitingTextInputFormatter(1)],
      focusNode: fn,
      cursorColor: colorPalette.navyBlue,
      style: TextStyle(fontSize: 35.0),
      onChanged: (value) {
        if (value.length >= 1) {
          fn.nextFocus();
        } else if (value.length <= 0) {
          fn.previousFocus();
        }
      },
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: InputBorder.none,
      ),
    ),
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
          image: image != null
              ? NetworkImage(image)
              : AssetImage('assets/images/logo.png'),
          fit: BoxFit.fill),
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

Widget ProductBox(
    {height,
    width,
    image,
    title,
    description,
    price,
    expanded,
    icon,
    stock = "In"}) {
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
              child: CachedNetworkImage(
                imageUrl: image,
                height: height / 5.2,
                fit: BoxFit.fill,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                        colorFilter: ColorFilter.mode(
                            Colors.red.withOpacity(0.5), BlendMode.colorBurn)),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: Image.asset('assets/images/Sharpner.png')),
                errorWidget: (context, url, error) =>
                    Center(child: Image.asset('assets/images/Sharpner.png')),
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
                      '$stock Stock',
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
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(15),
                child: icon,
              )) ??
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

Widget Tabs(
    {height,
    width,
    firstTap,
    secondTap,
    currentIndex,
    firstTitle,
    secondTitle}) {
  ColorPalette colorPalette = ColorPalette();
  return Row(
    children: [
      GestureDetector(
        onTap: firstTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 15),
          height: height / 18,
          width: width / 2,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentIndex == 0
                  ? colorPalette.navyBlue
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: Text(
            firstTitle,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
              color: const Color(0xff301869),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
      GestureDetector(
        onTap: secondTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 15),
          height: height / 18,
          width: width / 2,
          decoration: BoxDecoration(
            border: Border.all(
              color: currentIndex == 1
                  ? colorPalette.navyBlue
                  : Colors.transparent,
              width: 3,
            ),
          ),
          child: Text(
            secondTitle,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 17,
              color: const Color(0xff000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      )
    ],
  );
}

Widget priceDetail() {
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

Widget priceRow({String title, var price}) {
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
