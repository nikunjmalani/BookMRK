import 'package:bookmrk/api/category_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/category_with_subcategory_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  ColorPalette colorPalette = ColorPalette();

  /// get list of category with subcategory to filter....
  Future getListOfCategoryWithSubCategory() async {

    int userId = prefs.read<int>('userId');
    dynamic response =
        await CategoryAPI.getListOfCategoryWithSubCategory(userId.toString());
    CategoryWithSubcategoryListModel _categoryWithSubcategoryModel =
        CategoryWithSubcategoryListModel.fromJson(response);
    return _categoryWithSubcategoryModel;
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CategoryProvider>(context, listen: false)
        .selectedFilterCategoryList
        .clear();
  }

  List catList = [];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<CategoryProvider>(
        builder: (_, _categoryProvider, child) => FutureBuilder(
            future: getListOfCategoryWithSubCategory(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: colorPalette.grey,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 16, bottom: 16),
                                  child: Text(
                                    '${snapshot.data.response[index].categoryName}',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    children: List.generate(
                                        snapshot.data.response[index]
                                            .subCategory.length, (subIndex) {
                                      snapshot.data.response.forEach((cat) {
                                        List subCatList = [];
                                        cat.subCategory.forEach((subCat) {
                                          subCatList.add(false);
                                        });
                                        catList.add(subCatList);
                                      });

                                      return GestureDetector(
                                        child: CheckboxListTile(
                                          value: catList[index][subIndex],
                                          onChanged: (value) {
                                            catList[index][subIndex] = value;

                                            /// state to check either category selected by user is already in filter list or not...
                                            bool _containsCategory = false;

                                            /// if selected category is already in filter list then, index to remove that category...
                                            int indexToRemove = 0;

                                            /// logic to check either category in filter list or not...
                                            for (int i = 0;
                                                i <
                                                    _categoryProvider
                                                        .selectedFilterCategoryList
                                                        .length;
                                                i++) {
                                              if (_categoryProvider
                                                  .selectedFilterCategoryList[i]
                                                  .toString()
                                                  .contains(snapshot
                                                      .data
                                                      .response[index]
                                                      .subCategory[subIndex]
                                                      .categoryName)) {
                                                _containsCategory = true;
                                                indexToRemove = i;
                                              }
                                            }

                                            /// if selected category already in filter list then remove that category...
                                            if (_containsCategory) {
                                              _categoryProvider
                                                  .selectedFilterCategoryList
                                                  .removeAt(indexToRemove);
                                            } else {
                                              /// if selected category is not in filter list then add it to filter list...
                                              _categoryProvider
                                                  .selectedFilterCategoryListAddSingle(
                                                      snapshot
                                                          .data
                                                          .response[index]
                                                          .subCategory[subIndex]
                                                          .categoryName);
                                            }

                                            setState(() {});
                                          },
                                          activeColor: Colors.transparent,
                                          checkColor: colorPalette.navyBlue,
                                          title: Text(
                                            '${snapshot.data.response[index].subCategory[subIndex].categoryName}',
                                            style: TextStyle(
                                              fontFamily: 'Roboto',
                                              fontSize: 16,
                                              color: const Color(0xff000000),
                                              letterSpacing: 0.9100000000000001,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: snapshot.data.response.length,
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
}
