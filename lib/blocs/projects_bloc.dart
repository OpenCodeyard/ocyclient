import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:oskclient/configs/config.dart';
import 'package:oskclient/models/project/project_model.dart';

class ProjectsBloc extends ChangeNotifier {
  Dio dio = Dio();

  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;

  bool _isProjectsLoading = true;

  bool get isProjectsLoading => _isProjectsLoading;

  void getProjects() async {
    String? token = dotenv.env["github_access_token"];

    dio.options.headers["Authorization"] = "token $token";
    dio.options.headers["accept"] = "application/vnd.github.v3+json";

    var response = await dio.get(
      Config.ghRootUrl +
          Config.ghOrganisationsApi +
          "/" +
          Config.ghOrganisationName +
          "/" +
          Config.ghReposApi,
    );

    List<dynamic> projectsResponse = response.data;

    ///Running expensive function in a separate isolate
    _projects = await compute(parseResponseIntoList, projectsResponse);

    int i = 0;
    for (var project in projectsResponse) {
      ///Gets list of contributors for all projects
      var responseContributors = await dio.get(project["contributors_url"]);
      List<String> contributorsImages = await compute(
          getImageUrls, responseContributors.data as List<dynamic>);
      _projects[i].contributorsImage = contributorsImages;
      i++;
    }

    _isProjectsLoading = false;
    notifyListeners();
  }
}

///Top level functions because it will be used in an isolate
///Warning : Putting it inside the class will cause error

List<ProjectModel> parseResponseIntoList(List<dynamic> projects) {
  return projects.map((data) => ProjectModel.fromJson(data)).toList();
}

List<String> getImageUrls(List<dynamic> users) {
  List<String> toBeReturned = [];
  for (var user in users) {
    toBeReturned.add(user["avatar_url"]);
  }

  return toBeReturned;
}
