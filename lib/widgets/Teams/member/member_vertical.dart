import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/models/team/team_model.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MemberVertical extends StatelessWidget {
  final Member member;

  const MemberVertical({Key? key, required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 45.0,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  member.image,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                height: 140,
                width: 60,
                child: Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      if ((member.linkedIn ?? "").isNotEmpty)
                        getIconButton(
                          title: "",
                          func: () {
                            launchUrlString(member.linkedIn ?? "");
                          },
                          icon: FontAwesomeIcons.linkedinIn,
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      if ((member.github ?? "").isNotEmpty)
                        getIconButton(
                          title: "",
                          func: () {
                            launchUrlString(member.github ?? "");
                          },
                          icon: FontAwesomeIcons.github,
                        ),
                      if ((member.twitter ?? "").isNotEmpty)
                        getIconButton(
                          title: "",
                          func: () {
                            launchUrlString(member.twitter ?? "");
                          },
                          icon: FontAwesomeIcons.twitter,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          memberDetails(member),
        ],
      ),
    );
  }

  Widget memberDetails(Member member) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member.name,
          style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "PublicSans"),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          member.title,
          style: const TextStyle(
              fontSize: 17, color: Colors.white, fontFamily: "PublicSans"),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
