import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeScreenProvider>(context, listen: false);
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Provider.of<HomeScreenProvider>(context, listen: false)
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
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.only(top: 20),
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  height: width / 2.5,
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
                                  'Ovi Mahajan \n+915486589751',
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
                                Text(
                                  '15 B, Near Black Well, Chavhan Nagar, \nLacknow, Uttar Pradesh\n411037',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    color: const Color(0xffa9a9aa),
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            BlueOutlineButton(
                              width: width,
                              title: "Edit",
                              onTap: () => homeProvider.selectedString =
                                  "UserEditAddress",
                            )
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: width / 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20)),
                          color: index == 0
                              ? colorPalette.green
                              : colorPalette.navyBlue,
                        ),
                        child: Text(
                          index == 0 ? "Default" : 'SELECT THIS ADDRESS',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 15,
                            color: const Color(0xffffffff),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                );
              },
              itemCount: 3,
            ),
          )
        ],
      ),
    );
  }
}
