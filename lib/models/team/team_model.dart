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

  Member({
    required this.name,
    required this.title,
    required this.image,
  });

  static fromJson(json) {
    return Member(
      name: json["name"],
      image: json["image"],
      title: json["title"],
    );
  }
}
