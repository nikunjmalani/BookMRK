import 'package:bookmrk/api/search_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/search_product_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Search2 extends StatefulWidget {
  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<Search2> {
  ColorPalette colorPalette = ColorPalette();

  /// TextField Controller
  TextEditingController _searchProductController = TextEditingController();

  /// search products....
  Future searchProducts(String productName) async {
    if (productName.length < 1) {
      productName = "a";
    }


    int userId =  prefs.read<int>('userId');
    dynamic response =
        await SearchAPI.searchProductHomePage(productName, userId.toString());
    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchProductModel _searchProductModel =
          SearchProductModel.fromJson(response);
      return _searchProductModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (_, _homeScreenProvider, child) => Column(
        children: [
          SearchBar(
              title: "Search Products",
              width: width,
              controller: _searchProductController,
              onChanged: (value) {
                _homeScreenProvider.findHomeScreenProduct = value;
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 75.0),
              child: FutureBuilder(
                  future:
                      searchProducts(_homeScreenProvider.findHomeScreenProduct),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.response.length != 0) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 300,
                                  childAspectRatio: 0.75,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return Stack(
                              fit: false == true
                                  ? StackFit.expand
                                  : StackFit.loose,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _homeScreenProvider.selectedTitle = "${snapshot.data.response[index].productName}";
                                    Provider.of<VendorProvider>(context,
                                                listen: false)
                                            .selectedVendorName =
                                        "${snapshot.data.response[index].vendorSlug}";

                                    _homeScreenProvider.selectedProductSlug =
                                        "${snapshot.data.response[index].productSlug}";
                                    _homeScreenProvider.selectedString =
                                        "ProductInfo";
                                  },
                                  child: Container(
                                    height: height / 3,
                                    width: width / 2,
                                    margin: EdgeInsets.only(bottom: 10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xffcfcfcf),
                                      ),
                                    ),
                                    child: ProductBox(
                                        expanded: true,
                                        height: height,
                                        width: width,
                                        title:
                                        "${snapshot.data.response[index].productName}",
                                        image:
                                        "${snapshot.data.response[index].productImg}",
                                        description:
                                        "${snapshot.data.response[index].vendorCompanyName}",
                                        price: snapshot
                                            .data.response[index].productSalePrice,
                                        stock:
                                        "${snapshot.data.response[index].productStockStatus}",
                                        discount: "${snapshot.data.response[index].productDiscount}"
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () async {

                                      int userId =  prefs.read<int>('userId');
                                      dynamic response = await WishListAPI
                                          .addProductInWishList(
                                              userId.toString(),
                                              snapshot.data.response[index]
                                                  .productId);
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      snapshot.data.response[index]
                                                  .productInUserWishlist ==
                                              "1"
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: snapshot.data.response[index]
                                                  .productInUserWishlist ==
                                              "1"
                                          ? Colors.red
                                          : colorPalette.navyBlue,
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          itemCount: snapshot.data.response.length,
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/search1.svg',
                                height: 100.0,
                              ),
                              SizedBox(height:30),
                              Text('Search entire store here...'),
                            ],
                          ),
                        );
                      }
                    } else {
                      return Container(
                        color: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(colorPalette.navyBlue),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
