import 'package:bookmrk/api/location_name_api.dart';
import 'package:bookmrk/api/school_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/filter_school_by_category.dart';
import 'package:bookmrk/model/no_data_model.dart';
import 'package:bookmrk/model/school_list_model.dart';
import 'package:bookmrk/provider/city_model.dart';
import 'package:bookmrk/provider/country_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/state_model.dart';
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
  /// pincode controller...
  TextEditingController _pincodeController = TextEditingController();

  /// get all the list of school...
  Future<SchoolListModel> getAllSchoolList() async {
    dynamic schoolList = await SchoolAPI.getAllSchoolList();
    SchoolListModel _schoolListModel = SchoolListModel.fromJson(schoolList);
    return _schoolListModel;
  }

  /// get all the school list by the location wise filter....
  Future getLocationFilterWiseSchool(
      String countryId, String stateId, String cityId, String pincode) async {
    int userId = prefs.read<int>('userId');
    dynamic response = await SchoolAPI.findSchoolByLocation(
        userId.toString(), countryId, stateId, cityId, pincode);
    if (response['response'].length > 0) {
      FilterSchoolByLocation _filterSchoolByLocation =
          FilterSchoolByLocation.fromJson(response);
      return _filterSchoolByLocation;
    } else {
      NoDataOrderModel _noDataModel = NoDataOrderModel.fromJson(response);
      return _noDataModel;
    }
  }

  ColorPalette colorPalette = ColorPalette();

  autoFillFields() {
    Provider.of<SchoolProvider>(context, listen: false)
        .isFindSchoolByLocationSelected = false;
    Provider.of<SchoolProvider>(context, listen: false).isSearchSchoolTabSelected = false;
    Provider.of<SchoolProvider>(context, listen: false).selectedCountryIdForSchool = 101;
  }

  @override
  void initState() {
    super.initState();
    autoFillFields();
  }

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
                              _schoolProvider.isFindSchoolByLocationSelected =
                                  false;
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
                                pinCodeController: _pincodeController,
                                onCancelTap: () {
                                  Navigator.pop(context);
                                },
                                onSearchTap: () {
                                  /// assign zero if any fileds are null...

                                  _schoolProvider.selectedCityIdForSchool =
                                      _schoolProvider.selectedCityIdForSchool ==
                                              null
                                          ? 0
                                          : _schoolProvider
                                              .selectedCityIdForSchool;
                                  _schoolProvider.selectedStateIdForSchool =
                                      _schoolProvider
                                                  .selectedStateIdForSchool ==
                                              null
                                          ? 0
                                          : _schoolProvider
                                              .selectedStateIdForSchool;
                                  _schoolProvider.selectedCountryIdForSchool =
                                      _schoolProvider
                                                  .selectedCountryIdForSchool ==
                                              null
                                          ? 0
                                          : _schoolProvider
                                              .selectedCountryIdForSchool;
                                  _pincodeController.text =
                                      _pincodeController.text == "" ||
                                              _pincodeController.text == null
                                          ? ""
                                          : _pincodeController.text;
                                  _schoolProvider.selectedPinCodeForSchool =
                                      _pincodeController.text;
                                  _schoolProvider
                                      .isFindSchoolByLocationSelected = true;
                                  Navigator.pop(context);
                                },
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
                  _schoolProvider.isFindSchoolByLocationSelected
                      ? FutureBuilder(
                          future: getLocationFilterWiseSchool(
                              _schoolProvider.selectedCountryIdForSchool
                                  .toString(),
                              _schoolProvider.selectedStateIdForSchool
                                  .toString(),
                              _schoolProvider.selectedCityIdForSchool
                                  .toString(),
                              _schoolProvider.selectedPinCodeForSchool),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.response.length > 0) {
                                return Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 70),
                                    child: GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 1.2),
                                      itemCount: snapshot.data.response.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Provider.of<HomeScreenProvider>(
                                                        context,
                                                        listen: false)
                                                    .selectedTitle =
                                                "${snapshot.data.response[index].schoolName}";

                                            _schoolProvider.selectedSchoolSlug =
                                                "${snapshot.data.response[index].schoolSlug}";

                                            Provider.of<HomeScreenProvider>(
                                                    context,
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
                                                        BorderRadius.circular(
                                                            10),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/preload.png"),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Container(
                                                  margin: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/images/preload.png"),
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
                                                  color: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                                width: width,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: Text(
                                                        '${snapshot.data.response[index].schoolName}',
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 17,
                                                          color: const Color(
                                                              0xffffffff),
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 7,
                                                    ),
                                                    Container(
                                                      width: width * 0.4,
                                                      child: Text(
                                                        '${snapshot.data.response[index].address}, ${snapshot.data.response[index].city}, ${snapshot.data.response[index].pincode}',
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto',
                                                          fontSize: 14,
                                                          color: const Color(
                                                              0xfff5f5f5),
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 10),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
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
                                                            fontFamily:
                                                                'Roboto',
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xffffffff),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5,
                                                                top: 3),
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
                                );
                              } else {
                                return GestureDetector(
                                  onTap: () {
                                    _schoolProvider
                                        .isFindSchoolByLocationSelected = false;
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 50.0),
                                      SvgPicture.asset(
                                        'assets/icons/no_data.svg',
                                        height: 100,
                                      ),
                                      SizedBox(height: 20.0),
                                      Text(
                                        'No Data',
                                        style: TextStyle(
                                          color: colorPalette.navyBlue,
                                          fontSize: 20.0,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                            } else {
                              return Container(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(
                                      colorPalette.navyBlue),
                                ),
                              );
                            }
                          })
                      : _schoolProvider.isSearchSchoolTabSelected
                          ? Expanded(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 70),
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.2),
                                  itemCount:
                                      _schoolProvider.schoolsToFilter.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Provider.of<HomeScreenProvider>(context,
                                                    listen: false)
                                                .selectedTitle =
                                            "${_schoolProvider.schoolsToFilter[index].schoolName}";

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
                                                      "assets/images/preload.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/preload.png"),
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
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            ),
                                            width: width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Text(
                                                    '${_schoolProvider.schoolsToFilter[index].schoolName}',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 17,
                                                      color: const Color(
                                                          0xffffffff),
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      color: const Color(
                                                          0xfff5f5f5),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                        color: const Color(
                                                            0xffffffff),
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
                                          crossAxisCount: 2,
                                          childAspectRatio: 1.2),
                                  itemCount: snapshot.data.response.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Provider.of<HomeScreenProvider>(context,
                                                    listen: false)
                                                .selectedTitle =
                                            "${snapshot.data.response[index].schoolName}";
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
                                                      "assets/images/preload.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              margin: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/preload.png"),
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
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                            ),
                                            width: width,
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    '${snapshot.data.response[index].schoolName}',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 17,
                                                      color: const Color(
                                                          0xffffffff),
                                                      fontWeight:
                                                          FontWeight.w700,
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
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 14,
                                                      color: const Color(
                                                          0xfff5f5f5),
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                        color: const Color(
                                                            0xffffffff),
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

