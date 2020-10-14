import 'package:bookmrk/api/school_api.dart';
import 'package:bookmrk/model/school_product_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchoolInfo extends StatefulWidget {
  final String schoolSlug;

  const SchoolInfo({@required this.schoolSlug});

  @override
  _SchoolInfoState createState() => _SchoolInfoState();
}

class _SchoolInfoState extends State<SchoolInfo> {
  PageController pageController = PageController(initialPage: 1);
  ColorPalette colorPalette = ColorPalette();
  int currentPage = 1;

  Future getSchoolProductDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic data = await SchoolAPI.getSchoolProductDetails(
        widget.schoolSlug, userId.toString());
    print(data);
    SchoolProductsModel _schoolProductModel =
        SchoolProductsModel.fromJson(data);
    return _schoolProductModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getSchoolProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<HomeScreenProvider>(
              builder: (context, data, child) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: height / 5,
                          child: PageView.builder(
                            onPageChanged: (value) {
                              setState(() {
                                currentPage = value;
                              });
                            },
                            controller: pageController,
                            itemBuilder: (context, index) {
                              return Container(
                                height: height / 5,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "${snapshot.data.response[0].school[0].schoolBanners.length == 0 ? snapshot.data.response[0].school[0].schoolLogo : snapshot.data.response[0].school[0].schoolBanners[index]['school_img']}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                            itemCount: snapshot.data.response[0].school[0]
                                        .schoolBanners.length ==
                                    0
                                ? snapshot.data.response[0].school.length
                                : snapshot.data.response[0].school[0]
                                    .schoolBanners.length,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Indicators(
                        currentPage: currentPage,
                        pages: snapshot.data.response[0].school[0].schoolBanners
                                    .length ==
                                0
                            ? snapshot.data.response[0].school.length
                            : snapshot.data.response[0].school[0].schoolBanners
                                .length),
                    SizedBox(
                      height: 10,
                    ),
                    BlueHeader(
                        "${snapshot.data.response[0].school[0].schoolName}"),
                    SizedBox(
                      height: 5,
                    ),
                    descrip(
                        "${snapshot.data.response[0].school[0].address}. ${snapshot.data.response[0].school[0].city}, ${snapshot.data.response[0].school[0].pincode}"),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: height / 24,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: index == 0
                                  ? colorPalette.navyBlue
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            margin: EdgeInsets.only(
                              left: 10,
                            ),
                            height: 25,
                            width: 100,
                            child: Text(
                              '${snapshot.data.response[0].schoolCat[index].categoryName}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                                color: index == 0
                                    ? Color(0xffffffff)
                                    : Color(0xff727C8E),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          );
                        },
                        itemCount: snapshot.data.response[0].schoolCat.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            'Available Products ',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 16,
                              color: const Color(0xffb7b7b7),
                            ),
                            textAlign: TextAlign.left,
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {},
                              child: _tabs(
                                  title: "Products", color: Color(0xffb7b7b7))),
                          SizedBox(
                            width: 5,
                          ),
                          _tabs(title: "Kits", color: colorPalette.navyBlue),
                        ],
                      ),
                    ),
                    Container(
                        height: height / 2.7,
                        width: width,
                        child: ListView.builder(
                          itemCount:
                              snapshot.data.response[0].schoolAllProduct.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Provider.of<VendorProvider>(context,
                                            listen: false)
                                        .selectedVendorName =
                                    "${snapshot.data.response[0].schoolAllProduct[index].vendorSlug}";

                                Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedProductSlug =
                                    "${snapshot.data.response[0].schoolAllProduct[index].productSlug}";

                                Provider.of<HomeScreenProvider>(context,
                                        listen: false)
                                    .selectedString = "ProductInfo";
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 15),
                                child: ProductBox(
                                    expanded: false,
                                    height: height,
                                    width: width,
                                    title:
                                        "${snapshot.data.response[0].schoolAllProduct[index].productName}",
                                    image:
                                        "${snapshot.data.response[0].schoolAllProduct[index].productImg}",
                                    description:
                                        "${snapshot.data.response[0].schoolAllProduct[index].vendorCompanyName}",
                                    price: snapshot.data.response[0]
                                        .schoolAllProduct[index].productPrice,
                                    stock:
                                        "${snapshot.data.response[0].schoolAllProduct[index].productStockStatus}"),
                              ),
                            );
                          },
                        )),
                  ],
                );
              },
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            );
          }
        });
  }
}

Widget _tabs({title, color}) {
  return Column(
    children: [
      Text(
        title,
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 15,
          color: color,
        ),
        textAlign: TextAlign.left,
      ),
    ],
  );
}
