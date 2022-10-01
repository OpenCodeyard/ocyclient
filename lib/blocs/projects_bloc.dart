import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/models/project/project_model.dart';

/// {@category Blocs}
class ProjectsBloc extends ChangeNotifier {
  Dio dio = Dio();

  List<ProjectModel> _projects = [];

  List<ProjectModel> get projects => _projects;

  bool _isProjectsLoading = true;

  bool get isProjectsLoading => _isProjectsLoading;

  void getProjects() async {
    String? token = dotenv.env[Config.envGhAccessToken];

    dio.options.headers["Authorization"] = "token $token";
    dio.options.headers["accept"] = "application/vnd.github.v3+json";

    dio
        .get(
      "${Config.ghRootUrl}${Config.ghOrganisationsApi}/${Config.ghOrganisationName}/${Config.ghReposApi}",
    )
        .then((value) async {
      List<dynamic> projectsResponse = value.data;

      ///Running expensive function in a separate isolate
      _projects = await compute(parseResponseIntoList, projectsResponse);

      int i = 0;
      for (var project in projectsResponse) {
        ///Gets list of contributors for all projects
        var responseContributors = await dio.get(project["contributors_url"]);
        List<String> contributors = await compute(
          getImageUrls,
          responseContributors.data as List<dynamic>,
        );
        _projects[i].contributors = contributors;
        i++;
      }

      _isProjectsLoading = false;
      notifyListeners();
    });
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
    toBeReturned.add("${user["avatar_url"]}^${user["html_url"]}");
  }

  return toBeReturned;
}
