import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/model/user_address_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  ColorPalette colorPalette = ColorPalette();

  Future getUserAddress() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic data = await UserAPI.getUserAddress(userId.toString());
    UserAddressModel _userAddressModel = UserAddressModel.fromJson(data);
    return _userAddressModel;
  }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
        builder: (_, _userProvider, child) => Stack(
              fit: StackFit.expand,
              children: [
                FutureBuilder(
                    future: getUserAddress(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 20),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<HomeScreenProvider>(context,
                                          listen: false)
                                      .selectedString = "UserAddAddress";
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 40,
                                      color: colorPalette.navyBlue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Add New Address',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 20,
                                        color: const Color(0xff301869),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: snapshot.data.response.length == 0
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 50.0,
                                          ),
                                          Text(
                                            'Please add address !',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 18.0),
                                          )
                                        ],
                                      )
                                    : ListView.builder(
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(top: 20),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            height: width / 2.2,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: colorPalette.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${snapshot.data.response[index].fname} ${snapshot.data.response[index].lname} \n${snapshot.data.response[index].mobile}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 15,
                                                              color: const Color(
                                                                  0xff000000),
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            '${snapshot.data.response[index].address1}, \n${snapshot.data.response[index].address2}, ${snapshot.data.response[index].city}, \n${snapshot.data.response[index].state}, ${snapshot.data.response[index].country}\n${snapshot.data.response[index].pincode}',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontSize: 13,
                                                              color: const Color(
                                                                  0xffa9a9aa),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ],
                                                      ),
                                                      BlueOutlineButton(
                                                        width: width,
                                                        title: "Edit",
                                                        onTap: () {
                                                          _userProvider
                                                                  .selectedUserAddressId =
                                                              "${snapshot.data.response[index].userAddressId}";
                                                          homeProvider
                                                                  .selectedString =
                                                              "UserEditAddress";
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    _userProvider
                                                            .changeAddressInProgress =
                                                        true;
                                                    SharedPreferences _prefs =
                                                        await SharedPreferences
                                                            .getInstance();
                                                    int userId =
                                                        _prefs.getInt('userId');
                                                    dynamic response = await UserAPI
                                                        .changeSelectedUserAddress(
                                                            userId.toString(),
                                                            snapshot
                                                                .data
                                                                .response[index]
                                                                .userAddressId);
                                                    if (response['status'] ==
                                                        200) {
                                                      setState(() {});

                                                      _userProvider
                                                              .changeAddressInProgress =
                                                          false;
                                                      Scaffold.of(context)
                                                          .showSnackBar(getSnackBar(
                                                              'address is set as default address !'));
                                                    } else {
                                                      _userProvider
                                                              .changeAddressInProgress =
                                                          false;
                                                      Scaffold.of(context)
                                                          .showSnackBar(getSnackBar(
                                                              'unable to set address as default!'));
                                                    }
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: width / 10,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.vertical(
                                                              bottom: Radius
                                                                  .circular(
                                                                      20)),
                                                      color: snapshot
                                                                  .data
                                                                  .response[
                                                                      index]
                                                                  .isSelected ==
                                                              "1"
                                                          ? colorPalette.green
                                                          : colorPalette
                                                              .navyBlue,
                                                    ),
                                                    child: Text(
                                                      snapshot
                                                                  .data
                                                                  .response[
                                                                      index]
                                                                  .isSelected ==
                                                              "1"
                                                          ? "Default"
                                                          : 'SELECT THIS ADDRESS',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 15,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount:
                                            snapshot.data.response.length,
                                      ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation(colorPalette.navyBlue),
                            ),
                          ),
                        );
                      }
                    }),
                Visibility(
                  visible: _userProvider.changeAddressInProgress,
                  child: Container(
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
