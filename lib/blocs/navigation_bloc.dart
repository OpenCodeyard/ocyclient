import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';

class NavigationBloc extends ChangeNotifier {

  void toRoute(String s,{bool shouldPopCurrent = false}) {
    if(shouldPopCurrent) {
      Get.offAndToNamed(s);
    }else{
      Get.toNamed(s);
    }
  }

}
