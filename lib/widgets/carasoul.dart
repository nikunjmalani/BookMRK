import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Carosal extends StatefulWidget {
  final double height;

  final PageController pageController;
  final int currentPage;
  final ColorPalette colorPalette;
  final double width;
  final Function onChanged;
  final List banners;
  final String seeMoreLink;
  const Carosal({Key key, this.height, this.pageController, this.currentPage, this.colorPalette, this.width, this.onChanged, this.banners, this.seeMoreLink}) : super(key: key);
  @override
  _CarosalState createState() => _CarosalState(banners: banners, height: height, colorPalette: colorPalette, currentPage: currentPage, onChanged: onChanged, pageController: pageController, seeMoreLink: seeMoreLink, width: width,);
}

class _CarosalState extends State<Carosal> with TickerProviderStateMixin {
  final double height;
  final PageController pageController;
  final int currentPage;
  final ColorPalette colorPalette;
  final double width;
  final Function onChanged;
  final List banners;
  final String seeMoreLink;
  _CarosalState(
      {this.height,
      this.pageController,
      this.currentPage,
      this.colorPalette,
      this.width,
      this.onChanged,
      this.banners,
      this.seeMoreLink});

  TabController _tabController;
  CarouselController _carouselController;

  @override
  void initState() {
    _tabController = TabController(
      vsync: this,
      length: banners.length,
      initialIndex: 0,
    );
    _carouselController = CarouselController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: height / 4,
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _carouselController ,
            options: CarouselOptions(
              onPageChanged: (index, reason){
                _tabController.animateTo(index);
              },
              autoPlay: true,
              height: height / 5,
              initialPage: 0,
              viewportFraction: 1,
            ),
            items: List.generate(
                banners.length,
                    (index) => Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          image: NetworkImage(
                            '${banners[index].img}',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding:
                      EdgeInsets.only(left: 25, top: 10, bottom: 10),
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: height / 5,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black.withOpacity(0.17),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${banners[index].text}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 22,
                              color: const Color(0xffffffff),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          seeMoreLink != "" && seeMoreLink != null
                              ? Container(
                            height: height / 20,
                            width: width / 3,
                            padding: EdgeInsets.only(
                              right: 7,
                              left: 15,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'SEE MORE',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: const Color(0xff727c8e),
                                    letterSpacing: 0.72,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/backBlue.svg",
                                  height: height / 25,
                                ),
                              ],
                            ),
                          )
                              : SizedBox(),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
          Container(
            height: 20,
            child: TabPageSelector(
              controller:_tabController,
              color: Colors.white,
              selectedColor: colorPalette.purple,
            ),
          ),
        ],
      ),
    );
  }
}


