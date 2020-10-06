import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/cached_image_view.dart';
import 'package:bookmrk/widgets/carasoul.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  final HomePageModel homePageModel;

  const Home({this.homePageModel});

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
                  banners: widget.homePageModel.response[0].homeBanner,
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
                          children: List.generate(
                            widget.homePageModel.response[0].category.length,
                            (index) => CategoryButtons(
                              width,
                              "${widget.homePageModel.response[0].category[index].categoryName}",
                              colorPalette.navyBlue,
                              Color(0xff6A4B9C),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: height / 3.2,
                        child: ListView.builder(
                          itemCount:
                              widget.homePageModel.response[0].product.length,
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
                                      child: showCachedImage(
                                        image:
                                            '${widget.homePageModel.response[0].product[index].productImg}',
                                        height: height,
                                        placeHolderImage:
                                            'assets/images/book.png',
                                      ),
                                      height: height / 5.6,
                                      padding: EdgeInsets.only(top: 15),
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Center(
                                      child: Text(
                                        '${widget.homePageModel.response[0].product[index].productName}',
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
                                        '${widget.homePageModel.response[0].product[index].vendorCompanyName}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: 12,
                                          color: const Color(0xff777777),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      alignment: Alignment.centerLeft,
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
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
                                              '${widget.homePageModel.response[0].product[index].productStockStatus} Stock',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 10,
                                                color: const Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            '₹ ${widget.homePageModel.response[0].product[index].productSalePrice}',
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
                            image:
                                "${widget.homePageModel.response[0].school[index].schoolLogo}",
                            title:
                                "${widget.homePageModel.response[0].school[index].schoolName}"),
                      );
                    },
                    itemCount: widget.homePageModel.response[0].school.length,
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
                          image:
                              "${widget.homePageModel.response[0].vendor[index].companyLogo}",
                          title:
                              "${widget.homePageModel.response[0].vendor[index].companyName}");
                    },
                    itemCount: widget.homePageModel.response[0].vendor.length,
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
