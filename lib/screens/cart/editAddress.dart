import 'package:bookmrk/api/location_name_api.dart';
import 'package:bookmrk/api/user_api.dart';
import 'package:bookmrk/model/edit_address_info_model.dart';
import 'package:bookmrk/provider/city_model.dart';
import 'package:bookmrk/provider/country_model.dart';
import 'package:bookmrk/provider/location_name_provider.dart';
import 'package:bookmrk/provider/state_model.dart';
import 'package:bookmrk/provider/user_provider.dart';
import 'package:bookmrk/widgets/addressTextfields.dart';
import 'package:bookmrk/widgets/snackbar_global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAddress extends StatefulWidget {
  final String userAddressId;

  const EditAddress({this.userAddressId});
  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  LocationProvider _locationProviderInit;

  /// TextFields...
  TextEditingController _firstNameEditAddress = TextEditingController();
  TextEditingController _lastNameEditAddress = TextEditingController();
  TextEditingController _emailEditAddress = TextEditingController();
  TextEditingController _contactEditAddress = TextEditingController();
  TextEditingController _zipEditAddress = TextEditingController();
  TextEditingController _firstAddressEdit = TextEditingController();
  TextEditingController _secondAddressEdit = TextEditingController();

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

  /// get default address information to edit
  Future getDefaultAddressInformationToEdit() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    int userId = _prefs.getInt('userId');
    dynamic response = await UserAPI.getCurrentAddressForEdit(
        userId.toString(), widget.userAddressId);
    EditAddressInfoModel _editAddressInfoModel =
        EditAddressInfoModel.fromJson(response);

    _firstNameEditAddress.text = _editAddressInfoModel.response[0].fname;
    _lastNameEditAddress.text = _editAddressInfoModel.response[0].lname;
    _emailEditAddress.text = _editAddressInfoModel.response[0].email;
    _contactEditAddress.text = _editAddressInfoModel.response[0].mobile;
    _zipEditAddress.text = _editAddressInfoModel.response[0].pincode;
    _firstAddressEdit.text = _editAddressInfoModel.response[0].address1;
    _secondAddressEdit.text = _editAddressInfoModel.response[0].address2;
    _locationProviderInit.selectedCountryId = int.parse(
        '${_editAddressInfoModel.response[0].countriesId == "" ? 101 : _editAddressInfoModel.response[0].countriesId}');

    _locationProviderInit.selectedCountryName =
        _editAddressInfoModel.response[0].countries == ""
            ? "India"
            : _editAddressInfoModel.response[0].countries;
    _locationProviderInit.selectedStateId = int.parse(
        '${_editAddressInfoModel.response[0].stateId == "" ? 22 : _editAddressInfoModel.response[0].stateId}');
    _locationProviderInit.selectedStateName =
        _editAddressInfoModel.response[0].state == ""
            ? "Maharashtra"
            : _editAddressInfoModel.response[0].state;
    _locationProviderInit.selectedCityId = int.parse(
        '${_editAddressInfoModel.response[0].cityId == "" ? 51 : _editAddressInfoModel.response[0].cityId}');
    _locationProviderInit.selectedCityName =
        _locationProviderInit.selectedStateName =
            _editAddressInfoModel.response[0].city == ""
                ? "Chintalavalasa"
                : _editAddressInfoModel.response[0].city;
  }

  @override
  void initState() {
    super.initState();
    getDefaultAddressInformationToEdit();
  }

  @override
  Widget build(BuildContext context) {
    _locationProviderInit = Provider.of<LocationProvider>(context);
    var width = MediaQuery.of(context).size.width;
    return Consumer<LocationProvider>(
      builder: (_, _locationProvider, child) => Consumer<UserProvider>(
        builder: (_, _userProvider, child) => Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: width / 20,
                    ),
                    AddressTextFields(
                        width: width,
                        title: "First Name",
                        controller: _firstNameEditAddress),
                    SizedBox(
                      height: width / 20,
                    ),
                    AddressTextFields(
                        width: width,
                        title: "Last Name",
                        controller: _lastNameEditAddress),
                    SizedBox(
                      height: width / 20,
                    ),
                    AddressTextFields(
                        width: width,
                        title: "email Address",
                        controller: _emailEditAddress),
                    SizedBox(
                      height: width / 20,
                    ),
                    AddressTextFields(
                        width: width,
                        title: "Contact Number",
                        controller: _contactEditAddress),
                    SizedBox(
                      height: width / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AddressTextFields(
                            width: width / 2.25,
                            title: "Zip Code",
                            controller: _zipEditAddress),
                        FutureBuilder(
                          future: getAllCountry(),
                          builder: (context, countryData) {
                            if (countryData.hasData) {
                              return getLocationBottomSheet(
                                  context,
                                  List.generate(
                                      countryData.data.response.length,
                                      (index) => {
                                            "name":
                                                "${countryData.data.response[index].name}",
                                            "id":
                                                "${countryData.data.response[index].countryId}"
                                          }),
                                  width / 2.25,
                                  type: locationType.Country);
                            } else {
                              return Container(
                                width: width / 2.25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'country',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: const Color(0x80515c6f),
                                        letterSpacing: 0.9100000000000001,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: width,
                                      padding: EdgeInsets.only(
                                          top: 16.0,
                                          bottom: 17.0,
                                          left: 5.0,
                                          right: 5.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Loading ..',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: width / 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FutureBuilder(
                          future: getAllStateOfSelectedCountry(
                              _locationProvider.selectedCountryId),
                          builder: (context, stateData) {
                            if (stateData.hasData &&
                                _locationProvider.selectedCountryId != null) {
                              print('has data ');
                            }
                            if (stateData.hasData) {
                              return getLocationBottomSheet(
                                  context,
                                  List.generate(
                                      stateData.data.response.length,
                                      (index) => {
                                            "name":
                                                "${stateData.data.response[index].name}",
                                            "id":
                                                "${stateData.data.response[index].stateId}"
                                          }),
                                  width / 2.25,
                                  type: locationType.State);
                            } else {
                              return Container(
                                width: width / 2.25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'state',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: const Color(0x80515c6f),
                                        letterSpacing: 0.9100000000000001,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: width,
                                      padding: EdgeInsets.only(
                                          top: 16.0,
                                          bottom: 17.0,
                                          left: 5.0,
                                          right: 5.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Loading ..',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder(
                          future: getAllCityOfSelectedState(
                              _locationProvider.selectedStateId),
                          builder: (context, cityData) {
                            if (cityData.hasData &&
                                _locationProvider.selectedStateId != null) {
                              return getLocationBottomSheet(
                                  context,
                                  List.generate(
                                      cityData.data.response.length,
                                      (index) => {
                                            "name":
                                                "${cityData.data.response[index].name}",
                                            "id":
                                                "${cityData.data.response[index].cityId}"
                                          }),
                                  width / 2.25,
                                  type: locationType.City);
                            } else {
                              return Container(
                                width: width / 2.25,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'city',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13,
                                        color: const Color(0x80515c6f),
                                        letterSpacing: 0.9100000000000001,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: width,
                                      padding: EdgeInsets.only(
                                          top: 16.0,
                                          bottom: 17.0,
                                          left: 5.0,
                                          right: 5.0),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.3),
                                            width: 1.5,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Loading ..',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color:
                                                Colors.black.withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    AddressTextFields(
                        width: width,
                        title: "Address Line 1",
                        controller: _firstAddressEdit),
                    SizedBox(
                      height: width / 20,
                    ),
                    AddressTextFields(
                        width: width,
                        title: "Address Line 2",
                        controller: _secondAddressEdit),
                    SizedBox(
                      height: width / 3,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Consumer<UserProvider>(
                builder: (_, _userProvider, child) => GestureDetector(
                  onTap: () async {
                    _userProvider.userAddressEditInProgress = true;

                    /// change address from user profile..
                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();
                    int userId = _prefs.getInt('userId');

//                  print(' user id : $userId');
//                  print(
//                      ' user address id : ${_userProvider.selectedUserAddressId}');
//                  print('first name : ${_firstNameEditAddress.text}');
//                  print('last name : ${_lastNameEditAddress.text}');
//                  print('email : ${_emailEditAddress.text}');
//                  print(' contact : ${_contactEditAddress.text}');
//                  print(' zip : ${_zipEditAddress.text}');
//                  print(' country : ${_countryEditAddress.text}');
//                  print(' state : ${_stateEditAddress.text}');
//                  print(' city : ${_cityEditAddress.text}');
//                  print(' ad1 : ${_firstAddressEdit.text}');
//                  print(' ad2 : ${_secondAddressEdit.text}');

                    dynamic response = await UserAPI.editUserAddress(
                      userId.toString(),
                      _userProvider.selectedUserAddressId,
                      _firstNameEditAddress.text,
                      _lastNameEditAddress.text,
                      _emailEditAddress.text,
                      _contactEditAddress.text,
                      '${_locationProvider.selectedStateId ?? 0}',
                      '${_locationProvider.selectedCityId ?? 0}',
                      _firstAddressEdit.text,
                      _secondAddressEdit.text,
                      _zipEditAddress.text,
                    );

                    print(response);

                    if (response['status'] == 200) {
                      _userProvider.userAddressEditInProgress = false;
                      Scaffold.of(context)
                          .showSnackBar(getSnackBar('record Changed !'));
                    } else {
                      _userProvider.userAddressEditInProgress = false;
                      Scaffold.of(context)
                          .showSnackBar(getSnackBar('${response['message']}'));
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(bottom: 10),
                    alignment: Alignment.center,
                    child: Text(
                      "Save Changes",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: const Color(0xffffffff),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    height: width / 5,
                    color: colorPalette.navyBlue,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _userProvider.userAddressEditInProgress,
              child: Container(
                color: Colors.transparent,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colorPalette.navyBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getLocationBottomSheet(BuildContext context,
      List<Map<String, dynamic>> locationData, double width,
      {locationType type}) {
    return Consumer<LocationProvider>(
      builder: (_, _locationProvider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            type == locationType.Country
                ? "Country"
                : type == locationType.State
                    ? "State"
                    : type == locationType.City ? "city" : "Location",
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              color: const Color(0x80515c6f),
              letterSpacing: 0.9100000000000001,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: width,
              child: GestureDetector(
                onTap: _locationProvider.isLocationSheetOpen
                    ? () {}
                    : () {
                        _locationProvider.isLocationSheetOpen = true;
                        showBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            height: 300.0,
                            width: MediaQuery.of(context).size.width,
                            color: colorPalette.navyBlue,
                            child: Column(
                              children: [
                                SizedBox(height: 20.0),
                                Container(
                                  height: 5.0,
                                  width: 50.0,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                SizedBox(height: 20.0),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        locationData.length,
                                        (index) => Column(
                                          children: [
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                if (type ==
                                                    locationType.Country) {
                                                  _locationProvider
                                                          .selectedCountryId =
                                                      int.parse(
                                                          '${locationData[index]['id']}');
                                                  _locationProvider
                                                          .selectedCountryName =
                                                      locationData[index]
                                                          ['name'];
                                                } else if (type ==
                                                    locationType.State) {
                                                  _locationProvider
                                                          .selectedStateId =
                                                      int.parse(
                                                          '${locationData[index]['id']}');
                                                  _locationProvider
                                                          .selectedStateName =
                                                      locationData[index]
                                                          ['name'];
                                                } else if (type ==
                                                    locationType.City) {
                                                  _locationProvider
                                                          .selectedCityId =
                                                      int.parse(
                                                          '${locationData[index]['id']}');
                                                  _locationProvider
                                                          .selectedCityName =
                                                      locationData[index]
                                                          ['name'];
                                                }

                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                height: 40.0,
                                                color: Colors.white
                                                    .withOpacity(0.02),
                                                alignment: Alignment.center,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Text(
                                                  '${locationData[index]['name']}',
                                                  style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              color:
                                                  Colors.white.withOpacity(0.4),
                                              width: 30.0,
                                              height: 1.0,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ).closed.then((value) {
                          _locationProvider.isLocationSheetOpen = false;
                        });
                      },
                child: Container(
                    width: width,
                    padding: EdgeInsets.only(
                        top: 16.0, bottom: 17.0, left: 5.0, right: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Row(
                      children: [
                        Text(
                          type == locationType.Country
                              ? '${_locationProvider.selectedCountryName}'
                              : type == locationType.State
                                  ? '${_locationProvider.selectedStateName}'
                                  : type == locationType.City
                                      ? '${_locationProvider.selectedCityName}'
                                      : 'Select Location',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black.withOpacity(0.4)),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black.withOpacity(0.4),
                        )
                      ],
                    )),
              )),
        ],
      ),
    );
  }
}

enum locationType {
  Country,
  State,
  City,
}