Widget LocationDialog(
    {width,
    onSearchTap,
    onCancelTap,
    TextEditingController pinCodeController}) {
  ColorPalette colorPalette = ColorPalette();

  /// get all country
  Future getAllCountry() async {
    dynamic response = await LocationNameAPI.getAllCountryName();
    CountryModel _countryModel = CountryModel.fromJson(response);
    return _countryModel;
  }

  /// get all state of selected country
  Future getAllStateOfSelectedCountry(int countryId) async {
    dynamic response = await LocationNameAPI.getAllStateOfCountry(countryId);
    StateModel _stateModel = StateModel.fromJson(response);
    return _stateModel;
  }

  /// get all city of selected state
  Future getAllCityOfSelectedState(int stateId) async {
    dynamic response = await LocationNameAPI.getAllCityOfState(stateId);
    CityModel _cityModel = CityModel.fromJson(response);
    return _cityModel;
  }

  return Dialog(
    elevation: 100,
    insetPadding: EdgeInsets.symmetric(horizontal: 16),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    child: Container(
      height: width,
      width: width - 32,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Consumer<SchoolProvider>(
            builder: (_, _schoolProvider, child) => Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                  'Search by Location',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: const Color(0xff000000),
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 20.0),
                SimpleTextfield("Pin Code",
                    controller: pinCodeController,
                    keyboardType: TextInputType.number),
                // SizedBox(height: 20.0),
                FutureBuilder(
                    future: getAllCountry(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int index1 = 0;
                        snapshot.data.response.forEach((e){
                          if((e.name.toString().toLowerCase()) == "india"){
                            Provider.of<SchoolProvider>(context, listen: false).selectedCountryIndexForSchool = index1;

                            Provider.of<SchoolProvider>(context, listen: false).selectedCountryIdForSchool =
                                int.parse(snapshot.data
                                    .response[index1].countryId);
                          }
                          index1++;
                        });
                        return Container(
                          // height: 60.0,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(13.0),
                          //   border: Border.all(
                          //     color: Colors.black.withOpacity(0.4),
                          //   ),
                          // ),
                          // alignment: Alignment.center,
                          // padding: EdgeInsets.symmetric(horizontal: 10.0),
                          // child: DropdownButton(
                          //   onChanged: (v){},
                          //   underline: Container(),
                          //   isExpanded: true,
                          //   style: TextStyle(
                          //     color: colorPalette.lightGrey,
                          //     fontSize: 16,
                          //   ),
                          //   value: snapshot
                          //       .data
                          //       .response[_schoolProvider
                          //           .selectedCountryIndexForSchool]
                          //       .name,
                          //   items: List.generate(
                          //       snapshot.data.response.length,
                          //       (index) => DropdownMenuItem(
                          //             child: Text(
                          //               '${snapshot.data.response[index].name}',
                          //               overflow: TextOverflow.ellipsis,
                          //               style: TextStyle(
                          //                 color: Colors.black,
                          //                 fontSize: 16,
                          //               ),
                          //             ),
                          //             value:
                          //                 '${snapshot.data.response[index].name}',
                          //             onTap: () {
                          //               _schoolProvider
                          //                       .selectedCountryIndexForSchool =
                          //                   index;
                          //               _schoolProvider
                          //                       .selectedCountryIdForSchool =
                          //                   int.parse(snapshot.data
                          //                       .response[index].countryId);
                          //             },
                          //           )),
                          // ),
                        );
                      } else {
                        return Container(
                          // height: 60.0,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(13.0),
                          //   border: Border.all(
                          //     color: Colors.black.withOpacity(0.4),
                          //   ),
                          // ),
                          // alignment: Alignment.center,
                          // padding: EdgeInsets.symmetric(horizontal: 10.0),
                          // child: DropdownButton(
                          //   underline: Container(),
                          //   isExpanded: true,
                          //   onChanged: (value) {},
                          //   value: 'loading',
                          //   style: TextStyle(
                          //     color: colorPalette.lightGrey,
                          //     fontSize: 16,
                          //   ),
                          //   items: [
                          //     DropdownMenuItem(
                          //       child: Text('Loading'),
                          //       value: 'loading',
                          //     )
                          //   ],
                          // ),
                        );
                      }
                    }),
                SizedBox(height: 20.0),
                FutureBuilder(
                    future: getAllStateOfSelectedCountry(
                        _schoolProvider.selectedCountryIdForSchool),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.response.length > 0) {
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            onChanged: (v){},
                            underline: Container(),
                            isExpanded: true,
                            style: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            value: snapshot
                                .data
                                .response[
                                    _schoolProvider.selectedStateIndexForSchool]
                                .name,
                            items: List.generate(
                                snapshot.data.response.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                        '${snapshot.data.response[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      value:
                                          '${snapshot.data.response[index].name}',
                                      onTap: () {
                                        _schoolProvider
                                                .selectedStateIndexForSchool =
                                            index;
                                        _schoolProvider
                                                .selectedStateIdForSchool =
                                            int.parse(snapshot
                                                .data.response[index].stateId);
                                        _schoolProvider.selectedCityIndexForSchool = 0;
                                      },
                                    )),
                          ),
                        );
                      } else {
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (value) {},
                            value: 'state',
                            style: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text('State'),
                                value: 'state',
                              )
                            ],
                          ),
                        );
                      }
                    }),
                SizedBox(height: 20.0),
                FutureBuilder(
                    future: getAllCityOfSelectedState(
                        _schoolProvider.selectedStateIdForSchool),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.response.length > 0) {
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            onChanged: (v){},
                            underline: Container(),
                            isExpanded: true,
                            style: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            value: snapshot
                                .data
                                .response[
                                    _schoolProvider.selectedCityIndexForSchool]
                                .name,
                            items: List.generate(
                                snapshot.data.response.length,
                                (index) => DropdownMenuItem(
                                      child: Text(
                                        '${snapshot.data.response[index].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      value:
                                          '${snapshot.data.response[index].name}',
                                      onTap: () {
                                        _schoolProvider
                                            .selectedCityIndexForSchool = index;
                                        _schoolProvider
                                                .selectedCityIdForSchool =
                                            int.parse(snapshot
                                                .data.response[index].cityId);
                                      },
                                    )),
                          ),
                        );
                      } else {
                        return Container(
                          height: 60.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: DropdownButton(
                            underline: Container(),
                            isExpanded: true,
                            onChanged: (value) {},
                            value: 'city',
                            style: TextStyle(
                              color: colorPalette.lightGrey,
                              fontSize: 16,
                            ),
                            items: [
                              DropdownMenuItem(
                                child: Text('City'),
                                value: 'city',
                              )
                            ],
                          ),
                        );
                      }
                    }),
                SizedBox(height: 40.0),
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
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
