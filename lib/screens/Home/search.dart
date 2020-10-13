import 'package:bookmrk/api/search_api.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/search_product_model.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  ColorPalette colorPalette = ColorPalette();

  /// TextField Controller
  TextEditingController _searchProductController = TextEditingController();

  /// search products....
  Future searchProducts(String productName) async {
    if (productName.length < 1) {
      productName = "a";
    }
    dynamic response = await SearchAPI.searchProductHomePage(productName);
    print(response);
    if (response['response'].length == 0) {
      NoDataOrderModel _noData = NoDataOrderModel.fromJson(response);
      return _noData;
    } else {
      SearchProductModel _searchProductModel =
          SearchProductModel.fromJson(response);
      return _searchProductModel;
    }
  }

  @override
  void initState() {
    super.initState();
    _searchProductController.text = "asa";
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SearchBar(
            title: "Search Products",
            width: width,
            controller: _searchProductController,
            onChanged: (value) {
              print(value);
              _searchProductController.text = value;
            }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: FutureBuilder(
                future: searchProducts(_searchProductController.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.response.length != 0) {
                      return GridView.builder(
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
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.only(top: 40.0),
                        child: Text('Please write Correct name'),
                      );
                    }
                  } else {
                    return Container(
                      color: Colors.transparent,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(colorPalette.navyBlue),
                        ),
                      ),
                    );
                  }
                }),
          ),
        )
      ],
    );
  }
}
