import 'package:bookmrk/model/home_page_model.dart';
import 'package:bookmrk/provider/category_provider.dart';
import 'package:bookmrk/provider/filter_category_provider.dart';
import 'package:bookmrk/provider/homeScreenProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllPublisher extends StatefulWidget {
  final List<Publisher> publisher;

  const AllPublisher({this.publisher});
  @override
  _AllPublisherState createState() => _AllPublisherState();
}

class _AllPublisherState extends State<AllPublisher> {

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
                itemCount: widget.publisher.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2.3),
                itemBuilder: (context, index) {
                  return Consumer<CategoryProvider>(
                      builder: (_, _categoryProvider, child) {
                        return GestureDetector(
                          onTap: () {
                            /// FilterSPC for filter category Subject, Publisher, Class wise....
                            data.selectedString = "FilterP";
                            data.selectedBottomIndex = 0;
                            Provider.of<FilterCategoryProvider>(context, listen: false).selectedFilterCategoryPublisherSlug =
                                widget.publisher[index].publisherSlug;
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                '${widget.publisher[index].publisherImg}',
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
                                            'assets/images/preload.png'),
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
                                                'assets/images/preload.png'),
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
                                  '${widget.publisher[index].publisherName}',
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
