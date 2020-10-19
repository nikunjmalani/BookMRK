import 'package:bookmrk/api/home_page_api.dart';
import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/provider/vendor_provider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/res/images.dart';
import 'package:bookmrk/widgets/buttons.dart';
import 'package:bookmrk/widgets/cached_image_view.dart';
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
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        height: height / 2.3,
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Color(0xffcfcfcf),
                          ),
                        ),
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                    snapshot.data.response[0].category.length,
                                    (index) => Consumer<CategoryProvider>(
                                          builder:
                                              (_, _categoryProvider, child) =>
                                                  GestureDetector(
                                            onTap: () {
                                              /// category_slug is required, but api response do not contain category_slug...
                                              Provider.of<HomeScreenProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedString =
                                                  "CategoryInfo";
                                              _categoryProvider
                                                      .selectedCategoryName =
                                                  snapshot.data.response[0]
                                                      .category[index].catSlug;
                                            },
                                            child: CategoryButtons(
                                              width,
                                              "${snapshot.data.response[0].category[index].categoryName}",
                                              colorPalette.navyBlue,
                                              Color(0xff6A4B9C),
                                            ),
                                          ),
                                        )),
                              ),
                            ),
                            Container(
                              height: height / 3.2,
                              child: ListView.builder(
                                itemCount:
                                    snapshot.data.response[0].product.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Consumer<VendorProvider>(
                                    builder: (_, _vendorProvider, child) =>
                                        GestureDetector(
                                      onTap: () {
                                        print(
                                            '${snapshot.data.response[0].product[index].productSlug}');
                                        _vendorProvider.selectedVendorName =
                                            "${snapshot.data.response[0].product[index].vendorSlug}";
                                        Provider.of<HomeScreenProvider>(context,
                                                    listen: false)
                                                .selectedProductSlug =
                                            "${snapshot.data.response[0].product[index].productSlug}";
                                        Provider.of<HomeScreenProvider>(context,
                                                listen: false)
                                            .selectedString = "ProductInfo";
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 20, left: 10, right: 10),
                                        height: height / 3.8,
                                        width: width / 2.8,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color(0xffcfcfcf),
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              child: showCachedImage(
                                                image:
                                                    '${snapshot.data.response[0].product[index].productImg}',
                                                height: height,
                                                placeHolderImage:
                                                    'assets/images/book.png',
                                              ),
                                              height: height / 5.6,
                                              padding: EdgeInsets.only(top: 15),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              width: width * 0.5,
                                              child: Text(
                                                '${snapshot.data.response[0].product[index].productName}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff000000),
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              child: Text(
                                                '${snapshot.data.response[0].product[index].vendorCompanyName}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Roboto',
                                                  fontSize: 12,
                                                  color:
                                                      const Color(0xff777777),
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  left: 5, right: 5),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 3,
                                                left: 5,
                                                right: 5,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    height: 15,
                                                    width: 50,
                                                    decoration: BoxDecoration(
                                                      color: colorPalette
                                                          .pinkOrange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    child: Text(
                                                      '${snapshot.data.response[0].product[index].productStockStatus} Stock',
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: 10,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                  Text(
                                                    '₹ ${snapshot.data.response[0].product[index].productSalePrice}',
                                                    style: TextStyle(
                                                      fontFamily: 'Roboto',
                                                      fontSize: 10,
                                                      color: const Color(
                                                          0xff515c6f),
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                /// school info require school slug, and here, we are not getting school slug
                                /// so do not redirect to schoolInfo page from home page...
//                                Provider.of<HomeScreenProvider>(context,
//                                        listen: false)
//                                    .selectedString = "SchoolInfo";
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
                          itemCount: snapshot.data.response[0].school.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                          itemBuilder: (context, index) {
                            return ImageBox(
                                height: height,
                                width: width,
                                image:
                                    "${snapshot.data.response[0].vendor[index].companyLogo}",
                                title:
                                    "${snapshot.data.response[0].vendor[index].companyName}");
                          },
                          itemCount: snapshot.data.response[0].vendor.length,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ],
                  ),
                ),
              )
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
      },
    );
  }
}
