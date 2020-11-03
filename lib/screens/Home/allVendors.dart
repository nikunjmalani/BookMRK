import 'package:bookmrk/api/vendor_api.dart';
import 'package:bookmrk/model/vendor_model.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
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

  /// fetch all vendors..
  Future<VendorModel> getAllVendors() async {
    dynamic respose = await VendorAPI.getAllVendors();
    VendorModel _vendorModel = VendorModel.fromJson(respose);
    return _vendorModel;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: getAllVendors(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Consumer<VendorProvider>(
              builder: (_, _vendorProvider, child) => SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchBar(
                      width: width,
                      title: "Search Vendors",
                      onChanged: (value) {
                        if (value.length < 1) {
                          _vendorProvider.isVendorBarSelected = false;
                        } else {
                          _vendorProvider.isVendorBarSelected = true;
                          _vendorProvider.vendorFilterList.clear();

                          snapshot.data.response.forEach((e) {
                            if (e.vendorName
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                              _vendorProvider.vendorFilterListAddSingle(e);
                            }
                          });
                        }
                      },
                    ),
                    _vendorProvider.isVendorBarSelected
                        ? Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _vendorProvider.selectedVendorName =
                                        _vendorProvider
                                            .vendorFilterList[index].vendorSlug;
                                    Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedString = "VendorInfo";
                                  },
                                  child: ImageBox(
                                      height: height,
                                      width: width,
                                      image:
                                          "${_vendorProvider.vendorFilterList[index].companyLogo}",
                                      title:
                                          "${_vendorProvider.vendorFilterList[index].companyName}"),
                                );
                              },
                              itemCount:
                                  _vendorProvider.vendorFilterList.length,
                            ),
                          )
                        : Expanded(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {

                                    _vendorProvider.selectedVendorName =
                                        snapshot
                                            .data.response[index].vendorSlug;
                                    Provider.of<HomeScreenProvider>(context,
                                            listen: false)
                                        .selectedString = "VendorInfo";
                                  },
                                  child: ImageBox(
                                      height: height,
                                      width: width,
                                      image:
                                          "${snapshot.data.response[index].companyLogo}",
                                      title:
                                          "${snapshot.data.response[index].companyName}"),
                                );
                              },
                              itemCount: snapshot.data.response.length,
                            ),
                          ),
                  ],
                ),
              ),
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
