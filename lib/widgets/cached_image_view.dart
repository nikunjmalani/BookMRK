import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showCachedImage({String image, double height, String placeHolderImage}) {
  return CachedNetworkImage(
    imageUrl: image,
    height: height / 5.2,
    fit: BoxFit.fill,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
            ),
      ),
    ),
    placeholder: (context, url) => Center(child: Image.asset(placeHolderImage)),
    errorWidget: (context, url, error) =>
        Center(child: Image.asset(placeHolderImage)),
  );
}


/// mitul@gmail.com
/// mitul123123