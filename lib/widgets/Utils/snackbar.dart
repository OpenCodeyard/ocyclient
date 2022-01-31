import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM_RIGHT,
      timeInSecForIosWeb: 2,
      webShowClose: true,
      webBgColor: "linear-gradient(120deg, #f093fb 0%, #f5576c 100%)",
      webPosition: "right",
      // backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
