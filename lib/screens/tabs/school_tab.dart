import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/res/colorPalette.dart';
import 'package:bookmrk/widgets/textfields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SchoolTab extends StatefulWidget {
  @override
  _SchoolTabState createState() => _SchoolTabState();
}

class _SchoolTabState extends State<SchoolTab> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
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
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 110),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1.2),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Provider.of<HomeScreenProvider>(context, listen: false)
                            .selectedString = "SchoolInfo";
                      },
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image:
                                    AssetImage("assets/images/schoolImage.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.39),
                            ),
                            width: width,
                            child: Column(
                              children: [
                                Text(
                                  'Central Public School',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 17,
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                Text(
                                  'Adarsh Nagar, Lucknow, \n             457854',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    color: const Color(0xfff5f5f5),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
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
                                        color: const Color(0xffffffff),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    padding: EdgeInsets.only(left: 5, top: 3),
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
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
      },
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
