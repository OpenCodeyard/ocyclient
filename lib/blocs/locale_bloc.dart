import 'package:flutter/material.dart';
import 'package:ocyclient/models/localization/language.dart';

class LocaleBLoc extends ChangeNotifier {
  static const String english = "en";
  static const String bengali = "bn";

  Locale _currentLocale = const Locale(english, "US");

  Locale get currentLocale => _currentLocale;

  void changeLanguage(Language language, context) {
    Locale locale;
    switch (language.languageCode) {
      case english:
        locale = Locale(language.languageCode, "US");
        break;
      case bengali:
        locale = Locale(language.languageCode, "NP");
        break;
      default:
        locale = Locale(language.languageCode, 'US');
    }
    _currentLocale = locale;
    notifyListeners();
  }
}
