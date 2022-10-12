import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ocyclient/models/localization/language.dart';

/// {@category Configs}
class Config {
  static final Map<String, String> _routeNames = {
    "home": "/home",
    // "Community": "/community",
    "about_us": "/about_us",
    "teams": "/teams",
    // "Milestones": "/milestones",
  };

  static Map<String, String> get routeNames => _routeNames;

  static final List<IconData> _appDrawerIcons = [
    LineIcons.home,
    LineIcons.globe,
    LineIcons.question,
    LineIcons.peopleCarry,
    Icons.emoji_events_outlined,
    Icons.logout_sharp,
  ];

  static final List<IconData> _selectedAppDrawerIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.earthAmericas,
    FontAwesomeIcons.question,
    FontAwesomeIcons.peopleCarryBox,
    FontAwesomeIcons.trophy,
    Icons.logout,
  ];

  static List<IconData> get appDrawerIcons => _appDrawerIcons;

  static List<IconData> get selectedAppDrawerIcons => _selectedAppDrawerIcons;

  ///GitHub Configs
  static const String clientId = "ba4e3c2ad6622ba3b12c";
  static const String clientSecret = "079b49d4b5ba6e84ad7ec4f4d4e90163c35c18ad";

  static const String redirectUrl =
      "https://opencodeyard.firebaseapp.com/__/auth/handler";

  ///Shared Preferences Keys
  static const String prefIsLoggedIn = "is_logged_in";
  static const String prefName = "name";
  static const String prefEmail = "email";
  static const String prefProfilePicUrl = "profile_pic_url";
  static const String prefUid = "uid";
  static const String prefGithubAccessToken = "user_github_access_token";
  static const String prefLoginProvidersConnected = "login_providers";
  static const String prefSkills = "skills";
  static const String prefPhone = "user_phone";
  static const String prefGender = "user_gender";
  static const String prefDOB = "user_dob";
  static const String prefBio = "user_bio";
  static const String prefEmploymentStatus = "employment_status";
  static const String prefLocality = "locality";

  ///Routes that should not be accessible to authenticated users
  static const List<String> authenticatedPreventAccessRoutes = ["/auth"];

  ///Routes that should not be accessible to unauthenticated users
  static const List<String> unauthenticatedPreventAccessRoutes = [
    "/profile",
    "/editProfile"
  ];

  static const appVersion = "0.3.1-alpha";

  ///Firestore Collection Names
  static const fsUser = "Users";

  ///Firestore field Names
  static const userUID = "uid";
  static const userName = "name";
  static const userEmail = "email";
  static const userProfilePic = "profilePic";
  static const userLoginProviders = "loginProviders";
  static const userGithubAccessToken = "accessTokenGithub";
  static const userSkills = "skills";
  static const userBio = "bio";
  static const userGender = "gender";
  static const userDob = "dob";
  static const userEmploymentStatus = "employment";
  static const userLocality = "locality";
  static const userPhone = "phone";

  ///Github api
  static const ghOrganisationName = "OpenCodeyard";
  static const ghRootUrl = "https://api.github.com/";
  static const ghOrganisationsApi = "orgs";
  static const ghReposApi = "repos";
  static const ghUserApi = "user";

  static const Color themeColor = Colors.deepPurple;

  static const String communityLogoPath = "assets/images/ocy_logo.png";

  ///Env names
  static const String envGhAccessToken = "github_access_token";

  ///Social
  static const String linkedInUrl =
      "https://www.linkedin.com/company/opencodeyard";
  static const String ghUrl = "https://github.com/OpenCodeyard";
  static const String telegramUrl = "https://telegram.me/Open_Codeyard";

  static const List<String> weAre = [
    "Coders 💻",
    "Students 🧑‍🎓",
    "Professionals 💼",
    "Dreamers 😴",
    "builders ⚒️",
    "Innovators 💡",
    "Gamers 🎮",
    "Hackers 🕶️",
    "Brain-Stormers 💡",
    "Techies 🧑‍💻",
    "Singers 👨‍🎤",
    "Dancers 🕺",
    "Open Codeyard ♥️",
  ];

  static const List<Color> weAreColors = [
    Color(0xfffa5457),
    Color(0xff01b4bc),
    Color(0xffe3c515),
    Color(0xffa59cd3),
    Color(0xff4b2d9f),
  ];

  static List<Language> languageList = [
    Language("English", "US", "en"),
    Language("বাংলা", "IN", "bn"),
  ];


}
