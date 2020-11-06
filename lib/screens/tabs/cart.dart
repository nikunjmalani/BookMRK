import 'package:bookmrk/api/cart_api.dart';
import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/cart_details_model.dart';
import 'package:bookmrk/model/no_data_cart_model.dart';
import 'package:bookmrk/model/user_address_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/product_order_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/priceDetailWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ColorPalette colorPalette = ColorPalette();

  /// total item count ...
  int totalItem = 0;

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

    int userId =  prefs.read<int>('userId');
    dynamic response = await UserAPI.getUserAddress(userId.toString());
    UserAddressModel _userAddress = UserAddressModel.fromJson(response);
    return _userAddress;
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
                                          width: MediaQuery.of(context).size.width / 1.5 ,
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
                                return Padding(
                                  padding: EdgeInsets.only(top: 30.0),
                                  child: Text('Any Address not selected !'),
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
                                totalItem = 0;
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (index <
                                        snapshot.data.response[0].cart.length) {
                                      totalItem = totalItem +
                                          (int.parse(
                                              '${snapshot.data.response[0].cart[index].qty}'));
                                    }

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
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              '${snapshot.data.response[0].cart[index].productImg}',
                                                          height: width / 3.5,
                                                          width: width / 3.5,
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
                                                          _productOrderProvider
                                                                  .isProductRemovingFromCartInProgress =
                                                              true;

                                                          int userId =  prefs
                                                              .read<int>('userId');
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
                                                          _productOrderProvider
                                                                  .isProductRemovingFromCartInProgress =
                                                              false;
                                                          setState(() {});
                                                        },
                                                        child: SvgPicture.asset(
                                                          "assets/icons/delete.svg",
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.0),
                                                      Text(
                                                        '${snapshot.data.response[0].cart[index].qty} Items',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff515c6f),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                        '₹ ${snapshot.data.response[0].cart[index].productSalePrice}',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff515c6f),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                      Text(
                                                        'Total : ${snapshot.data.response[0].cart[index].productFinalTotal} ₹',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xff515c6f),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
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
                                                itemCount: totalItem,
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
                                                title: "PROCESS TO CHECKOUT",
                                                height: height,
                                                onTap: snapshot
                                                            .data
                                                            .response[0]
                                                            .cartInfo[0]
                                                            .hideCheckoutButton ==
                                                        "NO"
                                                    ? () {}
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
