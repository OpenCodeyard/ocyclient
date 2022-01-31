import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends ChangeNotifier{

  bool _isLightTheme = true;

  bool get isLightTheme => _isLightTheme;

  ThemeBloc(){
    getThemeStatus();
  }

  changeThemeStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLightTheme = !value;
    prefs.setBool('theme', _isLightTheme);
    Get.changeThemeMode(_isLightTheme ? ThemeMode.light : ThemeMode.dark);
    notifyListeners();
  }

  getThemeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLightTheme = prefs.getBool('theme') ?? true;

    Get.changeThemeMode(_isLightTheme ? ThemeMode.light : ThemeMode.dark);
    notifyListeners();
  }

}