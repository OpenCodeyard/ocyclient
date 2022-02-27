import 'package:flutter/material.dart';
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

  ///TODO move to env
  static const String clientSecret = "079b49d4b5ba6e84ad7ec4f4d4e90163c35c18ad";

  ///TODO move to env
  static const String redirectUrl =
      "https://gceltopensource.firebaseapp.com/__/auth/handler";

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

  static const appVersion = "0.1.1-alpha";

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
  static const ghOrganisationName = "GCELTIANS2020";
  static const ghRootUrl = "https://api.github.com/";
  static const ghOrganisationsApi = "orgs";
  static const ghReposApi = "repos";
  static const ghUserApi = "user";

  static const Color themeColor = Colors.deepPurple;

  ///Curtain pics
  static final Map<String, dynamic> _curtainImagesLeft = {
    "Events": "assets/images/curtain_event.png",
    "SizedBox": 40,
    "Projects": "assets/images/curtain_project.png",
  };

  static final Map<String, dynamic> _curtainImagesRight = {
    "Learn": "assets/images/curtain_learn.png",
    "SizedBox": 40,
    "Grow": "assets/images/curtain_grow.png",
  };

  static Map<String, dynamic> get curtainImagesLeft => _curtainImagesLeft;

  static Map<String, dynamic> get curtainImagesRight => _curtainImagesRight;

  static const String communityLogoPath = "assets/images/animated_gos.gif";
}
