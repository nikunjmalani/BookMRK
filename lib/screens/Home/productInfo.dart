import 'package:bookmrk/api/product_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/model/product_details_model.dart';
import 'package:bookmrk/model/product_details_no_variation_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

    return Consumer<ProductOrderProvider>(
        builder: (_, _productOrderProvider, child) => FutureBuilder(
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
                            BlueHeader(
                                "${snapshot.data.response[0].productName}"),
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
                                  left: 15.0,
                                  top: 10.0,
                                  bottom: 10.0,
                                  right: 10.0),
                              alignment: Alignment.centerLeft,
                              child: Html(
                                data:
                                    "${snapshot.data.response[0].productDescription}",
                                backgroundColor: Colors.grey[200],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            snapshot.data.response[0].variation == "YES"
                                ? Container(
                                    height: snapshot.data.response[0]
                                                .variationsDetails.length ==
                                            1
                                        ? 120.0
                                        : snapshot.data.response[0]
                                                    .variationsDetails.length ==
                                                2
                                            ? 200
                                            : 200.0,
                                    width: MediaQuery.of(context).size.width,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 17.0),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 1,
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              blurRadius: 10)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        snapshot.data.response[0]
                                                    .variationsDetails.length >
                                                0
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data.response[0].variationsDetails[0].variationsDisplay}',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    height: 55.0,
                                                    child: ListView.builder(
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) =>
                                                              Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    10.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            _productOrderProvider
                                                                    .selectedVariation1Name =
                                                                '${snapshot.data.response[0].variationsDetails[0].varValue[index].variationsDataId}';
                                                          },
                                                          child: Container(
                                                            width: 100.0,
                                                            height: 50.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                              color: _productOrderProvider
                                                                          .selectedVariation1Name ==
                                                                      '${snapshot.data.response[0].variationsDetails[0].varValue[index].variationsDataId}'
                                                                  ? colorPalette
                                                                      .navyBlue
                                                                  : colorPalette
                                                                      .orange,
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              '${snapshot.data.response[0].variationsDetails[0].varValue[index].variationsOptionsName}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      18.0),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      itemCount: snapshot
                                                          .data
                                                          .response[0]
                                                          .variationsDetails[0]
                                                          .varValue
                                                          .length,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                ],
                                              )
                                            : SizedBox(),
                                        snapshot.data.response[0]
                                                    .variationsDetails.length >
                                                1
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${snapshot.data.response[0].variationsDetails[1].variationsDisplay}',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1.5,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    height: 55.0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.0),
                                                    alignment: Alignment.center,
                                                    child: DropdownButton(
                                                      hint: Text(
                                                          '${snapshot.data.response[0].variationsDetails[1].variationsDisplay}'),
                                                      isExpanded: true,
                                                      onChanged: (value) {
                                                        _productOrderProvider
                                                                .selectedVariation2Option =
                                                            value;
                                                      },
                                                      value: _productOrderProvider
                                                              .selectedVariation2Option ??
                                                          snapshot
                                                              .data
                                                              .response[0]
                                                              .variationsDetails[
                                                                  1]
                                                              .varValue[0]
                                                              .variationsDataId,
                                                      underline: Container(),
                                                      items: List.generate(
                                                        snapshot
                                                            .data
                                                            .response[0]
                                                            .variationsDetails[
                                                                1]
                                                            .varValue
                                                            .length,
                                                        (index) =>
                                                            DropdownMenuItem(
                                                          child: Text(
                                                              '${snapshot.data.response[0].variationsDetails[1].varValue[index].variationsOptionsName}'),
                                                          value: snapshot
                                                              .data
                                                              .response[0]
                                                              .variationsDetails[
                                                                  1]
                                                              .varValue[index]
                                                              .variationsDataId,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                            SizedBox(
                              height: 10,
                            ),
                            snapshot.data.response[0].additionalSet == "YES"
                                ? Container(
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              'additional set',
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                          ),
                                          SizedBox(height: 5.0),
                                          Column(
                                            children: List.generate(
                                                snapshot
                                                    .data
                                                    .response[0]
                                                    .additionalSetDetails
                                                    .length, (index) {
                                              return CheckboxListTile(
                                                value: snapshot
                                                            .data
                                                            .response[0]
                                                            .additionalSetDetails[
                                                                index]
                                                            .isMandatory ==
                                                        "1"
                                                    ? true
                                                    : false,
                                                onChanged: (value) {},
                                                checkColor:
                                                    colorPalette.navyBlue,
                                                activeColor: Colors.transparent,
                                                title: Container(
                                                  child: Text(
                                                    '${snapshot.data.response[0].additionalSetDetails[index].optionName}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17.0,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(height: 20.0),
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
            }));
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
