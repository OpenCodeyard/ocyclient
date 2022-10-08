class Team {
  String id;
  String name;
  List<Member> members;

  // from json
  Team({
    required this.id,
    required this.name,
    required this.members,
  });

  static fromJson(json) {
    return Team(
      id: json["id"],
      name: json["name"],
      members: List<Member>.from(json["members"]
          .map(
            (json) => Member.fromJson(json),
          )
          .toList()),
    );
  }
}

class Member {
  String name;
  String title;
  String image;
  String? github;
  String? linkedIn;
  String? twitter;

  Member({
    required this.name,
    required this.title,
    required this.image,
    this.github,
    this.linkedIn,
    this.twitter,
  });

  static fromJson(json) {
    return Member(
      name: json["name"],
      image: json["image"],
      title: json["title"],
      github: json["github"],
      linkedIn: json["linkedIn"],
      twitter: json["twitter"],
    );
  }
}
