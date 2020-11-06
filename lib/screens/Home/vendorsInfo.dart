import 'package:bookmrk/api/vendor_api.dart';
import 'package:bookmrk/model/vedor_product_info_model.dart';
import 'package:bookmrk/model/vendor_school_info_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/appBar.dart';
import 'package:bookmrk/widgets/schoolImageBox.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VendorsInfo extends StatefulWidget {
  final String vendorSlug;

  const VendorsInfo({this.vendorSlug});

  @override
  _VendorsInfoState createState() => _VendorsInfoState();
}

class _VendorsInfoState extends State<VendorsInfo> {
  ColorPalette colorPalette = ColorPalette();
  ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0.0);

  Future getVendorProductInfo() async {
    dynamic response =
        await VendorAPI.getVendorProductInformation(widget.vendorSlug);
    VendorProductInfoModel _vendorProductInfo =
        VendorProductInfoModel.fromJson(response);

    dynamic response2 = await VendorAPI.getSchoolInformation(widget.vendorSlug);
    VendorSchoolInfoModel _vendorSchoolInfo =
        VendorSchoolInfoModel.fromJson(response2);
    List data = [_vendorProductInfo, _vendorSchoolInfo];

    return data;
  }

  /// scroll capture
  getScrollDetails() {
    Provider.of<VendorProvider>(context, listen: false)
        .customScrollCurrentPixels = 0.0;
    _scrollController.addListener(() {
      Provider.of<VendorProvider>(context, listen: false)
          .customScrollCurrentPixels = _scrollController.position.pixels;
      if (_scrollController.position.pixels > 70) {
        Provider.of<VendorProvider>(context, listen: false)
            .isCustomScrollAtLimit = true;
      } else {
        Provider.of<VendorProvider>(context, listen: false)
            .isCustomScrollAtLimit = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getScrollDetails();
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: FutureBuilder(
        future: getVendorProductInfo(),
        builder: (context, snapshot) {
          return Consumer<HomeScreenProvider>(
            builder: (context, _homeScreenProvider, child) {
              return Consumer<SchoolProvider>(
                builder: (_, _schoolProvider, child) {
                  return Consumer<CategoryProvider>(
                    builder: (_, _categoryProvider, child) {
                      return Consumer<VendorProvider>(
                        builder: (_, _vendorProvider, child) {
                          if (snapshot.hasError) {
                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      colorPalette.navyBlue),
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {
                            return Stack(
                              children: [
                                SingleChildScrollView(
                                  controller: _scrollController,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 60,
                                        color: colorPalette.purple,
                                        child: AppBar(
                                          automaticallyImplyLeading: false,
                                          elevation: 0.5,
                                          backgroundColor: colorPalette.purple,
                                          flexibleSpace: Container(
                                            padding: EdgeInsets.only(left: 16, right: 16, top: 35),
                                            decoration: BoxDecoration(boxShadow: [
                                              BoxShadow(
                                                offset: Offset(0, 1),
                                                blurRadius: 8,
                                                color: Color(0xff676767).withOpacity(0.05),
                                              ),
                                            ], color: colorPalette.purple),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width / 1.9,
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: (){
                                                          _homeScreenProvider.selectedString = "Home";
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_back_ios,
                                                          color: _homeScreenProvider
                                                              .selectedString ==
                                                              "VendorInfo"
                                                              ? Colors.white
                                                              : colorPalette.navyBlue,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Spacer(),
                                                GestureDetector(
                                                  onTap: (){},
                                                  child: Stack(
                                                    alignment: Alignment.topRight,
                                                    children: [
                                                      CircleAvatar(
                                                        child: SvgPicture.asset(
                                                          "assets/icons/Cart.svg",
                                                          height: 30,
                                                          width: 30,
                                                          color:Colors.white,
                                                        ),
                                                        radius: 25,
                                                        backgroundColor: Colors.transparent,
                                                      ),
//                Consumer<HomeScreenProvider>(
//                    builder: (_, _homeScreenProvider, child) {
//                  return CircleAvatar(
//                    radius: 10,
//                    child: Text(
//                      '${_homeScreenProvider.totalNumberOfOrdersInCart}',
//                      style: TextStyle(
//                        fontFamily: 'Roboto',
//                        fontSize: 13,
//                        color: const Color(0xffffffff),
//                      ),
//                      textAlign: TextAlign.left,
//                    ),
//                    backgroundColor: colorPalette.pinkOrange,
//                  );
//                })
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: (){},
                                                  child: Stack(
                                                    alignment: Alignment.topRight,
                                                    children: [
                                                      CircleAvatar(
                                                        child: SvgPicture.asset(
                                                          "assets/icons/bell.svg",
                                                          height: 30,
                                                          width: 30,
                                                          color: Colors.white,
                                                        ),
                                                        radius: 25,
                                                        backgroundColor: Colors.transparent,
                                                      ),
                                                      Consumer<HomeScreenProvider>(
                                                          builder: (_, _homeScreenProvider, child) {
                                                            return CircleAvatar(
                                                              radius: 10,
                                                              child: Text(
                                                                '${_homeScreenProvider.totalNewNotifications}',
                                                                style: TextStyle(
                                                                  fontFamily: 'Roboto',
                                                                  fontSize: 13,
                                                                  color: const Color(0xffffffff),
                                                                ),
                                                                textAlign: TextAlign.left,
                                                              ),
                                                              backgroundColor: colorPalette.pinkOrange,
                                                            );
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: height / 4.5,
                                        decoration: BoxDecoration(
                                            color: colorPalette.purple,
                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.lerp(
                                                    Radius.elliptical(50, 50),
                                                    Radius.elliptical(
                                                        70 -
                                                            (_vendorProvider
                                                                .customScrollCurrentPixels /
                                                                5),
                                                        70 -
                                                            (_vendorProvider
                                                                .customScrollCurrentPixels /
                                                                5)),
                                                    5.0))),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin:
                                              EdgeInsets.only(left: 15),
                                              height: height / 7,
                                              width: height / 7,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${snapshot.data[0].response[0].vendor.companyLogo}"),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 15, bottom: 15),
                                              height: height / 5,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width:
                                                    MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.5,
                                                    child: Text(
                                                      '${snapshot.data[0].response[0].vendor.companyName} ',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 20,
                                                        color: const Color(
                                                            0xffffffff),
                                                        fontWeight:
                                                        FontWeight.w700,
                                                      ),
                                                      textAlign:
                                                      TextAlign.left,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                    width: width / 2,
                                                    child: Text(
                                                      '${snapshot.data[0].response[0].vendor.allProductsCount} Products, ${snapshot.data[0].response[0].vendor.allSchoolCount} schools',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 17,
                                                        color: const Color(
                                                            0xffe5e5e5),
                                                      ),
                                                      textAlign:
                                                      TextAlign.left,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: width / 2,
                                                    child: Text(
                                                      '${snapshot.data[0].response[0].vendor.vendorName}',
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 17,
                                                        color: const Color(
                                                            0xffe5e5e5),
                                                      ),
                                                      textAlign:
                                                      TextAlign.left,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Tabs(
                                        firstTitle: "All Products",
                                        secondTitle: "Schools",
                                        height: height,
                                        width: width,
                                        currentIndex: _homeScreenProvider
                                            .vendorSchoolIndex,
                                        firstTap: () => homeProvider
                                            .vendorSchoolIndex = 0,
                                        secondTap: () => homeProvider
                                            .vendorSchoolIndex = 1,
                                      ),

                                      /// when all product tab selected then show filter icon....
                                      _homeScreenProvider.vendorSchoolIndex ==
                                          0
                                          ? GestureDetector(
                                        onTap: () {
                                          Provider.of<HomeScreenProvider>(
                                              context,
                                              listen: false)
                                              .selectedString =
                                          "Filter";
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              right: 10,
                                              top: 15,
                                              bottom: 10),
                                          alignment:
                                          Alignment.centerRight,
                                          child: SvgPicture.asset(
                                            "assets/icons/filter.svg",
                                          ),
                                        ),
                                      )
                                          :

                                      /// when schools tab selected then show search bar....
                                      SearchBar(
                                        width: width,
                                        title: "Search Schools",
                                        onChanged: (value) {
                                          if (value.length < 1) {
                                            _schoolProvider
                                                .isSearchSchoolTabSelected =
                                            false;
                                          } else {
                                            _schoolProvider
                                                .isSearchSchoolTabSelected =
                                            true;
                                            _schoolProvider
                                                .schoolsToFilter
                                                .clear();

                                            snapshot.data[1].response[0]
                                                .vendorSchool
                                                .forEach((e) {
                                              if (e.schoolName
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(value
                                                  .toLowerCase())) {
                                                _schoolProvider
                                                    .schoolsToFilterAddSingleSchool(
                                                    e);
                                              }
                                            });
                                          }
                                        },
                                      ),

                                      /// when all product tab selected then show products....
                                      _homeScreenProvider.vendorSchoolIndex ==
                                          0
                                          ? _categoryProvider
                                          .selectedFilterCategoryList
                                          .length >
                                          0
                                          ?

                                      /// when filter is selected then show filtered list of product...
                                      Container(
                                          height: height,
                                          width: width,
                                          color: Colors.blue,
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 10),
                                            child:
                                            SingleChildScrollView(
                                              child: Wrap(
                                                  direction:
                                                  Axis.horizontal,
                                                  children:
                                                  List.generate(
                                                    snapshot
                                                        .data[0]
                                                        .response[0]
                                                        .vendorProduct
                                                        .length,
                                                        (index) {
                                                      if (_categoryProvider
                                                          .selectedFilterCategoryList
                                                          .contains(snapshot
                                                          .data[0]
                                                          .response[
                                                      0]
                                                          .vendorProduct[
                                                      index]
                                                          .categoryName)) {
                                                        return GestureDetector(
                                                          onTap:
                                                              () async {
                                                            Provider.of<ProductOrderProvider>(
                                                                context,
                                                                listen: false)
                                                                .selectedVariation2Option = null;
                                                            _homeScreenProvider
                                                                .selectedProductSlug =
                                                            "${snapshot.data[0].response[0].vendorProduct[index].productSlug}";
                                                            _vendorProvider
                                                                .selectedVendorName =
                                                            "${snapshot.data[0].response[0].vendorProduct[index].vendorSlug}";
                                                            _homeScreenProvider
                                                                .selectedString =
                                                            "ProductInfo";
                                                          },
                                                          child:
                                                          Container(
                                                            width: (width /
                                                                2) -
                                                                30.0,
                                                            margin: EdgeInsets.only(
                                                                right:
                                                                10.0,
                                                                bottom:
                                                                10.0),
                                                            height:
                                                            230,
                                                            child: ProductBox(
                                                                expanded:
                                                                true,
                                                                height:
                                                                height,
                                                                width:
                                                                width,
                                                                title:
                                                                "${snapshot.data[0].response[0].vendorProduct[index].productName}",
                                                                description:
                                                                "${snapshot.data[0].response[0].vendorProduct[index].vendorCompanyName}",
                                                                price:
                                                                "${snapshot.data[0].response[0].vendorProduct[index].productPrice}",
                                                                stock:
                                                                "${snapshot.data[0].response[0].vendorProduct[index].productStockStatus}",
                                                                image:
                                                                "${snapshot.data[0].response[0].vendorProduct[index].productImg}"),
                                                          ),
                                                        );
                                                      } else {
                                                        return SizedBox();
                                                      }
                                                    },
                                                  )),
                                            ),
                                          ))
                                          :

                                      /// when any filter is not selected then show list of all products...
                                      snapshot
                                          .data[0]
                                          .response[0]
                                          .vendorProduct
                                          .length >
                                          0
                                          ? Container(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              10),
                                          child:
                                          GridView.builder(
                                            shrinkWrap: true,
                                            physics:
                                            NeverScrollableScrollPhysics(),
                                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent:
                                                300,
                                                childAspectRatio:
                                                0.75,
                                                crossAxisSpacing:
                                                10,
                                                mainAxisSpacing:
                                                10),
                                            itemBuilder:
                                                (context,
                                                index) {
                                              return GestureDetector(
                                                onTap:
                                                    () async {
                                                  Provider.of<ProductOrderProvider>(
                                                      context,
                                                      listen:
                                                      false)
                                                      .selectedVariation2Option = null;
                                                  _homeScreenProvider
                                                      .selectedProductSlug =
                                                  "${snapshot.data[0].response[0].vendorProduct[index].productSlug}";
                                                  _vendorProvider
                                                      .selectedVendorName =
                                                  "${snapshot.data[0].response[0].vendorProduct[index].vendorSlug}";
                                                  _homeScreenProvider
                                                      .selectedString =
                                                  "ProductInfo";
                                                },
                                                child: ProductBox(
                                                    expanded:
                                                    true,
                                                    height:
                                                    height,
                                                    width:
                                                    width,
                                                    title:
                                                    "${snapshot.data[0].response[0].vendorProduct[index].productName}",
                                                    description:
                                                    "${snapshot.data[0].response[0].vendorProduct[index].vendorCompanyName}",
                                                    price:
                                                    "${snapshot.data[0].response[0].vendorProduct[index].productPrice}",
                                                    stock:
                                                    "${snapshot.data[0].response[0].vendorProduct[index].productStockStatus}",
                                                    image:
                                                    "${snapshot.data[0].response[0].vendorProduct[index].productImg}"),
                                              );
                                            },
                                            itemCount: snapshot
                                                .data[0]
                                                .response[0]
                                                .vendorProduct
                                                .length,
                                          ),
                                        ),
                                      )
                                          : Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/icons/no_data.svg',
                                              height: 100),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Text(
                                            '0 Products',
                                            style: TextStyle(
                                                color:
                                                colorPalette
                                                    .navyBlue,
                                                fontSize: 20),
                                          )
                                        ],
                                      )
                                          :

                                      /// when school tab selected then show school list...
                                      Container(
                                        child: _schoolProvider
                                            .isSearchSchoolTabSelected
                                            ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (context, index) {
                                            return Padding(
                                              padding: index == 14
                                                  ? EdgeInsets
                                                  .only(
                                                  bottom:
                                                  70)
                                                  : EdgeInsets
                                                  .all(0),
                                              child:
                                              SchoolImageBox(
                                                  height:
                                                  height,
                                                  image:
                                                  "${_schoolProvider.schoolsToFilter[index].schoolLogo}",
                                                  description:
                                                  "${_schoolProvider.schoolsToFilter[index].address}, ${_schoolProvider.schoolsToFilter[index].city}, ${_schoolProvider.schoolsToFilter[index].pincode}",
                                                  title:
                                                  "${_schoolProvider.schoolsToFilter[index].schoolName}",
                                                  onTap: () {
                                                    Provider.of<SchoolProvider>(
                                                        context,
                                                        listen: false)
                                                        .selectedSchoolSlug = "${_schoolProvider.schoolsToFilter[index].schoolSlug}";
                                                    Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                        .selectedString = "SchoolInfo";
                                                  }),
                                            );
                                          },
                                          itemCount:
                                          _schoolProvider
                                              .schoolsToFilter
                                              .length,
                                        )
                                            : snapshot
                                            .data[1]
                                            .response[0]
                                            .vendorSchool
                                            .length >
                                            0
                                            ? ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          itemBuilder:
                                              (context,
                                              index) {
                                            return Padding(
                                              padding: index ==
                                                  14
                                                  ? EdgeInsets.only(
                                                  bottom:
                                                  70)
                                                  : EdgeInsets
                                                  .all(0),
                                              child:
                                              SchoolImageBox(
                                                  height:
                                                  height,
                                                  image:
                                                  "${snapshot.data[1].response[0].vendorSchool[index].schoolLogo}",
                                                  description:
                                                  "${snapshot.data[1].response[0].vendorSchool[index].address}, ${snapshot.data[1].response[0].vendorSchool[index].city}, ${snapshot.data[1].response[0].vendorSchool[index].pincode}",
                                                  title:
                                                  "${snapshot.data[1].response[0].vendorSchool[index].schoolName}",
                                                  onTap:
                                                      () {
                                                    Provider.of<SchoolProvider>(context, listen: false).selectedSchoolSlug =
                                                    "${snapshot.data[1].response[0].vendorSchool[index].schoolSlug}";
                                                    Provider.of<HomeScreenProvider>(context, listen: false).selectedString =
                                                    "SchoolInfo";
                                                  }),
                                            );
                                          },
                                          itemCount: snapshot
                                              .data[1]
                                              .response[0]
                                              .vendorSchool
                                              .length,
                                        )
                                            : Column(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/no_data.svg',
                                                height: 100),
                                            SizedBox(
                                              height: 20.0,
                                            ),
                                            Text(
                                              '0 School',
                                              style: TextStyle(
                                                  color: colorPalette
                                                      .navyBlue,
                                                  fontSize:
                                                  20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _vendorProvider.customScrollCurrentPixels < 150 ? SizedBox() : Opacity(
                                  opacity: _vendorProvider.customScrollCurrentPixels < 150 ? 0 : _vendorProvider.customScrollCurrentPixels < 200 ? (_vendorProvider.customScrollCurrentPixels / 201) : 1,
                                  child: Container(
                                    color: colorPalette.purple,
                                    height: 60,
                                    width: width,
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text('${snapshot.data[0].response[0].vendor.companyName}', style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 25,
                                      color: const Color(
                                          0xffffffff),
                                      fontWeight:
                                      FontWeight.w700,
                                    ),),
                                  ),
                                ),
                              ],
                            );
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
                      );
                    },
                  );
                },
              );
            },
          );
        }
      ),
    );
  }
}
