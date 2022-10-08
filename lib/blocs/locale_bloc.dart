import 'package:flutter/material.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/models/localization/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleBLoc extends ChangeNotifier {
  static const String english = "en";
  static const String bengali = "bn";

  late Locale _currentLocale;

  Locale get currentLocale => _currentLocale;

  LocaleBLoc(GlobalKey<NavigatorState> navigatorKey) {
    loadLocale(navigatorKey);
  }

  void changeLanguage(Language language, context) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    Locale locale;
    switch (language.languageCode) {
      case english:
        locale = Locale(language.languageCode, "US");
        break;
      case bengali:
        locale = Locale(language.languageCode, "IN");
        break;
      default:
        locale = Locale(language.languageCode, 'US');
    }
    _currentLocale = locale;
    notifyListeners();

    sp.setString("currentLanguageName", getCurrentSelectedLanguage().name);
    sp.setString("currentLanguageCode", _currentLocale.languageCode);
    sp.setString(
        "currentLanguageCountryCode", _currentLocale.countryCode ?? "NULL");
  }

  Language getCurrentSelectedLanguage() {
    for (Language l in Config.languageList) {
      if ((currentLocale.countryCode ?? "") == l.countryCode) {
        if (currentLocale.languageCode == l.languageCode) {
          return l;
        }
      } else if (currentLocale.countryCode == null && l.countryCode == "") {
        if (currentLocale.languageCode == l.languageCode) {
          return l;
        }
      }
    }

    return Language("English", "US", "en");
  }

  void loadLocale(GlobalKey<NavigatorState> navigatorKey) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String? countryCode = sp.getString("currentLanguageCountryCode");
    String? langCode = sp.getString("currentLanguageCode") ?? "en";

    if (countryCode == "NULL" || countryCode == null) {
      countryCode = "US";
    }

    _currentLocale = Locale(
      langCode,
      countryCode,
    );

    changeLanguage(
      Language(
        sp.getString("currentLanguageName") ?? "English",
        countryCode,
        langCode,
      ),
      navigatorKey.currentContext,
    );

  }
}
