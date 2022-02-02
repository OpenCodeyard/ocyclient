class ProjectModel {
  String name;
  String id;
  DateTime creationDate;
  String description;
  List<String>? contributorsImage;
  String repoUrl;
  int starCount, watchCount, activeIssuesCount, forkCount;

  setContributorsImage(List<String> urls) {
    contributorsImage = urls;
  }

  ProjectModel({
    required this.name,
    required this.id,
    required this.creationDate,
    required this.description,
    required this.repoUrl,
    required this.starCount,
    required this.watchCount,
    required this.activeIssuesCount,
    required this.forkCount,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> parsedJson) {
    return ProjectModel(
      id: parsedJson['id'].toString(),
      name: parsedJson['name'].toString(),
      creationDate: DateTime.parse(parsedJson['created_at'].toString()),
      description: parsedJson['description'].toString(),
      repoUrl: parsedJson['html_url'].toString(),
      activeIssuesCount: parsedJson['open_issues_count'],
      starCount: parsedJson['stargazers_count'],
      watchCount: parsedJson['watchers_count'],
      forkCount: parsedJson['forks_count'],
    );
  }
}
