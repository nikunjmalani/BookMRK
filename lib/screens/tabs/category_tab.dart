import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/model/category_list_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryTab extends StatefulWidget {
  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  Future<CategoryListModel> getCategoryList() async {
    dynamic categoryDetails = await CategoryAPI.getAllCategoryList();
    CategoryListModel _categoryListModel =
        CategoryListModel.fromJson(categoryDetails);
    return _categoryListModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getCategoryList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<HomeScreenProvider>(
              builder: (context, data, child) {
                return Column(
                  children: [
                    SearchBar(
                      width: width,
                      onTap: () {
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedString = "SearchProducts2";
                      },
                      title: "Search Products",
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: snapshot.data.response.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, childAspectRatio: 2.3),
                        itemBuilder: (context, index) {
                          return Consumer<CategoryProvider>(
                              builder: (_, _categoryProvider, child) {
                            return GestureDetector(
                              onTap: () {
                                data.selectedTitle = "${snapshot.data.response[index].categoryName}";
                                data.selectedString = "CategoryInfo";
                                _categoryProvider.selectedCategoryName =
                                    snapshot.data.response[index].catSlug;
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl:
                                        '${snapshot.data.response[index].categoryImg}',
                                    height: height / 5.2,
                                    fit: BoxFit.cover,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.red,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                    placeholder: (context, url) => Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/preload.png'),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.white,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/preload.png'),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.white,
                                                BlendMode.colorBurn)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 15),
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    child: Text(
                                      '${snapshot.data.response[index].categoryName}',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 18,
                                        color: const Color(0xffffffff),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 70.0),
                  ],
                );
              },
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
        });
  }
}
