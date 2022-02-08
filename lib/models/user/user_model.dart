class UserModel {
  String uid;
  String email;
  String name;
  String profilePicUrl;
  String userGitHubAccessToken;
  List loginProvidersConnected = [];
  Map<String, dynamic> skills = {};
  String? bio;
  String? phoneNumber;
  String? dob;
  String? gender;
  String? employmentStatus;
  String? locality;

  UserModel(
    this.uid,
    this.email,
    this.name,
    this.profilePicUrl,
    this.userGitHubAccessToken,
    this.skills,
    this.loginProvidersConnected, {
    this.bio,
    this.phoneNumber,
    this.dob,
    this.gender,
    this.employmentStatus,
    this.locality,
  });
}
