import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/model/category_product_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryInfo extends StatefulWidget {
  final int categoryId;

  const CategoryInfo(this.categoryId);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  Future getCategoryProductsDetails() async {
    dynamic categoryProductsDetails =
        await CategoryAPI.getCategoryProducts(widget.categoryId);
    CategoryProductsModel _categoryProductModelDetails =
        CategoryProductsModel.fromJson(categoryProductsDetails);
    return _categoryProductModelDetails;
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
            return Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl:
                          '${snapshot.data.response[0].category[0].categoryImg}',
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "${snapshot.data.response[0].category[0].categoryImg}"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      placeholder: (context, s) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/images/book.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      errorWidget: (context, s, d) => Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        height: height / 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/images/book.png"),
                            fit: BoxFit.fill,
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
                            '${snapshot.data.response[0].category[0].allProductsCount} Products',
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
                Container(
                  height: height / 15,
                  child: snapshot.data.response[0].subCategory.length > 0
                      ? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Text(
                                '${snapshot.data.response[0].subCategory[index].categoryName}',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  color: index == 0
                                      ? colorPalette.navyBlue
                                      : Color(0xff919191),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            );
                          },
                          itemCount:
                              snapshot.data.response[0].subCategory.length,
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            'No Subcategory',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 14,
                                color: colorPalette.navyBlue),
                            textAlign: TextAlign.left,
                          ),
                        ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
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
                                    .selectedProductSlug =
                                "${snapshot.data.response[0].product[index].productSlug}";
                            Provider.of<VendorProvider>(context, listen: false)
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
                          ),
                        );
                      },
                      itemCount: snapshot.data.response[0].product.length,
                    ),
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
  }
}
