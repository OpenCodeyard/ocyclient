import 'package:flutter/cupertino.dart';
import 'package:line_icons/line_icons.dart';

class Config {
  static final Map<String, String> _routeNames = {
    "Home": "/home",
    "Community": "/community",
    "About Us": "/about_us",
    "Teams": "/teams",
    "Milestones": "/milestones",
  };

  static Map<String, String> get routeNames => _routeNames;

  static final List<IconData> _appDrawerIcons = [
    LineIcons.home,
    LineIcons.globe,
    LineIcons.question,
    LineIcons.layerGroup,
    LineIcons.trophy,
  ];

  static List<IconData> get appDrawerIcons => _appDrawerIcons;

  ///GitHub Configs
  static const String clientId = "ba4e3c2ad6622ba3b12c";
  static const String clientSecret = "079b49d4b5ba6e84ad7ec4f4d4e90163c35c18ad";
  static const String redirectUrl =
      "https://gceltopensource.firebaseapp.com/__/auth/handler";

  ///Shared Preferences Keys
  static const String prefIsLoggedIn = "is_logged_in";
  static const String prefName = "name";
  static const String prefEmail = "email";
  static const String prefProfilePicUrl = "profile_pic_url";
  static const String prefUid = "uid";
  static const String prefLoginProvidersConnected = "login_providers";

  ///Routes that should not be accessible to authenticated users
  static const List<String> authenticatedPreventAccessRoutes = ["/auth"];

  ///Routes that should not be accessible to unauthenticated users
  static const List<String> unauthenticatedPreventAccessRoutes = ["/profile"];

  static const appVersion = "0.0.4-alpha";

  ///Firestore Collection Names
  static const fsUser = "Users";

  ///Firestore field Names
  static const userUID = "uid";
  static const userName = "name";
  static const userEmail = "email";
  static const userProfilePic = "profilePic";
  static const userLoginProviders = "loginProviders";
  static const userGithubAccessToken = "accessTokenGithub";

  ///Github api
  static const ghOrganisationName = "GCELTIANS2020";
  static const ghRootUrl = "https://api.github.com/";
  static const ghOrganisationsApi = "orgs";
  static const ghReposApi = "repos";

}
