import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "home": "Home",
          "about_us": "About Us",
          "teams": "Teams",
        },
        'bn_IN': {
          "home": "ঘর",
          "about_us": "আমাদের সম্পর্কে",
          "teams": "দল",
        },
        'hn_IN': {
          "home": "घर",
          "about_us": "हमारे बारे में",
          "teams": "दल",
        },
        'mt_IN':{
          "home":"मुख्यपृष्ठ",
          "about_us":"आमच्या_बद्दल",
          "teams":"संघ"
        }
      };
}
