import 'package:bookmrk/api/vendor_api.dart';
import 'package:bookmrk/model/vedor_product_info_model.dart';
import 'package:bookmrk/model/vendor_school_info_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
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
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return FutureBuilder(
            future: getVendorProductInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
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
                            margin: EdgeInsets.only(left: 15, bottom: 30),
                            height: height / 7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    '${snapshot.data[0].response[0].vendor.companyName} ',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 25,
                                      color: const Color(0xffffffff),
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
                      currentIndex: data.vendorSchoolIndex,
                      firstTap: () => homeProvider.vendorSchoolIndex = 0,
                      secondTap: () => homeProvider.vendorSchoolIndex = 1,
                    ),
                    data.vendorSchoolIndex == 0
                        ? GestureDetector(
                            onTap: () {
                              Provider.of<HomeScreenProvider>(context,
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
                        : SearchBar(
                            width: width,
                            title: "Search Schools",
                            onTap: () {},
                          ),
                    data.vendorSchoolIndex == 0
                        ? Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
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
                                    .data[0].response[0].vendorProduct.length,
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
                                      image:
                                          "${snapshot.data[1].response[0].vendorSchool[index].schoolLogo}",
                                      description:
                                          "${snapshot.data[1].response[0].vendorSchool[index].address}, ${snapshot.data[1].response[0].vendorSchool[index].city}, ${snapshot.data[1].response[0].vendorSchool[index].pincode}",
                                      title: "Central Public School",
                                      onTap: () {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "SchoolInfo";
                                      }),
                                );
                              },
                              itemCount: snapshot
                                  .data[1].response[0].vendorSchool.length,
                            ),
                          ),
                  ],
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
      },
    );
  }
}
