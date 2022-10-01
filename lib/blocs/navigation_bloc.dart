import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

/// {@category Blocs}
class NavigationBloc extends ChangeNotifier {
  void toRoute(String s,
      {bool shouldPopCurrent = false, bool shouldPopAll = false}) {
    if (shouldPopAll) {
      Get.offAllNamed(s);
    } else if (shouldPopCurrent) {
      Get.offAndToNamed(s);
    } else {
      Get.toNamed(s);
    }
  }
}
