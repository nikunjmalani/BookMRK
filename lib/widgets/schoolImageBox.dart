import 'package:flutter/material.dart';

Widget SchoolImageBox({onTap, height, image, title, description}) {
  return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            height: height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image:
                      image != null ? NetworkImage(image) : AssetImage(image),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 7),
            height: height / 6,
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
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 15,
                    color: const Color(0xfff5f5f5),
                  ),
                ),
                SizedBox(
                  height: height / 30,
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
