import 'package:bookmrk/api/product_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/model/product_details_model.dart';
import 'package:bookmrk/model/product_details_no_variation_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductInfo extends StatefulWidget {
  final String selectedProductSlug;

  const ProductInfo({this.selectedProductSlug});

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  PageController pageController = PageController(initialPage: 1);
  ColorPalette colorPalette = ColorPalette();
  int currentPage = 1;

  /// get the product details...
  Future getProductDetails() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await ProductAPI.getProductDetails(
        widget.selectedProductSlug, userId.toString());
    print(widget.selectedProductSlug);
    print(response);

    if (response['response'][0]['variation'] == "NO") {
      ProductDetailsNoVariationModel _productDetailsNoVariationModel =
          ProductDetailsNoVariationModel.fromJson(response);
      return _productDetailsNoVariationModel;
    } else {
      ProductDetailsModel _productDetailsModel =
          ProductDetailsModel.fromJson(response);
      return _productDetailsModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getProductDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        _productCarasoul(context,
                            isInwishlist: snapshot.data.response[0]
                                        .productInUserWishlist ==
                                    "1"
                                ? true
                                : false,
                            productId: snapshot.data.response[0].productId,
                            height: height,
                            pageController: pageController,
                            currentPage: currentPage,
                            images: snapshot.data.response[0].productImgs,
                            stock:
                                "${snapshot.data.response[0].productStockStatus}",
                            onChange: (value) {
                          setState(() {
                            currentPage = value;
                          });
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        BlueHeader("${snapshot.data.response[0].productName}"),
                        descrip(
                            "${snapshot.data.response[0].vendorCompanyName}"),
                        Text(
                          'Published By : Alpha bate Publication ',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 14,
                            color: const Color(0xffa4a4a4),
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '₹ ${snapshot.data.response[0].productPrice}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              ' Save ${snapshot.data.response[0].productDiscount}',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 17,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w200,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Text(
                          '₹ ${snapshot.data.response[0].productSalePrice}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 17,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        title("Specifications"),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${snapshot.data.response[0].productSpecification == "" ? "No Specifications" : snapshot.data.response[0].productSpecification}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        title("Description"),
                        Container(
                          padding: EdgeInsets.only(
                              left: 15.0, top: 10.0, bottom: 10.0, right: 10.0),
                          alignment: Alignment.centerLeft,
                          child: descrip(
                              "${snapshot.data.response[0].productDescription}"),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            NavyBlueButton(
                                onClick: () {},
                                context: context,
                                title: "ADD TO CART"),
                            NavyBlueButton(
                                onClick: () {},
                                context: context,
                                title: "BUY NOW")
                          ],
                        ),
                        SizedBox(
                          height: 110,
                        ),
                      ],
                    ),
                  ),
                )
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

Widget _productCarasoul(BuildContext context,
    {height,
    pageController,
    onChange,
    currentPage,
    bool isInwishlist,
    String productId,
    String stock = "In",
    List<dynamic> images}) {
  ColorPalette colorPalette = ColorPalette();

  return Stack(
    children: [
      Column(
        children: [
          Container(
            height: height / 2.5,
            child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: '${images[index].productImg}',
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      height: height / 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: NetworkImage("${images[index].productImg}"),
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
                  );
                },
                onPageChanged: onChange),
          ),
          Indicators(currentPage: currentPage, pages: images.length),
        ],
      ),
      Container(
        alignment: Alignment.centerRight,
        child: Column(
          children: [
            Consumer<HomeScreenProvider>(
              builder: (_, _homeScreenProvider, child) => IconButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  int userId = _prefs.getInt('userId');
                  dynamic response = await WishListAPI.addProductInWishList(
                      userId.toString(), productId);
                },
                icon: Icon(
                  isInwishlist ? Icons.favorite : Icons.favorite_border,
                  color: isInwishlist ? Colors.red : colorPalette.navyBlue,
                  size: 35,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.share,
                color: colorPalette.navyBlue,
                size: 35,
              ),
            ),
            SizedBox(
              height: height / 3.6,
            ),
            Container(
              margin: EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              height: 25,
              width: 75,
              decoration: BoxDecoration(
                color: colorPalette.pinkOrange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                '$stock Stock',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  color: colorPalette.navyBlue,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      )
    ],
  );
}
