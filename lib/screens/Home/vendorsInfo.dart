import 'package:bookmrk/api/vendor_api.dart';
import 'package:bookmrk/model/vedor_product_info_model.dart';
import 'package:bookmrk/model/vendor_school_info_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
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

  Future getVendorProductInfo() async {
    dynamic response =
        await VendorAPI.getVendorProductInformation(widget.vendorSlug);
    VendorProductInfoModel _vendorProductInfo =
        VendorProductInfoModel.fromJson(response);

    dynamic response2 = await VendorAPI.getSchoolInformation(widget.vendorSlug);
    VendorSchoolInfoModel _vendorSchoolInfo =
        VendorSchoolInfoModel.fromJson(response2);
    List data = [_vendorProductInfo, _vendorSchoolInfo];
    print(response);
    print(response2);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return   Consumer<HomeScreenProvider>(
      builder: (context, _homeScreenProvider, child) {
        return Consumer<SchoolProvider>(
          builder: (_, _schoolProvider, child) {
            return Consumer<CategoryProvider>(
              builder: (_, _categoryProvider, child) {
                return Consumer<VendorProvider>(
                  builder: (_, _vendorProvider, child) {
                    return FutureBuilder(
                        future: getVendorProductInfo(),
                        builder: (context, snapshot) {
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
                            return Column(
                              children: [
                                Container(
                                  height: height / 4.5,
                                  decoration: BoxDecoration(
                                      color: colorPalette.purple,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.lerp(
                                              Radius.elliptical(50, 50),
                                              Radius.elliptical(70, 70),
                                              5.0))),
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
                                            image: NetworkImage(
                                                "${snapshot.data[0].response[0].vendor.companyLogo}"),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 15, bottom: 30),
                                        height: height / 7,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.5,
                                              child: Text(
                                                '${snapshot.data[0].response[0].vendor.companyName} ',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 25,
                                                  color:
                                                  const Color(0xffffffff),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Text(
                                              '${snapshot.data[0].response[0].vendor.allProductsCount} Products, ${snapshot.data[0].response[0].vendor.allSchoolCount} schools',
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
                                              '${snapshot.data[0].response[0].vendor.vendorName}',
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
                                Tabs(
                                  firstTitle: "All Products",
                                  secondTitle: "Schools",
                                  height: height,
                                  width: width,
                                  currentIndex:
                                  _homeScreenProvider.vendorSchoolIndex,
                                  firstTap: () =>
                                  homeProvider.vendorSchoolIndex = 0,
                                  secondTap: () =>
                                  homeProvider.vendorSchoolIndex = 1,
                                ),

                                /// when all product tab selected then show filter icon....
                                _homeScreenProvider.vendorSchoolIndex == 0
                                    ? GestureDetector(
                                  onTap: () {
                                    Provider.of<HomeScreenProvider>(
                                        context,
                                        listen: false)
                                        .selectedString = "Filter";
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: 10, top: 15, bottom: 10),
                                    alignment: Alignment.centerRight,
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
                                      _schoolProvider.schoolsToFilter
                                          .clear();

                                      snapshot.data[1].response[0]
                                          .vendorSchool
                                          .forEach((e) {
                                        if (e.schoolName
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                            value.toLowerCase())) {
                                          _schoolProvider
                                              .schoolsToFilterAddSingleSchool(
                                              e);
                                        }
                                      });
                                    }
                                  },
                                ),

                                /// when all product tab selected then show products....
                                _homeScreenProvider.vendorSchoolIndex == 0
                                    ? _categoryProvider
                                    .selectedFilterCategoryList
                                    .length >
                                    0
                                    ?

                                /// when filter is selected then show filtered list of product...
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SingleChildScrollView(
                                        child: Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                              snapshot.data[0].response[0]
                                                  .vendorProduct.length,
                                                  (index) {
                                                if (_categoryProvider
                                                    .selectedFilterCategoryList
                                                    .contains(snapshot
                                                    .data[0]
                                                    .response[0]
                                                    .vendorProduct[
                                                index]
                                                    .categoryName)) {
                                                  return GestureDetector(
                                                    onTap: () async {
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
                                                    child: Container(
                                                      width: (width / 2) -
                                                          30.0,
                                                      margin:
                                                      EdgeInsets.only(
                                                          right: 10.0,
                                                          bottom:
                                                          10.0),
                                                      height: 230,
                                                      child: ProductBox(
                                                          expanded: true,
                                                          height: height,
                                                          width: width,
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
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: GridView.builder(
                                      gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 300,
                                          childAspectRatio: 0.75,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {

                                            Provider.of<ProductOrderProvider>(
                                                context,
                                                listen: false)
                                                .selectedVariation2Option =
                                            null;
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
                                              expanded: true,
                                              height: height,
                                              width: width,
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
                                    :

                                /// when school tab selected then show school list...
                                Expanded(
                                  child: _schoolProvider
                                      .isSearchSchoolTabSelected
                                      ? ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: index == 14
                                            ? EdgeInsets.only(
                                            bottom: 70)
                                            : EdgeInsets.all(0),
                                        child: SchoolImageBox(
                                            height: height,
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
                                                  .selectedSchoolSlug =
                                              "${_schoolProvider.schoolsToFilter[index].schoolSlug}";
                                              Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                                  .selectedString =
                                              "SchoolInfo";
                                            }),
                                      );
                                    },
                                    itemCount: _schoolProvider
                                        .schoolsToFilter.length,
                                  )
                                      : ListView.builder(
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: index == 14
                                            ? EdgeInsets.only(
                                            bottom: 70)
                                            : EdgeInsets.all(0),
                                        child: SchoolImageBox(
                                            height: height,
                                            image:
                                            "${snapshot.data[1].response[0].vendorSchool[index].schoolLogo}",
                                            description:
                                            "${snapshot.data[1].response[0].vendorSchool[index].address}, ${snapshot.data[1].response[0].vendorSchool[index].city}, ${snapshot.data[1].response[0].vendorSchool[index].pincode}",
                                            title:
                                            "${snapshot.data[1].response[0].vendorSchool[index].schoolName}",
                                            onTap: () {
                                              Provider.of<SchoolProvider>(
                                                  context,
                                                  listen: false)
                                                  .selectedSchoolSlug =
                                              "${snapshot.data[1].response[0].vendorSchool[index].schoolSlug}";
                                              Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                                  .selectedString =
                                              "SchoolInfo";
                                            }),
                                      );
                                    },
                                    itemCount: snapshot
                                        .data[1]
                                        .response[0]
                                        .vendorSchool
                                        .length,
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
                        });
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

