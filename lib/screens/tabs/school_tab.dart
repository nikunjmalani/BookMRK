import 'package:bookmrk/api/school_api.dart';
import 'package:bookmrk/model/school_list_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SchoolTab extends StatefulWidget {
  @override
  _SchoolTabState createState() => _SchoolTabState();
}

class _SchoolTabState extends State<SchoolTab> {
  Future<SchoolListModel> getAllSchoolList() async {
    dynamic schoolList = await SchoolAPI.getAllSchoolList();
    SchoolListModel _schoolListModel = SchoolListModel.fromJson(schoolList);
    return _schoolListModel;
  }

  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeScreenProvider>(
      builder: (_, data, child) => FutureBuilder(
        future: getAllSchoolList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<SchoolProvider>(
                builder: (_, _schoolProvider, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: 16,
                          top: 20,
                          bottom: 20,
                          right: 10,
                        ),
                        padding: EdgeInsets.only(left: 5, top: 3),
                        height: width / 8,
                        width: width / 1.3,
                        decoration: BoxDecoration(
                          color: Color(0xfff3f3f3),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: TextField(
                          onTap: () {},
                          onChanged: (value) {
                            if (value.length < 1) {
                              _schoolProvider.isSearchSchoolTabSelected = false;
                            } else {
                              _schoolProvider.isSearchSchoolTabSelected = true;
                              _schoolProvider.schoolsToFilter.clear();
                              snapshot.data.response.forEach((e) {
                                if (e.schoolName
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  _schoolProvider
                                      .schoolsToFilterAddSingleSchool(e);
                                }
                              });
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search School",
                            hintStyle: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 18,
                              color: Color(0xff515C6F),
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xff515C6F),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => LocationDialog(
                                width: width,
                                onCancelTap: () {
                                  Navigator.pop(context);
                                },
                                onSearchTap: () {},
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            "assets/icons/loc.svg",
                            height: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                  _schoolProvider.isSearchSchoolTabSelected
                      ? Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 70),
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.2),
                              itemCount: _schoolProvider.schoolsToFilter.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _schoolProvider.selectedSchoolSlug =
                                        "${_schoolProvider.schoolsToFilter[index].schoolSlug}";
                                    Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedString = "SchoolInfo";
                                  },
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            '${_schoolProvider.schoolsToFilter[index].schoolLogo}',
                                        height: height / 5.2,
                                        fit: BoxFit.fill,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/schoolImage.png"),
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/schoolImage.png"),
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        width: width,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                '${_schoolProvider.schoolsToFilter[index].schoolName}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17,
                                                  color: const Color(0xffffffff),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              width: width * 0.4,
                                              child: Text(
                                                '${_schoolProvider.schoolsToFilter[index].address}, ${_schoolProvider.schoolsToFilter[index].city}, ${_schoolProvider.schoolsToFilter[index].pincode}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xfff5f5f5),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                                height: 22,
                                                width: 90,
                                                child: Text(
                                                  'View Products',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 5, top: 3),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 70),
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, childAspectRatio: 1.2),
                              itemCount: snapshot.data.response.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _schoolProvider.selectedSchoolSlug =
                                        "${snapshot.data.response[index].schoolSlug}";

                                    Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedString = "SchoolInfo";
                                  },
                                  child: Stack(
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            '${snapshot.data.response[index].schoolLogo}',
                                        height: height / 5.2,
                                        fit: BoxFit.fill,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                        placeholder: (context, url) =>
                                            Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/schoolImage.png"),
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          margin: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/schoolImage.png"),
                                              fit: BoxFit.cover,

                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        width: width,
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 15),
                                              child: Text(
                                                '${snapshot.data.response[index].schoolName}',
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 17,
                                                  color: const Color(0xffffffff),
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            Container(
                                              width: width * 0.4,
                                              child: Text(
                                                '${snapshot.data.response[index].address}, ${snapshot.data.response[index].city}, ${snapshot.data.response[index].pincode}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xfff5f5f5),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 2,
                                                  ),
                                                ),
                                                height: 22,
                                                width: 90,
                                                child: Text(
                                                  'View Products',
                                                  style: TextStyle(
                                                    fontFamily: 'Roboto',
                                                    fontSize: 12,
                                                    color:
                                                        const Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                                padding: EdgeInsets.only(
                                                    left: 5, top: 3),
                                              ),
                                            ),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                ],
              );
            });
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

Widget LocationDialog({width, onSearchTap, onCancelTap}) {
  ColorPalette colorPalette = ColorPalette();

  return Dialog(
    elevation: 100,
    insetPadding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: Container(
      height: width,
      width: width - 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Search by Location',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: 20,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
            SimpleTextfield(
              "Zip Code",
            ),
            SimpleTextfield("State"),
            SimpleTextfield("City"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: onCancelTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: width / 8,
                    width: width / 2.8,
                    decoration: BoxDecoration(
                        color: colorPalette.navyBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onSearchTap,
                  child: Container(
                    alignment: Alignment.center,
                    height: width / 8,
                    width: width / 2.8,
                    decoration: BoxDecoration(
                        color: colorPalette.navyBlue,
                        borderRadius: BorderRadius.circular(18)),
                    child: Text(
                      "Search",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
