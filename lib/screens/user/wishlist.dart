import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/model/wishlist_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  /// api to get all the products in the wish list....
  Future<WishListModel> getWishList() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await WishListAPI.getWishListProducts(userId.toString());
    WishListModel _wishListModel = WishListModel.fromJson(response);
    return _wishListModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: getWishList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${snapshot.data.response.length} Products ',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 18,
                      color: const Color(0xff000000),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
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
                                "${snapshot.data.response[index].productSlug}";
                            Provider.of<VendorProvider>(context, listen: false)
                                    .selectedVendorName =
                                "${snapshot.data.response[index].vendorSlug}";
                            Provider.of<HomeScreenProvider>(context,
                                    listen: false)
                                .selectedString = "ProductInfo";
                          },
                          child: ProductBox(
                              icon: GestureDetector(
                                  onTap: () async {
                                    SharedPreferences _prefs =
                                        await SharedPreferences.getInstance();
                                    int userId = _prefs.getInt('userId');

                                    print(snapshot
                                        .data.response[index].productId);
                                    dynamic response = await WishListAPI
                                        .removeProductFromWishList(
                                            userId.toString(),
                                            snapshot.data.response[index]
                                                .productId);
                                    setState(() {});
                                  },
                                  child: SvgPicture.asset(
                                      "assets/icons/trash.svg")),
                              expanded: true,
                              height: height,
                              width: width,
                              stock:
                                  "${snapshot.data.response[index].productStockStatus}",
                              title:
                                  "${snapshot.data.response[index].productName}",
                              image:
                                  "${snapshot.data.response[index].productImg}",
                              description:
                                  "${snapshot.data.response[index].vendorCompanyName}",
                              price: snapshot
                                  .data.response[index].productSalePrice),
                        );
                      },
                      itemCount: snapshot.data.response.length,
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
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
        });
  }
}
