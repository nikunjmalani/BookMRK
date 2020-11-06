import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget SchoolImageBox({onTap, height, image, title, description}) {
  return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '$image',
            height: height / 4.8,
            fit: BoxFit.fill,
            imageBuilder: (context, imageProvider) => Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 7),
              height: height / 4.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 7),
              height: height / 4.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/preload.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 7),
              height: height / 4.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: AssetImage('assets/images/preload.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            height: height / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black.withOpacity(0.39)),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  height: 35.0,
                  child: Text(
                    description,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 15,
                      color: const Color(0xfff5f5f5),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.bottomRight,
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
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, top: 15),
          ),
        ],
      ));
}
