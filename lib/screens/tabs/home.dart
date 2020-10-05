import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/carasoul.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  int currentPage = 1;

  PageController pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return _buildHome(width, height);
  }

  Column _buildHome(double width, double height) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SearchBar(
                  width: width,
                  title: "Search Products",
                  onTap: () {
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .selectedString = "SearchProducts";
                  },
                ),
                Carasoul(
                  height: height,
                  width: width,
                  colorPalette: colorPalette,
                  currentPage: currentPage,
                  onChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  pageController: pageController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Header2("Categories"),
                      Spacer(),
                      ViewAll(onClick: () {
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedString = "Category";
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedBottomIndex = 1;
                      })
                    ],
                  ),
                ),
                Container(
                  height: height / 2.3,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0xffcfcfcf),
                    ),
                  ),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CategoryButtons(
                              width,
                              "Books",
                              colorPalette.navyBlue,
                              Color(0xff6A4B9C),
                            ),
                            CategoryButtons(
                              width,
                              "NoteBooks",
                              colorPalette.orange,
                              colorPalette.orange,
                            ),
                            CategoryButtons(
                              width,
                              "Sketch",
                              colorPalette.orange,
                              colorPalette.orange,
                            ),
                            CategoryButtons(
                              width,
                              "Books",
                              colorPalette.orange,
                              colorPalette.orange,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height / 3.2,
                        child: ListView.builder(
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .selectedString = "ProductInfo";
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 10, right: 10),
                                height: height / 3.8,
                                width: width / 2.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xffcfcfcf),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Image.asset(
                                        "assets/images/book.png",
                                        fit: BoxFit.cover,
                                      ),
                                      height: height / 5.6,
                                      padding: EdgeInsets.only(top: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Center(
                                      child: Text(
                                        'Oswaal NCERT Workbo....',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          color: const Color(0xff000000),
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Container(
                                      child: Text(
                                        'By Circle Enterprises ',
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
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
                                        top: 3,
                                        left: 5,
                                        right: 5,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            height: 15,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: colorPalette.pinkOrange,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: Text(
                                              'In Stock',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            '₹ 100.00',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 10,
                                              color: const Color(0xff515c6f),
                                              fontWeight: FontWeight.w700,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Header2("Shop by School"),
                      Spacer(),
                      ViewAll(onClick: () {
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedString = "School";
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedBottomIndex = 2;
                      })
                    ],
                  ),
                ),
                Container(
                  height: height / 5,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<HomeScreenProvider>(context,
                                  listen: false)
                              .selectedString = "SchoolInfo";
                        },
                        child: ImageBox(
                            height: height,
                            width: width,
                            image: "assets/images/school.png",
                            title: "Central Public Sch..."),
                      );
                    },
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Header2("Top Vendors"),
                      Spacer(),
                      ViewAll(
                        onClick: () {
                          Provider.of<HomeScreenProvider>(context,
                                  listen: false)
                              .selectedString = "Vendors";
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 110),
                  height: height / 5,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return ImageBox(
                          height: height,
                          width: width,
                          image: "assets/images/circle.png",
                          title: "Raju rastogi");
                    },
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
