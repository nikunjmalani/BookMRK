import 'package:bookmrk/api/school_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget accessDialog({String schoolSlug}) {
  TextEditingController textEditingController = TextEditingController();
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: Get.width,
          height: 50,
          decoration: BoxDecoration(
              color: Color(0xff301869),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          child: Center(
            child: Text(
              'Access',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
                hintText: 'Enter registration code',
                border: OutlineInputBorder()),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  child: Text(
                    'Cancel',
                  )),
              FlatButton(
                  color: Color(0xff301869),
                  onPressed: () async {
                    if (textEditingController.text.isNotEmpty) {
                      bool status =await getSchoolAccess(
                          code: textEditingController.text,
                          schoolSlug: schoolSlug);
                      Get.back(result: status);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        )
      ],
    ),
  );
}

/// get all the list of school...
Future getSchoolAccess({String schoolSlug, String code}) async {
  dynamic responseAccess =
      await SchoolAPI.getSchoolAccess(schoolSlug: schoolSlug, code: code);
  print('response=>>${responseAccess}');
  if (responseAccess['status'] == 200) {
    return true;
  } else {
    Get.showSnackbar(GetBar(
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      message: '${responseAccess['message']}',
    ));
    await Future.delayed(Duration(seconds: 2));
    return false;
  }
  // SchoolListModel _schoolListModel = SchoolListModel.fromJson(schoolList);
  // return _schoolListModel;
}
