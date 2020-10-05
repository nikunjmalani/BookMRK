import 'package:bookmrk/res/colorPalette.dart';
import 'package:flutter/material.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  ColorPalette colorPalette = ColorPalette();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                height: width / 2,
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
                      padding:
                          const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: Text(
                        'Books',
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
                      child: ListView.builder(
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Guide ',
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16,
                                    color: const Color(0xff000000),
                                    letterSpacing: 0.9100000000000001,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                index == 0 && i == 0
                                    ? Icon(
                                        Icons.check,
                                        color: colorPalette.navyBlue,
                                      )
                                    : SizedBox()
                              ],
                            ),
                          );
                        },
                        itemCount: 6,
                      ),
                      height: width / 2.8,
                    )
                  ],
                ),
              );
            },
            itemCount: 3,
          ),
        )
      ],
    );
  }
}
