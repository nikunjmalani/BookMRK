import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllVendors extends StatefulWidget {
  @override
  _AllVendorsState createState() => _AllVendorsState();
}

class _AllVendorsState extends State<AllVendors> {
  ImagePath imagePath = ImagePath();
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SearchBar(width: width, title: "Search Vendors"),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Provider.of<HomeScreenProvider>(context, listen: false)
                        .selectedString = "VendorInfo";
                  },
                  child: ImageBox(
                      height: height,
                      width: width,
                      image: "assets/images/circle.png",
                      title: "Raju rastogi"),
                );
              },
              itemCount: 15,
            ),
          ),
        ],
      ),
    );
  }
}
