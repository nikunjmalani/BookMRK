import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:flutter/material.dart';

class ProductInfo extends StatefulWidget {
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  PageController pageController = PageController(initialPage: 1);
  ColorPalette colorPalette = ColorPalette();
  int currentPage = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _productCarasoul(
                    height: height,
                    pageController: pageController,
                    currentPage: currentPage,
                    onChange: (value) {
                      setState(() {
                        currentPage = value;
                      });
                    }),
                SizedBox(
                  height: 15,
                ),
                BlueHeader("English Grammar And Composition"),
                descrip("By Circle Enterprises"),
                Text(
                  'Published By : Alpha bate Publication ',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 14,
                    color: const Color(0xffa4a4a4),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '₹ 200.00',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 17,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                title("Specifications"),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '***',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                title("Description"),
                Container(
                  padding: EdgeInsets.all(8),
                  child: descrip(
                      "English Grammar & Composition is one of the most popular\nand widely used reference books on English Grammar. It not\nonly helps the students to use the language, but also gives\ndetailed information about the language. High School English\nGrammar & Composition provides ample guidance and \npractice in sentence building, correct usage, comprehension,\n composition and other allied areas so as to equip the \nlearners with the ability to communicate effectively in English."),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NavyBlueButton(
                        onClick: () {}, context: context, title: "ADD TO CART"),
                    NavyBlueButton(
                        onClick: () {}, context: context, title: "BUY NOW")
                  ],
                ),
                SizedBox(
                  height: 110,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

Widget _productCarasoul({height, pageController, onChange, currentPage}) {
  ColorPalette colorPalette = ColorPalette();

  return Stack(
    children: [
      Column(
        children: [
          Container(
            height: height / 2.5,
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: height / 2.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/bigbook.png"),
                      ),
                    ),
                  );
                },
                onPageChanged: onChange),
          ),
          Indicators(currentPage: currentPage),
        ],
      ),
      Container(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: colorPalette.navyBlue,
                size: 35,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: colorPalette.navyBlue,
                size: 35,
              ),
            ),
            SizedBox(
              height: height / 3.6,
            ),
            Container(
              margin: EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              height: 25,
              width: 75,
              decoration: BoxDecoration(
                color: colorPalette.pinkOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'In Stock',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: colorPalette.navyBlue,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
