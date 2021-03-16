import 'dart:convert';

import 'package:bookmrk/api/cart_api.dart';
import 'package:bookmrk/api/product_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/product_details_model.dart';
import 'package:bookmrk/model/product_details_no_variation_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/indicators.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

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

  /// variable to check that page loads for first time or not....
  bool _isPageLoadsFirstTime = true;

  /// TextFields for student name and student roll number...
  TextEditingController _studentNameController = TextEditingController();
  TextEditingController _studentRollNumberController = TextEditingController();
  TextEditingController _productQuantityController =
      TextEditingController(text: "1");

  /// form key...
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// get the product details...
  Future getProductDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await ProductAPI.getProductDetails(
        widget.selectedProductSlug, userId.toString());

    print('response=>>>$response');

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
                if (_isPageLoadsFirstTime) {
                  if (snapshot.data.response[0].variation == "YES") {
                    if (int.parse(snapshot.data.response[0].howManyVariation
                            .toString()) >
                        0) {
                      /// selected variation image..
                      _productOrderProvider.setVariation1Img(
                          "${snapshot.data.response[0].variationsDetails[0].varValue[0].varImg}");

                      /// selected variation name....
                      _productOrderProvider.setVariation1Name(
                          "${snapshot.data.response[0].variationsDetails[0].varValue[0].variationName}");

                      /// selected variation option name....
                      _productOrderProvider.setVariation1OptionName(
                          "${snapshot.data.response[0].variationsDetails[0].varValue[0].variationsOptionsName}");

                      /// selected variation id....
                      _productOrderProvider.setVariation1Id(
                          "${snapshot.data.response[0].variationsDetails[0].varValue[0].variationsDataId}");

                      if (int.parse(snapshot.data.response[0].howManyVariation
                              .toString()) >
                          1) {
                        /// selected variation2 option name...
                        _productOrderProvider.setVariation2Option(
                            "${snapshot.data.response[0].variationsDetails[1].varValue[0].variationsOptionsName}");

                        /// selected variation2 id...
                        _productOrderProvider.setVariation2Id(
                            "${snapshot.data.response[0].variationsDetails[1].varValue[0].variationsDataId}");

                        /// selected variation 2 name...
                        _productOrderProvider.setVariation2Name(
                            "${snapshot.data.response[0].variationsDetails[1].varValue[0].variationName}");

                        /// selected variation 2 image...
                        _productOrderProvider.setVariation2Img(
                            "${snapshot.data.response[0].variationsDetails[1].varValue[0].varImg}");
                      }

                      /// change the state of the page load...
                      _isPageLoadsFirstTime = false;
                    }
                  }
                }
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                _productCarasoul(context,
                                    "${snapshot.data.response[0].productName}",
                                    url: snapshot
                                        .data.response[0].productShareLink
                                        .toString(),
                                    isInwishlist: snapshot.data.response[0]
                                                .productInUserWishlist ==
                                            "1"
                                        ? true
                                        : false,
                                    productId:
                                        snapshot.data.response[0].productId,
                                    height: height,
                                    pageController: pageController,
                                    currentPage: currentPage,
                                    images:
                                        snapshot.data.response[0].productImgs,
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: BlueHeader(
                                      "${snapshot.data.response[0].productName}"),
                                ),
                                descrip(
                                    "${snapshot.data.response[0].vendorCompanyName}"),
                                if (snapshot.data.response[0].publisher.length >
                                    0) ...{
                                  if (snapshot.data.response[0].publisher[0]
                                              ['publisher_name'] !=
                                          "" &&
                                      snapshot.data.response[0].publisher[0]
                                              ['publisher_name'] !=
                                          null) ...{
                                    Text(
                                      'Published By : ${snapshot.data.response[0].publisher[0]['publisher_name']}',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 14,
                                        color: const Color(0xffa4a4a4),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  }
                                },
                                SizedBox(
                                  height: 15,
                                ),
                                snapshot.data.response[0].productDiscount == ""
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
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
                                  '₹ ${snapshot.data.response[0].productPrice}',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                    color: Colors.black,
                                    decoration:  snapshot.data.response[0].productDiscount == ""?TextDecoration.none:TextDecoration.lineThrough,
                                    decorationColor: Colors.black,
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
                                            : snapshot
                                                        .data
                                                        .response[0]
                                                        .variationsDetails
                                                        .length ==
                                                    2
                                                ? 200
                                                : 200.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 17.0),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 1,
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
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
                                            snapshot
                                                        .data
                                                        .response[0]
                                                        .variationsDetails
                                                        .length >
                                                    0
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: 55.0,
                                                        child: ListView.builder(
                                                          physics:
                                                              BouncingScrollPhysics(),
                                                          itemBuilder: (context,
                                                                  index) =>
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        10.0),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                /// selected variation image..
                                                                _productOrderProvider
                                                                        .selectedVariation1Img =
                                                                    "${snapshot.data.response[0].variationsDetails[0].varValue[index].varImg}";

                                                                /// selected variation name....
                                                                _productOrderProvider
                                                                        .selectedVariation1Name =
                                                                    "${snapshot.data.response[0].variationsDetails[0].varValue[index].variationName}";

                                                                /// selected variation option name....
                                                                _productOrderProvider
                                                                        .selectedVariation1OptionName =
                                                                    "${snapshot.data.response[0].variationsDetails[0].varValue[index].variationsOptionsName}";

                                                                /// selected variation id....
                                                                _productOrderProvider
                                                                        .selectedVariations1Id =
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
                                                                              .selectedVariations1Id ==
                                                                          '${snapshot.data.response[0].variationsDetails[0].varValue[index].variationsDataId}'
                                                                      ? colorPalette
                                                                          .navyBlue
                                                                      : colorPalette
                                                                          .orange,
                                                                ),
                                                                alignment:
                                                                    Alignment
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
                                                              .variationsDetails[
                                                                  0]
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
                                            snapshot
                                                        .data
                                                        .response[0]
                                                        .variationsDetails
                                                        .length >
                                                    1
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey,
                                                            width: 1.5,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        height: 55.0,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    20.0),
                                                        alignment:
                                                            Alignment.center,
                                                        child: DropdownButton(
                                                          hint: Text(
                                                              '${snapshot.data.response[0].variationsDetails[1].variationsDisplay}'),
                                                          isExpanded: true,
                                                          onChanged: (value) {
                                                            /// selected variation2 index....
                                                            _productOrderProvider
                                                                    .selectedVariation2Index =
                                                                value;

                                                            /// selected variation2 option name...
                                                            _productOrderProvider
                                                                    .selectedVariation2Option =
                                                                "${snapshot.data.response[0].variationsDetails[1].varValue[value].variationsOptionsName}";

                                                            /// selected variation2 id...
                                                            _productOrderProvider
                                                                    .selectedVariation2Id =
                                                                "${snapshot.data.response[0].variationsDetails[1].varValue[value].variationsDataId}";

                                                            /// selected variation 2 name...
                                                            _productOrderProvider
                                                                    .selectedVariation2Name =
                                                                "${snapshot.data.response[0].variationsDetails[1].varValue[value].variationName}";

                                                            /// selected variation 2 image...
                                                            _productOrderProvider
                                                                    .selectedVariation2Img =
                                                                "${snapshot.data.response[0].variationsDetails[1].varValue[value].varImg}";
                                                          },
                                                          value: _productOrderProvider
                                                                  .selectedVariation2Index ??
                                                              0,
                                                          underline:
                                                              Container(),
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
                                                              value: index,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
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
                                                  style: TextStyle(
                                                      color: Colors.grey),
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
                                                  activeColor:
                                                      Colors.transparent,
                                                  title: Container(
                                                      child: Text(
                                                          '${snapshot.data.response[0].additionalSetDetails[index].optionName}',
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 17.0))),
                                                );
                                              }))
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(height: 20.0),
                                SizedBox(height: 10.0),
                                Container(
                                  height: 70.0,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 5),
                                        child: TextFormField(
                                          controller:
                                              _productQuantityController,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: BorderSide(
                                                  color: colorPalette.navyBlue,
                                                  width: 1.0),
                                            ),
                                            labelText: "Product Quantity",
                                            labelStyle: TextStyle(
                                                color: colorPalette.navyBlue),
                                          ),
                                          keyboardType: TextInputType.number,
                                          validator: (value) {
                                            if (value == null) {
                                              return "Amount must contains only digits !";
                                            }
                                            if (!(double.tryParse(value) !=
                                                null)) {
                                              return "Amount must contains only digits !";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      "${snapshot.data.response[0].additionalSet}" ==
                                              "NO"
                                          ? Container()
                                          : Container(
                                              color: Colors.transparent,
                                            ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Builder(
                                      builder: (context) => NavyBlueButton(
                                          onClick: () async {
                                            _productOrderProvider
                                                .isAddToCartInProgress = true;

                                            /// check if quantity is entered or not...
                                            if (_productQuantityController
                                                        .text !=
                                                    "" &&
                                                _productQuantityController
                                                        .text !=
                                                    null) {
                                              dynamic response;
                                              dynamic variationInfo;
                                              String pvsmId;

                                              /// set userId ....
                                              int userId =
                                                  prefs.read<int>('userId');

                                              /// set productId ....
                                              String productId = snapshot
                                                  .data.response[0].productId;

                                              if (snapshot.data.response[0]
                                                      .variation ==
                                                  "YES") {
                                                /// structure for two variations ....
                                                List twoVariationsStructure = [
                                                  {
                                                    "variations_data_id":
                                                        "${_productOrderProvider.selectedVariations1Id}",
                                                    "variations_options_name":
                                                        "${_productOrderProvider.selectedVariation1OptionName}",
                                                    "variation_name":
                                                        "${_productOrderProvider.selectedVariation1Name}",
                                                    "var_img":
                                                        "${_productOrderProvider.selectedVariation1Img}",
                                                  },
                                                  {
                                                    "variations_data_id":
                                                        "${_productOrderProvider.selectedVariation2Id}",
                                                    "variations_options_name":
                                                        "${_productOrderProvider.selectedVariation2Option}",
                                                    "variation_name":
                                                        "${_productOrderProvider.selectedVariation2Name}",
                                                    "var_img":
                                                        "${_productOrderProvider.selectedVariation2Img}",
                                                  }
                                                ];

                                                /// Structure for single variation ....
                                                List oneVariationStructure = [
                                                  {
                                                    "variations_data_id":
                                                        _productOrderProvider
                                                            .selectedVariations1Id,
                                                    "variations_options_name":
                                                        "${_productOrderProvider.selectedVariation1OptionName}",
                                                    "variation_name":
                                                        "${_productOrderProvider.selectedVariation1Name}",
                                                    "var_img":
                                                        "${_productOrderProvider.selectedVariation1Img}",
                                                  }
                                                ];

                                                // code block for get pvsm_id in response .............................
                                                /// check when the variations are multiple or single ....

                                                if (snapshot
                                                        .data
                                                        .response[0]
                                                        .variationsDetails[0]
                                                        .varValue
                                                        .length >
                                                    1) {
                                                  /// code for two variations...
                                                  response = await ProductAPI
                                                      .getVariationDetails(
                                                    userId.toString(),
                                                    productId,
                                                    twoVariationsStructure,
                                                  );
                                                  variationInfo =
                                                      twoVariationsStructure;

                                                  pvsmId = response['response']
                                                          [0]['pvsm_id']
                                                      .toString();

                                                  /// code for two variations end...
                                                } else {
                                                  /// code for single variation...
                                                  response = await ProductAPI
                                                      .getVariationDetails(
                                                          userId.toString(),
                                                          productId,
                                                          jsonEncode(
                                                              oneVariationStructure));
                                                  pvsmId = response['response']
                                                          [0]['pvsm_id']
                                                      .toString();
                                                  variationInfo =
                                                      oneVariationStructure;

                                                  /// code for single variation end...
                                                }
                                                // end code block for get pvsm_id in response .............................

                                              } else {
                                                pvsmId = null;
                                                variationInfo = null;
                                                response = {"status": 200};
                                              }

                                              if (response['status'] == 200) {
                                                /// check if the product type is set or not....
                                                if (snapshot.data.response[0]
                                                        .productType ==
                                                    "Set") {
                                                  _productOrderProvider
                                                          .isAddToCartInProgress =
                                                      false;

                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return _addToCartDialog(
                                                          context,
                                                          studentNameController:
                                                              _studentNameController,
                                                          studentRollNumberController:
                                                              _studentRollNumberController,
                                                          productQuantityController:
                                                              _productQuantityController,
                                                          userId:
                                                              userId.toString(),
                                                          productId: productId
                                                              .toString(),
                                                          pvsmId: pvsmId,
                                                          variationInfo:
                                                              variationInfo,
                                                        );
                                                      });
                                                } else {
                                                  dynamic response2 =
                                                      await CartAPI
                                                          .addProductToCart(
                                                    userId.toString(),
                                                    productId,
                                                    int.parse(
                                                        _productQuantityController
                                                            .text),
                                                    null,
                                                    null,
                                                    pvsmId,
                                                    variationInfo,
                                                  );

                                                  /// check if the product added to cart or not....
                                                  if (response2['status'] ==
                                                      200) {
                                                    _productOrderProvider
                                                            .isAddToCartInProgress =
                                                        false;
                                                    Provider.of<HomeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .totalNumberOfOrdersInCart += 1;
                                                    Scaffold.of(context)
                                                        .showSnackBar(getSnackBar(
                                                            'Product added To cart !'));
                                                  } else {
                                                    _productOrderProvider
                                                            .isAddToCartInProgress =
                                                        false;
                                                    Scaffold.of(context)
                                                        .showSnackBar(getSnackBar(
                                                            '${response2['message']}'));
                                                  }
                                                }
                                              } else {
                                                _productOrderProvider
                                                        .isAddToCartInProgress =
                                                    false;
                                                Scaffold.of(context)
                                                    .showSnackBar(getSnackBar(
                                                        "${response['message']}"));
                                              }
                                            } else {
                                              _productOrderProvider
                                                      .isAddToCartInProgress =
                                                  false;

                                              Scaffold.of(context).showSnackBar(
                                                  getSnackBar(
                                                      'Please enter quantity !'));
                                            }
                                          },
                                          context: context,
                                          title: "ADD TO CART"),
                                    ),
                                    NavyBlueButton(
                                        onClick: () async {
                                          _productOrderProvider
                                              .isAddToCartInProgress = true;

                                          /// check if quantity is entered or not...
                                          if (_productQuantityController.text !=
                                                  "" &&
                                              _productQuantityController.text !=
                                                  null) {
                                            dynamic response;
                                            dynamic variationInfo;
                                            String pvsmId;

                                            /// set userId ....
                                            int userId =
                                                prefs.read<int>('userId');

                                            /// set productId ....
                                            String productId = snapshot
                                                .data.response[0].productId;

                                            if (snapshot.data.response[0]
                                                    .variation ==
                                                "YES") {
                                              /// structure for two variations ....
                                              List twoVariationsStructure = [
                                                {
                                                  "variations_data_id":
                                                      "${_productOrderProvider.selectedVariations1Id}",
                                                  "variations_options_name":
                                                      "${_productOrderProvider.selectedVariation1OptionName}",
                                                  "variation_name":
                                                      "${_productOrderProvider.selectedVariation1Name}",
                                                  "var_img":
                                                      "${_productOrderProvider.selectedVariation1Img}",
                                                },
                                                {
                                                  "variations_data_id":
                                                      "${_productOrderProvider.selectedVariation2Id}",
                                                  "variations_options_name":
                                                      "${_productOrderProvider.selectedVariation2Option}",
                                                  "variation_name":
                                                      "${_productOrderProvider.selectedVariation2Name}",
                                                  "var_img":
                                                      "${_productOrderProvider.selectedVariation2Img}",
                                                }
                                              ];

                                              /// Structure for single variation ....
                                              List oneVariationStructure = [
                                                {
                                                  "variations_data_id":
                                                      _productOrderProvider
                                                          .selectedVariations1Id,
                                                  "variations_options_name":
                                                      "${_productOrderProvider.selectedVariation1OptionName}",
                                                  "variation_name":
                                                      "${_productOrderProvider.selectedVariation1Name}",
                                                  "var_img":
                                                      "${_productOrderProvider.selectedVariation1Img}",
                                                }
                                              ];

                                              // code block for get pvsm_id in response .............................
                                              /// check when the variations are multiple or single ....

                                              if (snapshot
                                                      .data
                                                      .response[0]
                                                      .variationsDetails[0]
                                                      .varValue
                                                      .length >
                                                  1) {
                                                /// code for two variations...
                                                response = await ProductAPI
                                                    .getVariationDetails(
                                                  userId.toString(),
                                                  productId,
                                                  twoVariationsStructure,
                                                );
                                                variationInfo =
                                                    twoVariationsStructure;

                                                pvsmId = response['response'][0]
                                                        ['pvsm_id']
                                                    .toString();

                                                /// code for two variations end...
                                              } else {
                                                /// code for single variation...
                                                response = await ProductAPI
                                                    .getVariationDetails(
                                                        userId.toString(),
                                                        productId,
                                                        jsonEncode(
                                                            oneVariationStructure));
                                                pvsmId = response['response'][0]
                                                        ['pvsm_id']
                                                    .toString();
                                                variationInfo =
                                                    oneVariationStructure;

                                                /// code for single variation end...
                                              }
                                              // end code block for get pvsm_id in response .............................

                                            } else {
                                              pvsmId = null;
                                              variationInfo = null;
                                              response = {"status": 200};
                                            }

                                            if (response['status'] == 200) {
                                              /// check if the product type is set or not....
                                              if (snapshot.data.response[0]
                                                      .productType ==
                                                  "Set") {
                                                _productOrderProvider
                                                        .isAddToCartInProgress =
                                                    false;

                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return _addToCartDialog(
                                                        context,
                                                        studentNameController:
                                                            _studentNameController,
                                                        studentRollNumberController:
                                                            _studentRollNumberController,
                                                        productQuantityController:
                                                            _productQuantityController,
                                                        userId:
                                                            userId.toString(),
                                                        productId: productId
                                                            .toString(),
                                                        pvsmId: pvsmId,
                                                        variationInfo:
                                                            variationInfo,
                                                      );
                                                    });
                                              } else {
                                                dynamic response2 =
                                                    await CartAPI
                                                        .addProductToCart(
                                                  userId.toString(),
                                                  productId,
                                                  int.parse(
                                                      _productQuantityController
                                                          .text),
                                                  null,
                                                  null,
                                                  pvsmId,
                                                  variationInfo,
                                                );

                                                /// check if the product added to cart or not....
                                                if (response2['status'] ==
                                                    200) {
                                                  _productOrderProvider
                                                          .isAddToCartInProgress =
                                                      false;
                                                  Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .totalNumberOfOrdersInCart += 1;
                                                  // Scaffold.of(context)
                                                  //     .showSnackBar(getSnackBar(
                                                  //     'Product added To cart !'));
                                                  Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedString = "Cart";
                                                  Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedBottomIndex = 4;
                                                  Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .pageController
                                                      .jumpToPage(4);
                                                } else {
                                                  _productOrderProvider
                                                          .isAddToCartInProgress =
                                                      false;
                                                  Scaffold.of(context)
                                                      .showSnackBar(getSnackBar(
                                                          '${response2['message']}'));
                                                }
                                              }
                                            } else {
                                              _productOrderProvider
                                                      .isAddToCartInProgress =
                                                  false;
                                              Scaffold.of(context).showSnackBar(
                                                  getSnackBar(
                                                      "${response['message']}"));
                                            }
                                          } else {
                                            _productOrderProvider
                                                .isAddToCartInProgress = false;

                                            Scaffold.of(context).showSnackBar(
                                                getSnackBar(
                                                    'Please enter quantity !'));
                                          }
                                        },
                                        context: context,
                                        title: "BUY NOW")
                                  ],
                                ),
                                SizedBox(
                                  height: 260,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Visibility(
                      visible: _productOrderProvider.isAddToCartInProgress,
                      child: Container(
                        color: Colors.transparent,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation(colorPalette.navyBlue),
                          ),
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
            }));
  }

  checkOut() async {
    MethodChannel _channel = MethodChannel('easebuzz');
    String txnid = "TRX123"; //This txnid should be unique every time.
    String amount = "2.0";
    String productinfo = "test info";
    String firstname = "test user";
    String email = "testing@gamil.com";
    String phone = "1234567890";
    String s_url = "";
    String f_url = "";
    String key = "XXXXXXXXXXX";
    String udf1 = "";
    String udf2 = "";
    String udf3 = "";
    String udf4 = "";
    String udf5 = "";
    String address1 = "test address one";
    String address2 = "test address two";
    String city = "";
    String state = "";
    String country = "";
    String zipcode = "";
    String hash =
        "${sha256.convert(utf8.encode("key|txnid|amount|productinfo|firstname|email_id|udf1|udf2|udf3|udf4|udf5||||||salt"))}";
    String pay_mode = "production";
    String unique_id = "11345";
    Object parameters = {
      "txnid": txnid,
      "amount": amount,
      "productinfo": productinfo,
      "firstname": firstname,
      "email": email,
      "phone": phone,
      "s_url": s_url,
      "f_url": f_url,
      "key": key,
      "udf1": udf1,
      "udf2": udf2,
      "udf3": udf3,
      "udf4": udf4,
      "udf5": udf5,
      "address1": address1,
      "address2": address2,
      "city": city,
      "state": state,
      "country": country,
      "zipcode": zipcode,
      "hash": hash,
      "pay_mode": pay_mode,
      "unique_id": unique_id
    };

    final payment_response =
        await _channel.invokeMethod("payWithEasebuzz", parameters);
  }
}

