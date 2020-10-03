import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/schoolImageBox.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorsInfo extends StatefulWidget {
  @override
  _VendorsInfoState createState() => _VendorsInfoState();
}

class _VendorsInfoState extends State<VendorsInfo> {
  int tab = 0;
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          height: height / 4.5,
          decoration: BoxDecoration(
              color: colorPalette.purple,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.lerp(Radius.elliptical(50, 50),
                      Radius.elliptical(70, 70), 5.0))),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                height: height / 7,
                width: height / 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/circle.png"),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15, bottom: 30),
                height: height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Circle Enterprises ',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      '125 Products, 4 schools',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xffe5e5e5),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Text(
                      'Raju Rastogi',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: const Color(0xffe5e5e5),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  tab = 0;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15),
                height: height / 18,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        tab == 0 ? colorPalette.navyBlue : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Text(
                  'All Products',
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
              onTap: () {
                setState(() {
                  tab = 1;
                });
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 15),
                height: height / 18,
                width: width / 2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        tab == 1 ? colorPalette.navyBlue : Colors.transparent,
                    width: 3,
                  ),
                ),
                child: Text(
                  'Schools',
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
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: IconButton(
            iconSize: 28,
            onPressed: () {},
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        tab == 0
            ? Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 300,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<HomeScreenProvider>(context,
                                  listen: false)
                              .selectedString = "ProductInfo";
                        },
                        child: ProductBox(
                            expanded: true,
                            height: height,
                            width: width,
                            title: "Circle Pencil Sharpner",
                            image: "assets/images/Sharpner.png",
                            description: "By Circle Enterprise",
                            price: 10),
                      );
                    },
                    itemCount: 14,
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: index == 14
                          ? EdgeInsets.only(bottom: 70)
                          : EdgeInsets.all(0),
                      child: SchoolImageBox(
                          height: height,
                          image: "assets/images/schoolImage.png",
                          description: "Alam Nagar, Lucknow, 487525",
                          title: "Central Public School",
                          onTap: () {
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "SchoolInfo";
                          }),
                    );
                  },
                  itemCount: 15,
                ),
              ),
      ],
    );
  }
}
