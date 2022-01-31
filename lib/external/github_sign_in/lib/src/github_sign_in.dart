@JS()
library github_login;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:js/js.dart';
import 'package:js/js_util.dart';

import 'package:flutter/foundation.dart';

import 'github_sign_in_page.dart';
import 'github_sign_in_result.dart';

@JS()
external dynamic initLogin(ObjectYouWantToSend theObject);

@JS()
@anonymous
class ObjectYouWantToSend {
  external factory ObjectYouWantToSend({
    bool value,
  });

  external bool get value;
}

class GitHubSignIn {
  final String clientId;
  final String clientSecret;
  final String redirectUrl;
  final String scope;
  final String title;
  final bool? centerTitle;
  final bool allowSignUp;
  final bool clearCache;
  final String? userAgent;

  final String _githubAuthorizedUrl =
      "https://github.com/login/oauth/authorize";
  final String _githubAccessTokenUrl =
      "https://github.com/login/oauth/access_token";

  GitHubSignIn({
    required this.clientId,
    required this.clientSecret,
    required this.redirectUrl,
    this.scope = "user,gist,user:email",
    this.title = "",
    this.centerTitle,
    this.allowSignUp = true,
    this.clearCache = true,
    this.userAgent,
  });

  Future<GitHubSignInResult> signIn(
      BuildContext context, bool isLinkOperation) async {

    // let's authorize
    var authorizedResult;
    var cred;
    if (kIsWeb) {
      cred = await promiseToFuture(initLogin(ObjectYouWantToSend(
        value: isLinkOperation,
      )));
      //push data into authorized result somehow

    } else {
      authorizedResult = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => GitHubSignInPage(
            url: _generateAuthorizedUrl(),
            redirectUrl: redirectUrl,
            userAgent: userAgent,
            clearCache: clearCache,
            title: title,
            centerTitle: centerTitle,
          ),
        ),
      );
    }

    GitHubSignInResult result;
    if (!kIsWeb) {
      if (authorizedResult == null ||
          authorizedResult.toString().contains('access_denied')) {
        return GitHubSignInResult(
          GitHubSignInResultStatus.cancelled,
          errorMessage: "Sign In attempt has been cancelled.",
        );
      } else if (authorizedResult is Exception) {
        return GitHubSignInResult(
          GitHubSignInResultStatus.failed,
          errorMessage: authorizedResult.toString(),
        );
      }

      // exchange for access token
      String code = authorizedResult;
      var response = await http.post(
        Uri.parse(_githubAccessTokenUrl),
        headers: {"Accept": "application/json"},
        body: {
          "client_id": clientId,
          "client_secret": clientSecret,
          "code": code
        },
      );

      if (response.statusCode == 200) {
        var body = json.decode(utf8.decode(response.bodyBytes));
        result = GitHubSignInResult(
          GitHubSignInResultStatus.ok,
          token: body["access_token"],
        );
      } else {
        result = GitHubSignInResult(
          GitHubSignInResultStatus.cancelled,
          errorMessage:
              "Unable to obtain token. Received: ${response.statusCode}",
        );
      }
    } else {
      if (cred.toString().startsWith("error")) {
        result = GitHubSignInResult(
          GitHubSignInResultStatus.failed,
          errorMessage: cred.toString().split("error:")[1],
        );
      } else {
        result = GitHubSignInResult(
          GitHubSignInResultStatus.ok,
          token: cred.toString(),
        );
      }
    }
    return result;
  }

  String _generateAuthorizedUrl() {
    return "$_githubAuthorizedUrl?"
        "client_id=$clientId"
        "&redirect_uri=$redirectUrl"
        "&scope=$scope"
        "&allow_signup=$allowSignUp";
  }
}
