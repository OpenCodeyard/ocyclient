import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM_RIGHT,
    timeInSecForIosWeb: 2,
    webShowClose: true,
    webBgColor: "linear-gradient(60deg, #647DEE 12%, #7F53AC 100%)",
    webPosition: "left",
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
