import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/external/github_sign_in/lib/github_sign_in.dart';
import 'package:ocyclient/models/user/user_model.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Business logic for authenticated users
class AuthenticationBloc extends ChangeNotifier {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isGithubSignInOngoing = false;

  bool get isGithubSignInOngoing => _isGithubSignInOngoing;

  bool _isGoogleSignInOngoing = false;

  bool get isGoogleSignInOngoing => _isGoogleSignInOngoing;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  UserModel _userModel = UserModel("", "", "", "", "", {}, []);

  UserModel get userModel => _userModel;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  bool _isPrefsLoaded = false;

  bool get isPrefsLoaded => _isPrefsLoaded;

  Dio dio = Dio();

  CollectionReference<Map<String, dynamic>> userCollectionRef =
      FirebaseFirestore.instance.collection(Config.fsUser);

  AuthenticationBloc() {
    fetchDataFromSharedPreferences();
  }

  Future authWithGithub(BuildContext context, NavigationBloc nb,
      bool isAccountLinkOperation) async {
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: Config.clientId,
      clientSecret: Config.clientSecret,
      redirectUrl: Config.redirectUrl,
      clearCache: false,
      allowSignUp: true,
    );

    toggleInProgressStatus(true);
    toggleGithubSignInStatus(true);

    GitHubSignInResult result = await gitHubSignIn.signIn(
      context,
      isAccountLinkOperation,
    );

    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        if (result.token != null) {
          String? accessToken = result.token;

          if (!isAccountLinkOperation) {
            auth
                .signInWithCredential(
                    GithubAuthProvider.credential(result.token ?? ""))
                .then((res) async {
              if (res.user != null) {
                dio.options.headers["Authorization"] = "token ${result.token}";
                dio.options.headers["accept"] =
                    "application/vnd.github.v3+json";

                var response =
                    await dio.get(Config.ghRootUrl + Config.ghUserApi);

                User? user = res.user;

                bool existingUser =
                    (await userCollectionRef.doc(user?.uid).get()).exists;

                if (!existingUser) {
                  _isLoggedIn = true;
                  _userModel = UserModel(
                    user?.uid ?? "",
                    response.data["email"],
                    user?.displayName ?? "",
                    user?.photoURL ?? "",
                    accessToken ?? "",
                    {},
                    ["Github"],
                  );
                  await signUpUser(isGoogle: false);
                } else {
                  await fetchDataFromFirestore(user?.uid ?? "");
                }

                await savePrefs();
                toggleInProgressStatus(false);
                toggleGithubSignInStatus(false);
                nb.toRoute(
                  "/home",
                  shouldPopCurrent: true,
                );
              }
            });
          } else {
            _userModel.loginProvidersConnected.add("Github");
            _userModel.userGitHubAccessToken = accessToken ?? "";
            await updateLoginProviders(
                List<String>.from(_userModel.loginProvidersConnected),
            );
            toggleInProgressStatus(false);
            toggleGoogleSignInStatus(false);
          }
        }
        break;

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        toggleInProgressStatus(false);
        toggleGithubSignInStatus(false);
        if (result.errorMessage.contains("An account already exists")) {
          showToast("Account already exists with Google");
        } else {
          showToast(result.errorMessage);
        }
        break;
    }
  }

  Future fetchDataFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(Config.prefIsLoggedIn) ?? false;

    List skillsList = prefs.getStringList(Config.prefSkills) ?? [];

    Map<String, dynamic> _skills = {};

    ///Traversing List to get all skills
    ///and store them in map
    for (String skill in skillsList) {
      String skillToStore = skill.split(":")[0];
      String experienceToStore = skill.split(":")[1];
      _skills[skillToStore] = experienceToStore;
    }

    String? dob = prefs.getString(Config.prefDOB);
    String? gender = prefs.getString(Config.prefGender);
    String? bio = prefs.getString(Config.prefBio);
    String? phone = prefs.getString(Config.prefPhone);
    String? employment = prefs.getString(Config.prefEmploymentStatus);
    String? locality = prefs.getString(Config.prefLocality);

    _userModel = UserModel(
      prefs.getString(Config.prefUid) ?? "",
      prefs.getString(Config.prefEmail) ?? "",
      prefs.getString(Config.prefName) ?? "",
      prefs.getString(Config.prefProfilePicUrl) ?? "",
      prefs.getString(Config.prefGithubAccessToken) ?? "",
      _skills,
      prefs.getStringList(Config.prefLoginProvidersConnected) ?? [],
      gender: (gender ?? "").isEmpty ? null : gender,
      dob: (dob ?? "").isEmpty ? null : dob,
      bio: (bio ?? "").isEmpty ? null : bio,
      phoneNumber: (phone ?? "").isEmpty ? null : phone,
      employmentStatus: (employment ?? "").isEmpty ? null : employment,
      locality: (locality ?? "").isEmpty ? null : locality,
    );

    _isPrefsLoaded = true;
    notifyListeners();
  }

  Future authWithGoogle(NavigationBloc nb, bool isAccountLinkOperation) async {
    GoogleSignInAccount? googleSignInAccount;
    try {
      toggleInProgressStatus(true);
      toggleGoogleSignInStatus(true);
      googleSignInAccount = await googleSignIn.signIn();
    } on PlatformException catch (e) {
      toggleInProgressStatus(false);
      toggleGoogleSignInStatus(false);
      if (e.code == GoogleSignIn.kSignInCanceledError ||
          e.code == "popup_closed_by_user") {
        showToast(
          "Sign In cancelled",
        );
      } else if (e.code == GoogleSignIn.kNetworkError) {
        showToast(
          "Network Error!",
        );
      } else {
        showToast(
          e.message ?? "Unknown. Contact Support",
        );
      }
    } catch (e) {
      toggleInProgressStatus(false);
      toggleGoogleSignInStatus(false);
      showToast(
        "Unknown. Contact Support",
      );
    }

    if (googleSignInAccount == null) {
      toggleInProgressStatus(false);
      toggleGoogleSignInStatus(false);
      showToast("Authentication failed");
      return;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    User? user;
    UserCredential? userCredential;
    try {
      if (!isAccountLinkOperation) {
        userCredential = await auth.signInWithCredential(credential);
      } else {
        userCredential = await auth.currentUser?.linkWithCredential(credential);
      }

      user = userCredential?.user;
    } catch (e) {
      toggleInProgressStatus(false);
      toggleGoogleSignInStatus(false);
      showToast(
        e.toString(),
      );
    }

    if (!isAccountLinkOperation) {
      if (user != null && userCredential != null) {
        _isLoggedIn = true;

        bool existingUser =
            (await userCollectionRef.doc(user.uid).get()).exists;

        if (!existingUser) {
          _userModel = UserModel(
            user.uid,
            googleSignInAccount.email,
            user.displayName ?? "",
            user.photoURL ?? "",
            "",
            {},
            ["Google"],
          );
          await signUpUser();
        } else {
          await fetchDataFromFirestore(user.uid);
        }

        await savePrefs();

        toggleInProgressStatus(false);
        toggleGoogleSignInStatus(false);
        nb.toRoute(
          "/home",
          shouldPopCurrent: true,
        );
      } else {
        toggleInProgressStatus(false);
        toggleGoogleSignInStatus(false);
        showToast(
          "There was problem logging you in. Please try again",
        );
      }
    } else {
      _userModel.loginProvidersConnected.add("Google");
      await updateLoginProviders(
          List<String>.from(_userModel.loginProvidersConnected),
      );
      toggleInProgressStatus(false);
      toggleGoogleSignInStatus(false);
    }
  }

  Future signOut(BuildContext context, NavigationBloc nb) async {
    try {
      await googleSignIn.signOut();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    await auth.signOut();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _userModel = UserModel("", "", "", "", "", {}, []);
    _isLoggedIn = false;

    if (Config.unauthenticatedPreventAccessRoutes
        .contains(ModalRoute.of(context)?.settings.name)) {
      nb.toRoute(
        "/home",
        shouldPopAll: true,
      );
    }
    notifyListeners();
  }

  Future updateLoginProviders(
    List<String> loginProviders,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(Config.prefLoginProvidersConnected, loginProviders);
    Map<String, dynamic> map = {
      Config.userLoginProviders: loginProviders,
    };

    if (_userModel.userGitHubAccessToken.isNotEmpty) {
      map.putIfAbsent(
          Config.userGithubAccessToken, () => _userModel.userGitHubAccessToken);
    }
    await userCollectionRef.doc(_userModel.uid).update(map);

    notifyListeners();
  }

  Future savePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Config.prefIsLoggedIn, true);
    prefs.setString(Config.prefEmail, _userModel.email);
    prefs.setString(Config.prefUid, _userModel.uid);
    prefs.setString(Config.prefName, _userModel.name);
    prefs.setString(Config.prefProfilePicUrl, _userModel.profilePicUrl);
    prefs.setStringList(
      Config.prefLoginProvidersConnected,
      List<String>.from(_userModel.loginProvidersConnected),
    );
    prefs.setString(
      Config.prefGithubAccessToken,
      _userModel.userGitHubAccessToken,
    );
    prefs.setString(Config.prefPhone, _userModel.phoneNumber ?? "");
    prefs.setString(Config.prefGender, _userModel.gender ?? "");
    prefs.setString(Config.prefDOB, _userModel.dob ?? "");
    prefs.setString(Config.prefBio, _userModel.bio ?? "");
    prefs.setString(
        Config.prefEmploymentStatus, _userModel.employmentStatus ?? "");
    prefs.setString(Config.prefLocality, _userModel.locality ?? "");

    List<String> skillsList = [];

    ///Traversing map to get all skills
    ///and store them in format [skill]:[experience]
    ///Shared Preferences doesn't support storing map
    ///and thus this is done
    for (String skill in (_userModel.skills).keys) {
      skillsList.add("$skill:${_userModel.skills[skill]}");
    }

    prefs.setStringList(Config.prefSkills, skillsList);
  }

  void toggleInProgressStatus(bool status) {
    _inProgress = status;
  }

  void toggleGithubSignInStatus(bool status) {
    _isGithubSignInOngoing = status;
    notifyListeners();
  }

  void toggleGoogleSignInStatus(bool status) {
    _isGoogleSignInOngoing = status;
    notifyListeners();
  }

  Future signUpUser({
    bool isGoogle = true,
  }) async {
    await userCollectionRef.doc(_userModel.uid).set({
      Config.userUID: _userModel.uid,
      Config.userName: _userModel.name,
      Config.userEmail: _userModel.email,
      Config.userProfilePic: _userModel.profilePicUrl,
      Config.userLoginProviders: isGoogle ? ["Google"] : ["Github"],
      Config.userGithubAccessToken: _userModel.userGitHubAccessToken,
    });
  }

  Future fetchDataFromFirestore(String uid) async {
    await userCollectionRef.doc(uid).get().then((value) {
      Map<String, dynamic>? data = value.data();
      if (data != null) {
        _userModel = UserModel(
          data[Config.userUID],
          data[Config.userEmail],
          data[Config.userName],
          data[Config.userProfilePic],
          data[Config.userGithubAccessToken] ?? "",
          data[Config.userSkills] ?? {},
          data[Config.userLoginProviders],
          bio: data[Config.userBio],
          phoneNumber: data[Config.userPhone],
          dob: data[Config.userDob],
          gender: data[Config.userGender],
          employmentStatus: data[Config.userEmploymentStatus],
          locality: data[Config.userLocality],
        );
        _isLoggedIn = true;
      }
    });
  }

  Future updateSkills(Map<String, dynamic> newSkills) async {
    for (String newSkill in newSkills.keys) {
      _userModel.skills.putIfAbsent(newSkill, () => newSkills[newSkill]);
    }

    await userCollectionRef.doc(_userModel.uid).update({
      Config.userSkills: _userModel.skills,
    });

    await savePrefs();
    notifyListeners();
  }

  Future updatePersonal(Map<String, dynamic> data) async {
    await userCollectionRef.doc(_userModel.uid).update(data);

    _userModel.gender = data[Config.userGender];
    _userModel.bio = data[Config.userBio];
    _userModel.phoneNumber = data[Config.userPhone];
    _userModel.dob = data[Config.userDob];
    _userModel.employmentStatus = data[Config.userEmploymentStatus];
    _userModel.locality = data[Config.userLocality];

    await savePrefs();
    notifyListeners();
  }
}
