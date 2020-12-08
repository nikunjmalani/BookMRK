import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/school_provider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/carasoul.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:bookmrk/widgets/testStyle.dart';
import 'package:bookmrk/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ColorPalette colorPalette = ColorPalette();
  ImagePath imagePath = ImagePath();
  int currentPage = 1;

  PageController pageController = PageController(initialPage: 1);

  /// get data for home page..
  Future<HomePageModel> getHomePageDetails() async {
    dynamic data = await HomePageApi.getHomePageDetails();

    HomePageModel _homePageDetails = HomePageModel.fromJson(data);
    return _homePageDetails;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return _buildHome(width, height);
  }

  Widget _buildHome(double width, double height) {
    return FutureBuilder(
      future: getHomePageDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Consumer<HomeScreenProvider>(
            builder: (_, _homeScreenProvider, child) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              SearchBar(
                                width: width,
                                title: "Search Products",
                                onTap: () {
                                  Provider.of<HomeScreenProvider>(context,
                                          listen: false)
                                      .selectedString = "SearchProducts";
                                  Provider.of<HomeScreenProvider>(context,
                                          listen: false)
                                      .findHomeScreenProduct = "";
                                },
                              ),
                              Carasoul(
                                height: height,
                                width: width,
                                colorPalette: colorPalette,
                                currentPage: currentPage,
                                onChanged: (value) {
                                  setState(() {
                                    currentPage = value;
                                  });
                                },
                                banners: snapshot.data.response[0].homeBanner,
                                pageController: pageController,
                              ),
                              SizedBox(height: 10.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Categories"),
                                    Spacer(),
                                    ViewAll(onClick: () {
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedString = "Category";
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedBottomIndex = 1;
                                    })
                                  ],
                                ),
                              ),
                              Container(
                                height:
                                    snapshot.data.response[0].product.length > 0
                                        ? height / 2.2
                                        : height / 9,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                    color: Color(0xffcfcfcf),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(22),
                                          topLeft: Radius.circular(22)),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              snapshot.data.response[0].category
                                                  .length,
                                              (index) =>
                                                  Consumer<CategoryProvider>(
                                                    builder: (_,
                                                            _categoryProvider,
                                                            child) =>
                                                        GestureDetector(
                                                      onTap: () {
                                                        Provider.of<HomeScreenProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .selectedTitle =
                                                            "${snapshot.data.response[0].category[index].categoryName}";

                                                        Provider.of<HomeScreenProvider>(
                                                                    context,
                                                                    listen: false)
                                                                .selectedString =
                                                            "CategoryInfo";
                                                        _categoryProvider
                                                                .selectedCategoryName =
                                                            snapshot
                                                                .data
                                                                .response[0]
                                                                .category[index]
                                                                .catSlug;
                                                      },
                                                      child: CategoryButtons(
                                                        "${snapshot.data.response[0].category[index].categoryName}",
                                                        index == 0
                                                            ? colorPalette
                                                                .orange
                                                            : colorPalette
                                                                .navyBlue,
                                                        index == 0
                                                            ? colorPalette
                                                                .pinkOrange
                                                            : Color(0xff6A4B9C),
                                                      ),
                                                    ),
                                                  )),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: snapshot.data.response[0].product
                                                  .length >
                                              0
                                          ? height / 3
                                          : 0.0,
                                      child: ListView.builder(
                                        physics: BouncingScrollPhysics(),
                                        itemCount: snapshot
                                            .data.response[0].product.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Consumer<VendorProvider>(
                                            builder:
                                                (_, _vendorProvider, child) =>
                                                    GestureDetector(
                                              onTap: () {
                                                // _homeScreenProvider.selectedTitle = "${snapshot.data.response[0].product[index].vendorSlug}";3
                                                _homeScreenProvider
                                                        .selectedTitle =
                                                    "${snapshot.data.response[0].product[index].productName}";
                                                _vendorProvider
                                                        .selectedVendorName =
                                                    "${snapshot.data.response[0].product[index].vendorSlug}";

                                                Provider.of<HomeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedProductSlug =
                                                    "${snapshot.data.response[0].product[index].productSlug}";
                                                Provider.of<HomeScreenProvider>(
                                                            context,
                                                            listen: false)
                                                        .selectedString =
                                                    "ProductInfo";
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 0,
                                                ),
                                                height: height / 3.5,
                                                width: width / 2.3,
                                                child: ProductBox(
                                                    expanded: true,
                                                    height: height,
                                                    width: width,
                                                    title:
                                                        "${snapshot.data.response[0].product[index].productName}",
                                                    image:
                                                        "${snapshot.data.response[0].product[index].productImg}",
                                                    description:
                                                        "${snapshot.data.response[0].product[index].vendorCompanyName}",
                                                    price: snapshot
                                                        .data
                                                        .response[0]
                                                        .product[index]
                                                        .productSalePrice,
                                                    stock:
                                                        "${snapshot.data.response[0].product[index].productStockStatus}",
                                                    discount:
                                                        "${snapshot.data.response[0].product[index].productDiscount}"),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Shop by Class"),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 15),
                                alignment: Alignment.centerLeft,
                                child: Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                    snapshot
                                        .data.response[0].responseClass.length,
                                    (index) => Consumer<CategoryProvider>(
                                      builder: (_, _categoryProvider, child) =>
                                          GestureDetector(
                                        onTap: () {
                                          _homeScreenProvider.selectedTitle =
                                              "${snapshot.data.response[0].responseClass[index].className}";

                                          /// set the selected class to filter....
                                          Provider.of<FilterCategoryProvider>(
                                                      context,
                                                      listen: false)
                                                  .selectedFilterCategoryClassSlug =
                                              snapshot
                                                  .data
                                                  .response[0]
                                                  .responseClass[index]
                                                  .classSlug;

                                          /// set filter class screen....
                                          Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedString = "FilterC";

                                          /// set the current selected index 0....
                                          Provider.of<HomeScreenProvider>(
                                                  context,
                                                  listen: false)
                                              .selectedBottomIndex = 0;
                                        },
                                        child: ClassButtons(
                                          "${snapshot.data.response[0].responseClass[index].className}",
                                          colorPalette.navyBlue,
                                          Color(0xff6A4B9C),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Shop by Subject"),
                                    Spacer(),
                                    ViewAll(onClick: () {
                                      /// set the subject list..
                                      Provider.of<FilterCategoryProvider>(
                                                  context,
                                                  listen: false)
                                              .allFilterSubjectsList =
                                          snapshot.data.response[0].subject;

                                      /// set the all subject screen string..
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedString = "AllSubjects";

                                      /// set the current index 0..
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedBottomIndex = 0;
                                    })
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 9,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: List.generate(
                                            snapshot.data.response[0].subject
                                                .length,
                                            (index) =>
                                                Consumer<CategoryProvider>(
                                                  builder: (_,
                                                          _categoryProvider,
                                                          child) =>
                                                      GestureDetector(
                                                    onTap: () {
                                                      _homeScreenProvider
                                                              .selectedTitle =
                                                          "${snapshot.data.response[0].subject[index].subjectName}";

                                                      /// set the subject slug..
                                                      Provider.of<FilterCategoryProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .selectedFilterCategorySubjectSlug =
                                                          snapshot
                                                              .data
                                                              .response[0]
                                                              .subject[index]
                                                              .subjectSlug;

                                                      /// set the subject list..
                                                      Provider.of<FilterCategoryProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .allFilterSubjectsList =
                                                          snapshot
                                                              .data
                                                              .response[0]
                                                              .subject;

                                                      /// set the filtersubject page string..
                                                      Provider.of<HomeScreenProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .selectedString =
                                                          "FilterS";

                                                      /// set the filter index to 0..
                                                      Provider.of<HomeScreenProvider>(
                                                              context,
                                                              listen: false)
                                                          .selectedBottomIndex = 0;
                                                    },
                                                    child: CategoryButtons(
                                                      "${snapshot.data.response[0].subject[index].subjectName}",
                                                      colorPalette.navyBlue,
                                                      Color(0xff6A4B9C),
                                                    ),
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Shop by School"),
                                    Spacer(),
                                    ViewAll(onClick: () {
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedString = "School";
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedBottomIndex = 2;
                                    })
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 5,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _homeScreenProvider.selectedTitle =
                                            "${snapshot.data.response[0].school[index].schoolName}";
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "SchoolInfo";
                                        Provider.of<SchoolProvider>(context,
                                                    listen: false)
                                                .selectedSchoolSlug =
                                            "${snapshot.data.response[0].school[index].schoolSlug}";
                                      },
                                      child: ImageBox(
                                          height: height,
                                          width: width,
                                          image:
                                              "${snapshot.data.response[0].school[index].schoolLogo}",
                                          title:
                                              "${snapshot.data.response[0].school[index].schoolName}"),
                                    );
                                  },
                                  itemCount:
                                      snapshot.data.response[0].school.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Shop by Publisher"),
                                    Spacer(),
                                    ViewAll(onClick: () {
                                      /// set the publisher list....
                                      Provider.of<FilterCategoryProvider>(
                                                  context,
                                                  listen: false)
                                              .allPublisherList =
                                          snapshot.data.response[0].publisher;

                                      /// set the current index 0....
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedBottomIndex = 0;

                                      /// set the selected String all publishers...
                                      Provider.of<HomeScreenProvider>(context,
                                              listen: false)
                                          .selectedString = "AllPublishers";
                                    })
                                  ],
                                ),
                              ),
                              Container(
                                height: height / 5,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        _homeScreenProvider.selectedTitle =
                                            "${snapshot.data.response[0].publisher[index].publisherName}";

                                        /// set the selected publisher slug....
                                        Provider.of<FilterCategoryProvider>(
                                                    context,
                                                    listen: false)
                                                .selectedFilterCategoryPublisherSlug =
                                            "${snapshot.data.response[0].publisher[index].publisherSlug}";

                                        /// set the publiser list...
                                        Provider.of<FilterCategoryProvider>(
                                                    context,
                                                    listen: false)
                                                .allPublisherList =
                                            snapshot.data.response[0].publisher;

                                        /// set the current index 0....
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedBottomIndex = 0;

                                        /// set the selected String all publishers...
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "FilterP";
                                      },
                                      child: ImageBox(
                                          height: height,
                                          width: width,
                                          image:
                                              "${snapshot.data.response[0].publisher[index].publisherImg}",
                                          title:
                                              "${snapshot.data.response[0].publisher[index].publisherName}"),
                                    );
                                  },
                                  itemCount: snapshot
                                      .data.response[0].publisher.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  children: [
                                    Header2("Top Vendors"),
                                    Spacer(),
                                    ViewAll(
                                      onClick: () {
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "Vendors";
                                      },
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 110),
                                height: height / 5,
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Provider.of<VendorProvider>(context,
                                                    listen: false)
                                                .selectedVendorName =
                                            "${snapshot.data.response[0].vendor[index].vendorSlug}";
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "VendorInfo";
                                      },
                                      child: ImageBox(
                                          height: height,
                                          width: width,
                                          image:
                                              "${snapshot.data.response[0].vendor[index].companyLogo}",
                                          title:
                                              "${snapshot.data.response[0].vendor[index].companyName}"),
                                    );
                                  },
                                  itemCount:
                                      snapshot.data.response[0].vendor.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  // snapshot.data.response[0].popupScreen[0].show == "1" &&
                  //         _homeScreenProvider.homeScreenMainPopupShow
                  //     ? Container(
                  //         color: Colors.black26,
                  //         alignment: Alignment.center,
                  //         child: Container(
                  //           height: 180,
                  //           width: MediaQuery.of(context).size.width - 90,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20.0),
                  //             color: Colors.white,
                  //           ),
                  //           padding: EdgeInsets.all(15.0),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Text(
                  //                 '${snapshot.data.response[0].popupScreen[0].title}',
                  //                 style: TextStyle(
                  //                   color: colorPalette.navyBlue,
                  //                   fontSize: 20.0,
                  //                   fontWeight: FontWeight.w900,
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 10.0,
                  //               ),
                  //               Text(
                  //                 '${snapshot.data.response[0].popupScreen[0].message}',
                  //                 style: TextStyle(
                  //                   color: colorPalette.navyBlue,
                  //                   fontSize: 17.0,
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //               ),
                  //               Spacer(),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.end,
                  //                 children: [
                  //                   RaisedButton(
                  //                     onPressed: () {
                  //                       _homeScreenProvider
                  //                           .homeScreenMainPopupShow = false;
                  //                     },
                  //                     child: Text(
                  //                       'OK',
                  //                       style: TextStyle(
                  //                           color: Colors.white,
                  //                           fontWeight: FontWeight.w900,
                  //                           fontSize: 16.0),
                  //                     ),
                  //                     color: colorPalette.navyBlue,
                  //                     shape: RoundedRectangleBorder(
                  //                         borderRadius:
                  //                             BorderRadius.circular(8.0)),
                  //                   )
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       )
                  //     : SizedBox()
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
      },
    );
  }
}
