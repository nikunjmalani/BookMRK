import 'package:bookmrk/widgets/indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget Carasoul({
  height,
  pageController,
  currentPage,
  colorPalette,
  width,
  onChanged,
  banners,
  seeMoreLink,
}) {
  return Container(
    height: height / 4.3,
    child: Column(
      children: [
        Container(
          height: height / 5,
          child: PageView(
            controller: pageController,
            onPageChanged: onChanged,
            children: List.generate(
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
        ),
        SizedBox(
          height: 10,
        ),
        Indicators(currentPage: currentPage, pages: banners.length),
      ],
    ),
  );
}
