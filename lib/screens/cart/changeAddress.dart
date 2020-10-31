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

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  /// get user address in cart page..
  Future getUserAddress() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await UserAPI.getUserAddress(userId.toString());
    UserAddressModel _userModel = UserAddressModel.fromJson(response);
    return _userModel;
  }

  ColorPalette colorPalette = ColorPalette();

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserProvider>(
      builder: (_, _userProvider, child) => FutureBuilder(
          future: getUserAddress(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(top: 20),
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    height: width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: colorPalette.grey,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${snapshot.data.response[index].fname} ${snapshot.data.response[index].lname} \n${snapshot.data.response[index].mobile}',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 15,
                                      color: const Color(0xff000000),
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: width / 1.8,
                                    child: Text(
                                      'address 1 : ${snapshot.data.response[index].address1}',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: const Color(0xffa9a9aa),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: width / 1.8,
                                    child: Text(
                                      'address 2 : ${snapshot.data.response[index].address2}',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: const Color(0xffa9a9aa),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                              Consumer<UserProvider>(
                                builder: (_, _userProvider, child) =>
                                    BlueOutlineButton(
                                  width: width,
                                  onTap: () {
                                    _userProvider.selectedUserAddressId =
                                        snapshot
                                            .data.response[index].userAddressId
                                            .toString();
                                    homeProvider.selectedString = "EditAddress";
                                  },
                                  title: "EDIT",
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: snapshot.data.response[index].isSelected == "1"
                              ? () {}
                              : () async {
                                  _userProvider.changeAddressInProgress = true;
                                  SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
                                  int userId = _prefs.getInt('userId');
                                  dynamic response =
                                      await UserAPI.changeSelectedUserAddress(
                                          userId.toString(),
                                          snapshot.data.response[index]
                                              .userAddressId);
                                  if (response['status'] == 200) {
                                    setState(() {});

                                    _userProvider.changeAddressInProgress =
                                        false;
                                    Scaffold.of(context).showSnackBar(getSnackBar(
                                        'address is set as default address !'));
                                  } else {
                                    _userProvider.changeAddressInProgress =
                                        false;
                                    Scaffold.of(context).showSnackBar(getSnackBar(
                                        'unable to set address as default!'));
                                  }
                                },
                          child: Container(
                            alignment: Alignment.center,
                            height: width / 10,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(20)),
                              color: snapshot.data.response[index].isSelected ==
                                      "1"
                                  ? colorPalette.green
                                  : colorPalette.navyBlue,
                            ),
                            child: Text(
                              snapshot.data.response[index].isSelected == "1"
                                  ? "Default"
                                  : 'SELECT THIS ADDRESS',
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontSize: 15,
                                color: const Color(0xffffffff),
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: snapshot.data.response.length,
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
          }),
    );
  }
}
