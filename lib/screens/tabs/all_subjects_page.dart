import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:bookmrk/widgets/searchBar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllSubjects extends StatefulWidget {
  final List<Subject> subjects;

  const AllSubjects({this.subjects});
  @override
  _AllSubjectsState createState() => _AllSubjectsState();
}

class _AllSubjectsState extends State<AllSubjects> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Consumer<HomeScreenProvider>(
      builder: (context, data, child) {
        return Column(
          children: [
            SizedBox(height: 5.0),
            Expanded(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.subjects.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.3),
                itemBuilder: (context, index) {
                  return Consumer<CategoryProvider>(
                      builder: (_, _categoryProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            /// FilterSPC for filter category Subject, Publisher, Class wise....
                            data.selectedString = "FilterS";
                            data.selectedBottomIndex = 0;
                            Provider.of<FilterCategoryProvider>(context, listen: false).selectedFilterCategorySubjectSlug =
                                widget.subjects[index].subjectSlug;
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                '${widget.subjects[index].subjectImg}',
                                height: height / 5.2,
                                fit: BoxFit.fill,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      margin: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.fill,
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
                                            'assets/images/bookCategory.png'),
                                        fit: BoxFit.fill,
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
                                                'assets/images/bookCategory.png'),
                                            fit: BoxFit.fill,
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
                                  '${widget.subjects[index].subjectName}',
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
            )
          ],
        );
      },
    );
  }
}