Widget _addToCartDialog(
  BuildContext context, {
  TextEditingController studentNameController,
  TextEditingController studentRollNumberController,
  TextEditingController productQuantityController,
  String userId,
  String productId,
  String pvsmId,
  dynamic variationInfo,
}) {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    child: Container(
      height: 290.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 20.0,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: studentNameController,
              validator: (value) {
                if (value.length <= 0) {
                  return "Please enter student name";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: colorPalette.navyBlue, width: 1.0),
                ),
                labelText: "Student's Name",
                labelStyle: TextStyle(color: colorPalette.navyBlue),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: studentRollNumberController,
              validator: (value) {
                if (value.length <= 0) {
                  return "Enter student roll number";
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      BorderSide(color: colorPalette.navyBlue, width: 1.0),
                ),
                labelText: "Mobile Number",
                labelStyle: TextStyle(color: colorPalette.navyBlue),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style:
                        TextStyle(color: colorPalette.navyBlue, fontSize: 18.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Consumer<ProductOrderProvider>(
                    builder: (_, _productOrderProvider, child) => RaisedButton(
                          onPressed: () async {
                            _productOrderProvider.isAddToCartInProgress = true;
                            if (formKey.currentState.validate()) {
                              int qty = int.parse(
                                  '${productQuantityController.text}');
                              Navigator.pop(context);

                              dynamic response = await CartAPI.addProductToCart(
                                userId.toString(),
                                productId,
                                qty,
                                studentNameController.text,
                                studentRollNumberController.text,
                                pvsmId,
                                variationInfo,
                              );

                              /// check if the product added to cart or not....
                              if (response['status'] == 200) {
                                _productOrderProvider.isAddToCartInProgress =
                                    false;
                              } else {
                                _productOrderProvider.isAddToCartInProgress =
                                    false;
                              }
                            }
                          },
                          child: Text(
                            'Continue',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          color: colorPalette.navyBlue,
                        ))
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget _productCarasoul(BuildContext context, String pName,
    {height,
    String url,
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
                          image: AssetImage("assets/images/preload.png"),
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
                          image: AssetImage("assets/images/preload.png"),
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
                  int userId = prefs.read<int>('userId');
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
              onPressed: () {
                Share.share('Product Name : $pName\n$url',
                    subject: 'Share Product');
              },
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
