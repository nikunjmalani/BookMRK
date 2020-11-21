
import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/filter_class_category_model.dart';
import 'package:bookmrk/model/filter_subject_category_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterCategorySubject extends StatefulWidget {
  final String selectedSubject;

  const FilterCategorySubject(this.selectedSubject);

  @override
  _FilterCategorySubjectState createState() => _FilterCategorySubjectState();
}

class _FilterCategorySubjectState extends State<FilterCategorySubject> {

  ColorPalette colorPalette = ColorPalette();


  /// api to get filter category list data....
  Future getFilterCategoryListData() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await CategoryAPI.getFilterCategory(userId.toString(), 'subject', widget.selectedSubject);
    FilterSubjectCategoryModel _filterSubjectCategoryModel = FilterSubjectCategoryModel.fromJson(response);
    return _filterSubjectCategoryModel;

  }


  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getFilterCategoryListData(),
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
                        '${snapshot.data.response[0].subject[0].subjectImg}',
                        fit: BoxFit.cover,
                        imageBuilder: (context, imageProvider) => Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          height: height / 12,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  "${snapshot.data.response[0].subject[0].classubjectImgsImg}"),
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
                            Container(
                              width: width / 2,
                              child: Text(
                                '${snapshot.data.response[0].subject[0].subjectName}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                  color: const Color(0xffffffff),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              '${snapshot.data.response[0].subject[0].allProductsCount ?? "0"} Products',
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

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 70),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 300,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Provider.of<HomeScreenProvider>(context,
                                  listen: false)
                                  .selectedTitle = "${snapshot.data.response[0].product[index].productName}";

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
                              price: snapshot
                                  .data.response[0].product[index].productPrice,
                              stock:
                              "${snapshot.data.response[0].product[index].productStockStatus}",
                              discount: "${snapshot.data.response[0].product[index].productDiscount}",
                            ),
                          );
                        },
                        itemCount: snapshot.data.response[0].product.length,
                      ),
                    ),
                  ),

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
