import 'dart:convert';

import 'package:bookmrk/api/cart_api.dart';
import 'package:bookmrk/api/product_api.dart';
import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/api/wishlist_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/cart_details_model.dart';
import 'package:bookmrk/model/no_data_cart_model.dart';
import 'package:bookmrk/model/user_address_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/map_provider.dart';
import 'package:bookmrk/provider/order_provider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ColorPalette colorPalette = ColorPalette();
  static MethodChannel _channel = MethodChannel('easebuzz');

  /// total item count ...
  // int totalItem = 0;

  /// get cart details of user...
  Future getCartDetails() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await CartAPI.getCartData(userId.toString());

    if (response['response'][0].length == 0) {
      NoDataCartModel _noDataCart = NoDataCartModel.fromJson(response);
      return _noDataCart;
    } else {
      CartDetailsModel _cartDetailModel = CartDetailsModel.fromJson(response);
      return _cartDetailModel;
    }
  }

  /// get selected address details...
  Future getSelectedAddressInCart() async {
    int userId = prefs.read<int>('userId');
    dynamic response = await UserAPI.getUserAddress(userId.toString());
    UserAddressModel _userAddress = UserAddressModel.fromJson(response);
    return _userAddress;
  }

  setDefault() {
    Provider.of<HomeScreenProvider>(context, listen: false)
        .selectAddressFirstTimeInit = false;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<ProductOrderProvider>(
        builder: (_, _productOrderProvider, child) => Stack(
              fit: StackFit.expand,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: FutureBuilder(
                          future: getSelectedAddressInCart(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.response.length != 0) {
                                int selectedAddressIndex = 0;
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .isAddressSelectedInCartInit = true;
                                for (int i = 0;
                                    i < snapshot.data.response.length;
                                    i++) {
                                  if (snapshot.data.response[i].isSelected ==
                                      "1") {
                                    selectedAddressIndex = i;
                                  }
                                }

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Deliver to ${snapshot.data.response[selectedAddressIndex].fname} ${snapshot.data.response[selectedAddressIndex].lname}',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 13,
                                            color: const Color(0xff000000),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Text(
                                            '${snapshot.data.response[selectedAddressIndex].address1},\n${snapshot.data.response[selectedAddressIndex].city}, ${snapshot.data.response[selectedAddressIndex].state}\n${snapshot.data.response[selectedAddressIndex].pincode} ',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 12,
                                              color: const Color(0xffa9a9aa),
                                              fontWeight: FontWeight.w300,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: width / 4.5,
                                      child: FlatButton(
                                        onPressed: () {
                                          Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedString = "ChangeAddress";
                                        },
                                        color: colorPalette.navyBlue,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Text(
                                          'CHANGE',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 12,
                                            color: const Color(0xffffffff),
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                Provider.of<OrderProvider>(context,
                                        listen: false)
                                    .isAddressSelectedInCartInit = false;
                                return Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedString = "UserAddAddress";
                                      Provider.of<MapProvider>(context,
                                              listen: false)
                                          .isLatLngSelected = false;
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedBottomIndex = 3;
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectAddressFirstTime = true;
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      color: colorPalette.navyBlue,
                                      width: width / 2,
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Add a new Address.',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Please wait while loading address !'),
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        colorPalette.navyBlue),
                                  ),
                                ],
                              );
                            }
                          }),
                    ),
                    Expanded(
                      child: FutureBuilder(
                          future: getCartDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.status != 200) {
                                return Container(
                                  margin: EdgeInsets.only(top: 50.0),
                                  child: Text(
                                    'Cart is empty !',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                );
                              } else {
                                // totalItem = 0;
                                return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    // if (index <
                                    //     snapshot.data.response[0].cart.length) {
                                    //   totalItem = totalItem +
                                    //       (int.parse(
                                    //           '${snapshot.data.response[0].cart[index].qty}'));
                                    // }

                                    return index <
                                            snapshot
                                                .data.response[0].cart.length
                                        ? Container(
                                            margin: EdgeInsets.all(10),
                                            height: width / 2.2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: colorPalette.grey,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5, top: 0),
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  '${snapshot.data.response[0].cart[index].productImg}',
                                                              height:
                                                                  width / 3.5,
                                                              width:
                                                                  width / 3.5,
                                                              errorWidget: (context,
                                                                      str,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                      'assets/images/preload.png'),
                                                              placeholder: (context,
                                                                      str) =>
                                                                  Image.asset(
                                                                      'assets/images/preload.png'),
                                                            ),
                                                          ),
                                                          snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .cart[
                                                                          index]
                                                                      .productStockStatus !=
                                                                  "IN"
                                                              ? Positioned(
                                                                  top: 40,
                                                                  left: 10,
                                                                  child:
                                                                      Container(
                                                                    height: 30,
                                                                    width: 90,
                                                                    color: Colors
                                                                        .white,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                      'OUT OF STOCK',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .red,
                                                                          fontSize:
                                                                              12.0,
                                                                          fontWeight:
                                                                              FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                )
                                                              : SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: width / 1.7,
                                                          child: Text(
                                                            '${snapshot.data.response[0].cart[index].productName}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 18,
                                                              color: const Color(
                                                                  0xff000000),
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: width / 1.7,
                                                          child: Text(
                                                            '${snapshot.data.response[0].cart[index].productName}',
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xffa9a9aa),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                Divider(
                                                  indent: 20,
                                                  thickness: 1,
                                                  endIndent: 20,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () async {
                                                          print('1');
                                                          _productOrderProvider
                                                                  .isProductRemovingFromCartInProgress =
                                                              true;

                                                          print('2');
                                                          int userId =
                                                              prefs.read<int>(
                                                                  'userId');
                                                          dynamic response =
                                                              await CartAPI.removeCart(
                                                                  userId
                                                                      .toString(),
                                                                  snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .cart[
                                                                          index]
                                                                      .cartId);
                                                          print('3');

                                                          _productOrderProvider
                                                                  .isProductRemovingFromCartInProgress =
                                                              false;
                                                          print('4');

                                                          Provider.of<HomeScreenProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .getCartCount();
                                                          setState(() {});
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/icons/delete.svg",
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      IconButton(
                                                        icon: Icon(Icons.add),
                                                        onPressed: () async {
                                                          dynamic userId = prefs
                                                              .read("userId");
                                                          String productId =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .productId
                                                                  .toString();
                                                          String studentName =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .studentName;
                                                          String studentRoll =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .studentRoll
                                                                  .toString();
                                                          String cartId =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .cartId
                                                                  .toString();
                                                          int qty = (int.parse(
                                                                  snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .cart[
                                                                          index]
                                                                      .qty
                                                                      .toString()) +
                                                              1);

                                                          dynamic response =
                                                              await CartAPI
                                                                  .updateQty(
                                                            userId.toString(),
                                                            productId,
                                                            qty.toString(),
                                                            studentName,
                                                            studentRoll,
                                                            cartId,
                                                          );

                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  getSnackBar(
                                                                      "${response['message']}"));

                                                          setState(() {});
                                                        },
                                                      ),
                                                      snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .productStockStatus ==
                                                              "IN"
                                                          ? Text(
                                                              '${snapshot.data.response[0].cart[index].qty} Qty',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 16,
                                                                color: const Color(
                                                                    0xff515c6f),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : SizedBox(),
                                                      IconButton(
                                                        icon:
                                                            Icon(Icons.remove),
                                                        onPressed: () async {
                                                          dynamic userId = prefs
                                                              .read("userId");
                                                          String productId =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .productId
                                                                  .toString();
                                                          String studentName =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .studentName;
                                                          String studentRoll =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .studentRoll
                                                                  .toString();
                                                          String cartId =
                                                              snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .cartId
                                                                  .toString();
                                                          int qty = (int.parse(
                                                                  snapshot
                                                                      .data
                                                                      .response[
                                                                          0]
                                                                      .cart[
                                                                          index]
                                                                      .qty
                                                                      .toString()) -
                                                              1);

                                                          dynamic response =
                                                              await CartAPI
                                                                  .updateQty(
                                                            userId.toString(),
                                                            productId,
                                                            qty.toString(),
                                                            studentName,
                                                            studentRoll,
                                                            cartId,
                                                          );

                                                          Scaffold.of(context)
                                                              .showSnackBar(
                                                                  getSnackBar(
                                                                      "${response['message']}"));

                                                          print(response);
                                                          setState(() {});
                                                        },
                                                      ),
                                                      // Text(
                                                      //   '₹ ${snapshot.data.response[0].cart[index].productSalePrice}',
                                                      //   style: TextStyle(
                                                      //     fontFamily: 'Roboto',
                                                      //     fontSize: 16,
                                                      //     color: const Color(
                                                      //         0xff515c6f),
                                                      //     fontWeight:
                                                      //         FontWeight.w700,
                                                      //   ),
                                                      //   textAlign:
                                                      //       TextAlign.left,
                                                      // ),
                                                      snapshot
                                                                  .data
                                                                  .response[0]
                                                                  .cart[index]
                                                                  .productStockStatus ==
                                                              "IN"
                                                          ? Text(
                                                              'Total : ₹ ${snapshot.data.response[0].cart[index].productFinalTotal} ',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontSize: 16,
                                                                color: const Color(
                                                                    0xff515c6f),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            )
                                                          : GestureDetector(
                                                              onTap: () async {
                                                                int userId =
                                                                    prefs.read<
                                                                            int>(
                                                                        'userId');
                                                                dynamic response = await WishListAPI.addProductInWishList(
                                                                    userId
                                                                        .toString(),
                                                                    snapshot
                                                                        .data
                                                                        .response[
                                                                            0]
                                                                        .cart[
                                                                            index]
                                                                        .productId);
                                                                print(response);
                                                                if (response[
                                                                        'status'] ==
                                                                    200) {
                                                                  Scaffold.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          getSnackBar(
                                                                              "${response['message']}"))
                                                                      .closed
                                                                      .then(
                                                                          (value) async {
                                                                    print('5');

                                                                    _productOrderProvider
                                                                            .isProductRemovingFromCartInProgress =
                                                                        true;
                                                                    print('6');

                                                                    int userId =
                                                                        prefs.read<int>(
                                                                            'userId');
                                                                    dynamic response = await CartAPI.removeCart(
                                                                        userId
                                                                            .toString(),
                                                                        snapshot
                                                                            .data
                                                                            .response[0]
                                                                            .cart[index]
                                                                            .cartId);
                                                                    print('7');

                                                                    _productOrderProvider
                                                                            .isProductRemovingFromCartInProgress =
                                                                        false;
                                                                    print('8');

                                                                    Provider.of<HomeScreenProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .getCartCount();
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                'Add To Wishlist',
                                                                style: TextStyle(
                                                                    color: colorPalette
                                                                        .navyBlue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800),
                                                              ),
                                                            ),
                                                    ],
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Column(
                                            children: [
                                              PriceDetail(
                                                width: width,
                                                height: height,
                                                // itemCount: totalItem,
                                                totalOfItem:
                                                    '${snapshot.data.response[0].cartInfo[0].finalPrice}',
                                                tax:
                                                    '${snapshot.data.response[0].cartInfo[0].finalTaxPrice}',
                                                deliverCharge:
                                                    '${snapshot.data.response[0].cartInfo[0].finalDeliveryPrice}',
                                                mainTotal:
                                                    '${snapshot.data.response[0].cartInfo[0].finalTotalPrice}',
                                              ),
                                              BlueLongButton(
                                                color: !Provider.of<
                                                                OrderProvider>(
                                                            context)
                                                        .isAddressSelectedInCart
                                                    ? Color(0xff999999)
                                                    : Color(0xff44349A),
                                                title: "PROCEED TO CHECKOUT",
                                                height: height,
                                                onTap: !Provider.of<
                                                                OrderProvider>(
                                                            context)
                                                        .isAddressSelectedInCart
                                                    ? () {}
                                                    : snapshot
                                                                .data
                                                                .response[0]
                                                                .cartInfo[0]
                                                                .hideCheckoutButton ==
                                                            "NO"
                                                        ? () async {
                                                            try {
                                                              _productOrderProvider
                                                                      .isProductRemovingFromCartInProgress =
                                                                  true;

                                                              int userId = prefs
                                                                  .read<int>(
                                                                      'userId');
                                                              dynamic response =
                                                                  await ProductAPI.prePaymentAPICall(
                                                                      userId
                                                                          .toString(),
                                                                      kAppVersion,
                                                                      'online',
                                                                      'online');

                                                              if (response[
                                                                      'status'] ==
                                                                  200) {
                                                                /// method channel call for payment......
                                                                String txnid =
                                                                    "${response['response'][0]['order_no']}"; //This txnid should be unique every time.
                                                                String amount =
                                                                    "${double.parse("${response['response'][0]['order_total_cost']}").roundToDouble()}";
//                                                                String amount =
//                                                                    "1.0";
                                                                String
                                                                    productinfo =
                                                                    "Books";
                                                                String
                                                                    firstname =
                                                                    "${response['response'][0]['user_name']}";
                                                                String email =
                                                                    "${response['response'][0]['user_email']}";
                                                                String phone =
                                                                    "${response['response'][0]['user_mobile']}";
                                                                String s_url =
                                                                    "https://www.bookmrk.in/";
                                                                String f_url =
                                                                    "https://www.bookmrk.in/";
                                                                String key =
                                                                    "$easeBuzzKey";
                                                                String udf1 =
                                                                    "";
                                                                String udf2 =
                                                                    "";
                                                                String udf3 =
                                                                    "";
                                                                String udf4 =
                                                                    "";
                                                                String udf5 =
                                                                    "";
                                                                String
                                                                    address1 =
                                                                    "${response['response'][0]['user_address1']}";
                                                                String
                                                                    address2 =
                                                                    "${response['response'][0]['user_address2']}";
                                                                String city =
                                                                    "${response['response'][0]['user_countries']}";
                                                                String state =
                                                                    "${response['response'][0]['user_state']}";
                                                                String country =
                                                                    "${response['response'][0]['user_city']}";
                                                                String zipcode =
                                                                    "${response['response'][0]['user_pincode']}";
                                                                String salt =
                                                                    "$easeBuzzSalt";
                                                                String hash =
                                                                    "${sha512.convert(utf8.encode("$key|$txnid|$amount|$productinfo|$firstname|$email|$udf1|$udf2|$udf3|$udf4|$udf5||||||$salt|$key"))}";
                                                                String
                                                                    pay_mode =
                                                                    "production";
                                                                String
                                                                    unique_id =
                                                                    "11345";

                                                                Object
                                                                    parameters =
                                                                    {
                                                                  "txnid":
                                                                      txnid,
                                                                  "amount":
                                                                      amount,
                                                                  "productinfo":
                                                                      productinfo,
                                                                  "firstname":
                                                                      firstname,
                                                                  "email":
                                                                      email,
                                                                  "phone":
                                                                      phone,
                                                                  "surl": s_url,
                                                                  "furl": f_url,
                                                                  "key": key,
                                                                  "udf1": udf1,
                                                                  "udf2": udf2,
                                                                  "udf3": udf3,
                                                                  "udf4": udf4,
                                                                  "udf5": udf5,
                                                                  "address1":
                                                                      address1,
                                                                  "address2":
                                                                      address2,
                                                                  "city": city,
                                                                  "state":
                                                                      state,
                                                                  "country":
                                                                      country,
                                                                  "zipcode":
                                                                      zipcode,
                                                                  "hash": hash,
                                                                  "isMobile":
                                                                      "1",
                                                                  "pay_mode":
                                                                      pay_mode,
                                                                  "unique_id":
                                                                      unique_id
                                                                };

                                                                final payment_response =
                                                                    await _channel.invokeMethod(
                                                                        "payWithEasebuzz",
                                                                        parameters);
                                                                print(
                                                                    payment_response);
                                                                if (payment_response[
                                                                        'result'] ==
                                                                    "payment_failed") {
                                                                  Scaffold.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          getSnackBar(
                                                                              'Transaction Failed !'));
                                                                  print('11');

                                                                  _productOrderProvider
                                                                          .isProductRemovingFromCartInProgress =
                                                                      false;
                                                                  print('12');
                                                                } else if (payment_response[
                                                                        'result'] ==
                                                                    "user_cancelled") {
                                                                  print(
                                                                      'calleds');
                                                                  Scaffold.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                          getSnackBar(
                                                                              'Transaction Failed !'));
                                                                  print('13');
                                                                  _productOrderProvider
                                                                          .isProductRemovingFromCartInProgress =
                                                                      false;
                                                                  print('14');
                                                                }

                                                                /// call final payment status api....
                                                                dynamic finalPaymentResponse = await ProductAPI.finalPaymentStatus(
                                                                    userId
                                                                        .toString(),
                                                                    "${response['response'][0]['order_total_cost']}",
                                                                    "${response['response'][0]['order_no']}",
                                                                    payment_response[
                                                                            'payment_response']
                                                                        [
                                                                        'status'],
                                                                    payment_response);

                                                                print(
                                                                    "from api : ${finalPaymentResponse}");

                                                                if (finalPaymentResponse[
                                                                        'status'] ==
                                                                    200) {
                                                                  /// show final payment success dialog...
                                                                  CoolAlert
                                                                      .show(
                                                                    context:
                                                                        context,
                                                                    type: CoolAlertType
                                                                        .success,
                                                                    text:
                                                                        "Your transaction was successful !",
                                                                    confirmBtnColor:
                                                                        colorPalette
                                                                            .navyBlue,
                                                                    title:
                                                                        "Payment Done.",
                                                                    animType:
                                                                        CoolAlertAnimType
                                                                            .scale,
                                                                  );

                                                                  try {
                                                                    Provider.of<HomeScreenProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .pageController
                                                                        .jumpToPage(
                                                                            3);
                                                                    Provider.of<OrderProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .orderId = "${response['response'][0]['order_no']}";
                                                                    print('15');
                                                                    _productOrderProvider
                                                                            .isProductRemovingFromCartInProgress =
                                                                        false;
                                                                    print('16');
                                                                    Provider.of<HomeScreenProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .selectedString = "OrderDetails";
                                                                    Provider.of<HomeScreenProvider>(
                                                                            context,
                                                                            listen:
                                                                                false)
                                                                        .selectedBottomIndex = 3;
                                                                  } catch (e) {
                                                                    print('17');
                                                                    _productOrderProvider
                                                                            .isProductRemovingFromCartInProgress =
                                                                        false;
                                                                    print('18');
                                                                    print(e);
                                                                  }
                                                                } else {
                                                                  print('19');
                                                                  _productOrderProvider
                                                                          .isProductRemovingFromCartInProgress =
                                                                      false;
                                                                  print('20');
                                                                }
                                                              } else {
                                                                _productOrderProvider
                                                                        .isProductRemovingFromCartInProgress =
                                                                    false;
                                                                Scaffold.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        getSnackBar(
                                                                            '${response['message']}'));
                                                              }
                                                            } catch (e) {
                                                              _productOrderProvider
                                                                      .isProductRemovingFromCartInProgress =
                                                                  false;
                                                              Scaffold.of(
                                                                      context)
                                                                  .showSnackBar(
                                                                      getSnackBar(
                                                                          'Order Failed !'));
                                                            }
                                                          }
                                                        : null,
                                              )
                                            ],
                                          );
                                  },
                                  itemCount:
                                      snapshot.data.response[0].cart.length + 1,
                                );
                              }
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
                          }),
                    ),
                  ],
                ),
                Visibility(
                  visible:
                      _productOrderProvider.isProductRemovingFromCartInProgress,
                  child: Container(
                    color: Colors.transparent,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation(colorPalette.navyBlue),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }
}
