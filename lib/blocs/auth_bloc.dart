import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gosclient/blocs/navigation_bloc.dart';
import 'package:gosclient/configs/config.dart';
import 'package:gosclient/external/github_sign_in/lib/github_sign_in.dart';
import 'package:gosclient/widgets/Utils/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends ChangeNotifier {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  bool _isGithubSignInOngoing = false;

  bool get isGithubSignInOngoing => _isGithubSignInOngoing;

  bool _isGoogleSignInOngoing = false;

  bool get isGoogleSignInOngoing => _isGoogleSignInOngoing;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  List _loginProvidersConnected = [];

  List get loginProvidersConnected => _loginProvidersConnected;

  String? _uid;
  String? _email;
  String? _name;
  String? _profilePicUrl;
  String? _userGitHubAccessToken;

  String? get userGitHubAccessToken => _userGitHubAccessToken;

  String get uid => _uid ?? "";

  String get email => _email ?? "";

  String get name => _name ?? "";

  String get profilePicUrl => _profilePicUrl ?? "";

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  bool _isPrefsLoaded = false;

  bool get isPrefsLoaded => _isPrefsLoaded;

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
                .then((result) async {
              if (result.user != null) {
                User? user = result.user;
                _uid = user?.uid;
                _email = user?.email;
                _name = user?.displayName;
                _profilePicUrl = user?.photoURL;
                _isLoggedIn = true;
                _userGitHubAccessToken = accessToken;

                bool existingUser = (await FirebaseFirestore.instance
                        .collection(Config.fsUser)
                        .doc(uid)
                        .get())
                    .exists;

                if (!existingUser) {
                  await signUpUser(isGoogle: false);
                  _loginProvidersConnected = ["Github"];
                } else {
                  await fetchDataFromFirestore();
                }

                await savePrefs(List<String>.from(_loginProvidersConnected));
                toggleInProgressStatus(false);
                toggleGithubSignInStatus(false);
                nb.toRoute("/home");
              }
            });
          } else {
            _loginProvidersConnected.add("Github");
            _userGitHubAccessToken = accessToken;
            await updateLoginProviders(
              List<String>.from(loginProvidersConnected),
            );
            notifyListeners();
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
    _uid = prefs.getString(Config.prefUid);
    _email = prefs.getString(Config.prefEmail);
    _name = prefs.getString(Config.prefName);
    _profilePicUrl = prefs.getString(Config.prefProfilePicUrl);
    _loginProvidersConnected =
        prefs.getStringList(Config.prefLoginProvidersConnected) ?? [];
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
        _uid = user.uid;
        _name = user.displayName;
        _email = googleSignInAccount.email;
        _profilePicUrl = user.photoURL;
        _isLoggedIn = true;
        bool existingUser = (await FirebaseFirestore.instance
                .collection(Config.fsUser)
                .doc(uid)
                .get())
            .exists;

        if (!existingUser) {
          await signUpUser();
          _loginProvidersConnected = ["Google"];
        } else {
          await fetchDataFromFirestore();
        }

        await savePrefs(List<String>.from(_loginProvidersConnected));
        toggleInProgressStatus(false);
        toggleGoogleSignInStatus(false);
        nb.toRoute("/home");
      } else {
        toggleInProgressStatus(false);
        toggleGoogleSignInStatus(false);
        showToast(
          "There was problem logging you in. Please try again",
        );
      }
    } else {
      _loginProvidersConnected.add("Google");
      await updateLoginProviders(List<String>.from(loginProvidersConnected));
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
    prefs.clear();

    _uid = null;
    _name = null;
    _email = null;
    _profilePicUrl = null;
    _isLoggedIn = false;
    _userGitHubAccessToken = null;
    _loginProvidersConnected = [];

    if (ModalRoute.of(context)?.settings.name == "/profile") {
      nb.toRoute("/home");
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

    if (_userGitHubAccessToken != null) {
      map.putIfAbsent(
          Config.userGithubAccessToken, () => _userGitHubAccessToken);
    }
    await FirebaseFirestore.instance
        .collection(Config.fsUser)
        .doc(uid)
        .update(map);

    notifyListeners();
  }

  Future savePrefs(List<String> loginProviders) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Config.prefIsLoggedIn, true);
    prefs.setString(Config.prefEmail, _email ?? "");
    prefs.setString(Config.prefUid, _uid ?? "");
    prefs.setString(Config.prefName, _name ?? "");
    prefs.setString(Config.prefProfilePicUrl, _profilePicUrl ?? "");
    prefs.setStringList(Config.prefLoginProvidersConnected, loginProviders);
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
    await FirebaseFirestore.instance.collection(Config.fsUser).doc(uid).set({
      Config.userUID: uid,
      Config.userName: name,
      Config.userEmail: email,
      Config.userProfilePic: profilePicUrl,
      Config.userLoginProviders: isGoogle ? ["Google"] : ["Github"],
      Config.userGithubAccessToken: userGitHubAccessToken,
    });
  }

  Future fetchDataFromFirestore() async {
    await FirebaseFirestore.instance
        .collection(Config.fsUser)
        .doc(uid)
        .get()
        .then((value) {
      _uid = value[Config.userUID];
      _name = value[Config.userName];
      _email = value[Config.userEmail];
      _profilePicUrl = value[Config.userProfilePic];
      _loginProvidersConnected = value[Config.userLoginProviders];
      _userGitHubAccessToken = value[Config.userGithubAccessToken];
    });
  }
}
