import 'package:bookmrk/api/search_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/search_product_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ColorPalette colorPalette = ColorPalette();

  /// TextField Controller
  TextEditingController _searchProductController = TextEditingController();

  /// search products....
  Future searchProducts(String productName) async {
    if (productName.length < 1) {
      productName = "a";
    }

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xffcfcfcf),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 30, bottom: 25.0),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                "${snapshot.data.response[index].productImg}",
                                            height: height / 8,
                                            fit: BoxFit.fill,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                            Colors.red
                                                                .withOpacity(
                                                                    0.5),
                                                            BlendMode
                                                                .colorBurn)),
                                              ),
                                            ),
                                            placeholder: (context, url) => Center(
                                                child: Image.asset(
                                                    'assets/images/Sharpner.png')),
                                            errorWidget:
                                                (context, url, error) => Center(
                                                    child: Image.asset(
                                                        'assets/images/Sharpner.png')),
                                          ),
                                        ),
                                        Container(
                                          height: 20.0,
                                          child: Text(
                                            "${snapshot.data.response[index].productName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              color: const Color(0xff000000),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          height: 16.0,
                                          child: Text(
                                            "${snapshot.data.response[index].vendorCompanyName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 14,
                                              color: const Color(0xff777777),
                                              fontWeight: FontWeight.w300,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 5),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 5,
                                            left: 5,
                                            right: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height: 20,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                  color:
                                                      colorPalette.pinkOrange,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: Text(
                                                  '${snapshot.data.response[index].productStockStatus} Stock',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 13,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                              Text(
                                                '₹ ${snapshot.data.response[index].productSalePrice}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff515c6f),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    onPressed: () async {
                                      SharedPreferences _prefs =
                                          await SharedPreferences.getInstance();
                                      int userId = _prefs.getInt('userId');
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
                          child: Text('Please write Correct name'),
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
