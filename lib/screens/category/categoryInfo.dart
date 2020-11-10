import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_product_model.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryInfo extends StatefulWidget {
  final String categoryName;

  const CategoryInfo(this.categoryName);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  Future getCategoryProductsDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic categoryProductsDetails = await CategoryAPI.getCategoryProducts(
        widget.categoryName, userId.toString());
    if (categoryProductsDetails['response'].length == "0") {
      NoDataOrderModel _noDataModel =
          NoDataOrderModel.fromJson(categoryProductsDetails);
      return _noDataModel;
    } else {
      CategoryProductsModel _categoryProductModelDetails =
          CategoryProductsModel.fromJson(categoryProductsDetails);
      return _categoryProductModelDetails;
    }
  }

  Future getSubCategoryProductsDetails(String subCategoryName) async {
    int userId = prefs.read<int>('userId');
    dynamic categoryProductsDetails = await CategoryAPI.getCategoryProducts(
        subCategoryName, userId.toString());
    if (categoryProductsDetails['response'].length == "0") {
      NoDataOrderModel _noDataModel =
          NoDataOrderModel.fromJson(categoryProductsDetails);
      return _noDataModel;
    } else {
      CategoryProductsModel _categoryProductModelDetails =
          CategoryProductsModel.fromJson(categoryProductsDetails);
      return _categoryProductModelDetails;
    }
  }

  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getCategoryProductsDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.response.length <= 0) {
              return Center(
                child: Text(
                  'No Products !',
                  style: TextStyle(fontSize: 18.0),
                ),
              );
            } else {
              return Column(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            '${snapshot.data.response[0].category[0].categoryImg}',
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${snapshot.data.response[0].category[0].categoryImg}"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, s) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/images/preload.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        errorWidget: (context, s, d) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage("assets/images/preload.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black.withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${snapshot.data.response[0].category[0].categoryName}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              '${snapshot.data.response[0].category[0].allProductsCount ?? "0"} Products',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 20,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Consumer<CategoryProvider>(
                    builder: (_, _categoryProvider, child) =>
                        Consumer<HomeScreenProvider>(
                      builder: (_, _homeScreenProvider, child) => Container(
                        height: snapshot.data.response[0].subCategory.length > 0
                            ? height / 25
                            : height / 45,
                        child: snapshot.data.response[0].subCategory.length > 0
                            ? SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: _categoryProvider
                                                            .selectedSubCategory ==
                                                        "" ||
                                                    _categoryProvider
                                                            .selectedSubCategory ==
                                                        null
                                                ? colorPalette.navyBlue
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            _categoryProvider
                                                .selectedSubCategory = "";
                                          },
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                fontSize: 14,
                                                color: _categoryProvider
                                                                .selectedSubCategory ==
                                                            "" ||
                                                        _categoryProvider
                                                                .selectedSubCategory ==
                                                            null
                                                    ? Colors.white
                                                    : colorPalette.navyBlue),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: List.generate(
                                        snapshot.data.response[0].subCategory
                                            .length,
                                        (index) => GestureDetector(
                                          onTap: () {
                                            // _homeScreenProvider
                                            //     .selectedString =
                                            // "SubCategoryInfo";
                                            _categoryProvider
                                                    .selectedSubCategory =
                                                "${snapshot.data.response[0].subCategory[index].catSlug}";
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: _categoryProvider
                                                            .selectedSubCategory ==
                                                        "${snapshot.data.response[0].subCategory[index].catSlug}"
                                                    ? colorPalette.navyBlue
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10.0),
                                            child: Text(
                                              '${snapshot.data.response[0].subCategory[index].categoryName}',
                                              style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color: _categoryProvider
                                                              .selectedSubCategory ==
                                                          "${snapshot.data.response[0].subCategory[index].catSlug}"
                                                      ? Colors.white
                                                      : colorPalette.navyBlue),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ),
                    ),
                  ),
                  Consumer<CategoryProvider>(
                      builder: (_, _categoryProvider, child) {
                    if (_categoryProvider.selectedSubCategory == "" ||
                        _categoryProvider.selectedSubCategory == null) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                          .selectedTitle =
                                      "${snapshot.data.response[0].product[index].productName}";

                                  Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedProductSlug =
                                      "${snapshot.data.response[0].product[index].productSlug}";
                                  Provider.of<VendorProvider>(context,
                                              listen: false)
                                          .selectedVendorName =
                                      "${snapshot.data.response[0].product[index].vendorSlug}";
                                  Provider.of<HomeScreenProvider>(context,
                                          listen: false)
                                      .selectedString = "ProductInfo";
                                },
                                child: ProductBox(
                                  expanded: true,
                                  height: height,
                                  width: width,
                                  title:
                                      "${snapshot.data.response[0].product[index].productName}",
                                  image:
                                      "${snapshot.data.response[0].product[index].productImg}",
                                  description:
                                      "${snapshot.data.response[0].product[index].vendorCompanyName}",
                                  price: snapshot.data.response[0]
                                      .product[index].productPrice,
                                  stock:
                                      "${snapshot.data.response[0].product[index].productStockStatus}",
                                ),
                              );
                            },
                            itemCount: snapshot.data.response[0].product.length,
                          ),
                        ),
                      );
                    } else {
                      return FutureBuilder(
                          future: getSubCategoryProductsDetails(
                              _categoryProvider.selectedSubCategory),
                          builder: (context, subSnap) {
                            if (subSnap.hasData) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
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
                                        onTap: () {
                                          Provider.of<HomeScreenProvider>(
                                                      context,
                                                      listen: false)
                                                  .selectedTitle =
                                              "${subSnap.data.response[0].product[index].productName}";
                                          Provider.of<HomeScreenProvider>(
                                                      context,
                                                      listen: false)
                                                  .selectedProductSlug =
                                              "${subSnap.data.response[0].product[index].productSlug}";
                                          Provider.of<VendorProvider>(context,
                                                      listen: false)
                                                  .selectedVendorName =
                                              "${subSnap.data.response[0].product[index].vendorSlug}";
                                          Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedString = "ProductInfo";
                                        },
                                        child: ProductBox(
                                          expanded: true,
                                          height: height,
                                          width: width,
                                          title:
                                              "${subSnap.data.response[0].product[index].productName}",
                                          image:
                                              "${subSnap.data.response[0].product[index].productImg}",
                                          description:
                                              "${subSnap.data.response[0].product[index].vendorCompanyName}",
                                          price: subSnap.data.response[0]
                                              .product[index].productPrice,
                                          stock:
                                              "${subSnap.data.response[0].product[index].productStockStatus}",
                                        ),
                                      );
                                    },
                                    itemCount:
                                        subSnap.data.response[0].product.length,
                                  ),
                                ),
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
                    }
                  }),
                ],
              );
            }
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
