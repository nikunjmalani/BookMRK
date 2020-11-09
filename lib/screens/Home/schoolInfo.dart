import 'package:bookmrk/api/school_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/school_product_model.dart';
import 'package:bookmrk/model/school_subcategory_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

  /// api to get school product details....
  Future getSchoolProductDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic data = await SchoolAPI.getSchoolProductDetails(
        widget.schoolSlug, userId.toString());

    SchoolProductsModel _schoolProductModel =
        SchoolProductsModel.fromJson(data);
    return _schoolProductModel;
  }

  /// call api for get products of selected subcategory in school...
  Future getSubCategoryProducts(String subCategoryId) async {
    int userId = prefs.read<int>('userId');
    dynamic response = await SchoolAPI.getSubcategoryProductsOfSchool(
        userId.toString(), widget.schoolSlug, subCategoryId.toString());
    SchoolSubcategoryModel _schoolSubcategoryModel =
        SchoolSubcategoryModel.fromJson(response);
    return _schoolSubcategoryModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getSchoolProductDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Consumer<SchoolProvider>(
            builder: (_, _schoolProvider, child) =>
                Consumer<HomeScreenProvider>(
              builder: (context, data, child) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
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
                          pages: snapshot.data.response[0].school[0]
                                      .schoolBanners.length ==
                                  0
                              ? snapshot.data.response[0].school.length
                              : snapshot.data.response[0].school[0]
                                  .schoolBanners.length),
                      SizedBox(
                        height: 10,
                      ),
                      BlueHeader(
                          "${snapshot.data.response[0].school[0].schoolName}"),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: descrip(
                            "${snapshot.data.response[0].school[0].address}. ${snapshot.data.response[0].school[0].city}, ${snapshot.data.response[0].school[0].pincode}"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: height / 24,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: _schoolProvider.selectedSubCategoryId ==
                                            '${snapshot.data.response[0].schoolCat[index].categoryId}' ||
                                        _schoolProvider
                                                .selectedSchoolCategoryIndex ==
                                            index
                                    ? colorPalette.navyBlue
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              height: 25,
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  _schoolProvider.selectedSchoolCategoryIndex =
                                      index;
                                  _schoolProvider.selectedSubCategoryId =
                                      '${snapshot.data.response[0].schoolCat[index].categoryId}';
                                },
                                child: Text(
                                  '${snapshot.data.response[0].schoolCat[index].categoryName}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                    fontWeight: _schoolProvider
                                                    .selectedSubCategoryId ==
                                                '${snapshot.data.response[0].schoolCat[index].categoryId}' ||
                                            _schoolProvider
                                                    .selectedSchoolCategoryIndex ==
                                                index
                                        ? FontWeight.w900
                                        : FontWeight.w500,
                                    color: _schoolProvider
                                                    .selectedSubCategoryId ==
                                                '${snapshot.data.response[0].schoolCat[index].categoryId}' ||
                                            _schoolProvider
                                                    .selectedSchoolCategoryIndex ==
                                                index
                                        ? Colors.white
                                        : colorPalette.navyBlue,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            );
                          },
                          itemCount: snapshot.data.response[0].schoolCat.length,
                        ),
                      ),
                      FutureBuilder(
                        future: getSubCategoryProducts(_schoolProvider
                                .selectedSubCategoryId ??
                            "${snapshot.data.response[0].schoolCat[0].categoryId}"),
                        builder: (context, subCatSnapshot) {
                          if (subCatSnapshot.hasData) {
                            if (subCatSnapshot.data.response.length > 0) {
                              return Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Available Products',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            color: const Color(0xffb7b7b7),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Spacer(),
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              child: Text('All'),
                                              value: "All",
                                            ),
                                            PopupMenuItem(
                                              child: Text('Single'),
                                              value: "Single",
                                            ),
                                            PopupMenuItem(
                                              child: Text('Set'),
                                              value: "Set",
                                            ),
                                          ],
                                          onSelected: (value) {
                                            _schoolProvider
                                                    .selectedSchoolProductType =
                                                value;
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                  '${_schoolProvider.selectedSchoolProductType}'),
                                              SizedBox(
                                                width: 5.0,
                                              ),
                                              Icon(Icons.arrow_drop_down)
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: height / 2.7,
                                      width: width,
                                      child: ListView.builder(
                                        itemCount:
                                            subCatSnapshot.data.response.length,
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          if (_schoolProvider
                                                  .selectedSchoolProductType ==
                                              "Single") {
                                            if (subCatSnapshot.data.response[0]
                                                    .productType ==
                                                "Single") {
                                              return GestureDetector(
                                                onTap: () {
                                                  Provider.of<VendorProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedVendorName =
                                                      "${subCatSnapshot.data.response[index].vendorSlug}";

                                                  Provider.of<HomeScreenProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedProductSlug =
                                                      "${subCatSnapshot.data.response[index].productSlug}";

                                                  Provider.of<HomeScreenProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedString =
                                                      "ProductInfo";
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: ProductBox(
                                                      expanded: false,
                                                      height: height,
                                                      width: width,
                                                      title:
                                                          "${subCatSnapshot.data.response[index].productName}",
                                                      image:
                                                          "${subCatSnapshot.data.response[index].productImg}",
                                                      description:
                                                          "${subCatSnapshot.data.response[index].vendorCompanyName}",
                                                      price: subCatSnapshot
                                                          .data
                                                          .response[index]
                                                          .productPrice,
                                                      stock:
                                                          "${subCatSnapshot.data.response[index].productStockStatus}",
                                                      discount:
                                                          "${subCatSnapshot.data.response[index].productDiscount}"),
                                                ),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          } else if (_schoolProvider
                                                  .selectedSchoolProductType ==
                                              "Set") {
                                            if (subCatSnapshot
                                                    .data
                                                    .response[index]
                                                    .productType ==
                                                "Set") {
                                              return GestureDetector(
                                                onTap: () {
                                                  Provider.of<VendorProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedVendorName =
                                                      "${subCatSnapshot.data.response[index].vendorSlug}";

                                                  Provider.of<HomeScreenProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedProductSlug =
                                                      "${subCatSnapshot.data.response[index].productSlug}";

                                                  Provider.of<HomeScreenProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedString =
                                                      "ProductInfo";
                                                },
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.only(left: 15),
                                                  child: ProductBox(
                                                      expanded: false,
                                                      height: height,
                                                      width: width,
                                                      title:
                                                          "${subCatSnapshot.data.response[index].productName}",
                                                      image:
                                                          "${subCatSnapshot.data.response[index].productImg}",
                                                      description:
                                                          "${subCatSnapshot.data.response[index].vendorCompanyName}",
                                                      price: subCatSnapshot
                                                          .data
                                                          .response[index]
                                                          .productPrice,
                                                      stock:
                                                          "${subCatSnapshot.data.response[index].productStockStatus}",
                                                      discount:
                                                          "${subCatSnapshot.data.response[index].productDiscount}"),
                                                ),
                                              );
                                            } else {
                                              return SizedBox();
                                            }
                                          } else {
                                            return GestureDetector(
                                              onTap: () {
                                                Provider.of<VendorProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedVendorName =
                                                    "${subCatSnapshot.data.response[index].vendorSlug}";

                                                Provider.of<HomeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedProductSlug =
                                                    "${subCatSnapshot.data.response[index].productSlug}";

                                                Provider.of<HomeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedString =
                                                    "ProductInfo";
                                              },
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 15),
                                                child: ProductBox(
                                                    expanded: false,
                                                    height: height,
                                                    width: width,
                                                    title:
                                                        "${subCatSnapshot.data.response[index].productName}",
                                                    image:
                                                        "${subCatSnapshot.data.response[index].productImg}",
                                                    description:
                                                        "${subCatSnapshot.data.response[index].vendorCompanyName}",
                                                    price: subCatSnapshot
                                                        .data
                                                        .response[index]
                                                        .productPrice,
                                                    stock:
                                                        "${subCatSnapshot.data.response[index].productStockStatus}",
                                                    discount:
                                                        "${subCatSnapshot.data.response[index].productDiscount}"),
                                              ),
                                            );
                                          }
                                        },
                                      )),
                                ],
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 30.0,
                                  bottom: 20,
                                ),
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/no_data.svg',
                                      height: 100,
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Text(
                                      'Products not found !',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      colorPalette.navyBlue),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      snapshot.data.response[0].schoolAllProduct.length > 0
                          ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Row(
                                children: [
                                  Text(
                                    'Other Products',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 16,
                                      color: const Color(0xffb7b7b7),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      snapshot.data.response[0].schoolAllProduct.length > 0
                          ? Container(
                              height: height / 2.7,
                              width: width,
                              child: ListView.builder(
                                itemCount: snapshot
                                    .data.response[0].schoolAllProduct.length,
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
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
                                          price: snapshot
                                              .data
                                              .response[0]
                                              .schoolAllProduct[index]
                                              .productPrice,
                                          stock:
                                              "${snapshot.data.response[0].schoolAllProduct[index].productStockStatus}",
                                          discount:
                                              "${snapshot.data.response[index].productDiscount}"),
                                    ),
                                  );
                                },
                              ))
                          : SizedBox(),
                      SizedBox(height: 50),
                    ],
                  ),
                );
              },
            ),
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
      },
    );
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
