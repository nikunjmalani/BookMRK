import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/appBar.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SimpleAppBar(
          icon: Icons.close,
          title: "Search Products",
          context: context,
          onTap: () {
            Provider.of<HomeScreenProvider>(context, listen: false)
                .selectedString = "Home";
          },
        ),
        SearchBar(title: "Search Products", width: width),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (context, index) {
                return ProductBox(
                    height: height,
                    width: width,
                    title: "Circle Pencil Sharpner",
                    image: "assets/images/Sharpner.png",
                    description: "By Circle Enterprise",
                    price: 10);
              },
              itemCount: 14,
            ),
          ),
        )
      ],
    );
  }
}
