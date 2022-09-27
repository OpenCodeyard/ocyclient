import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/models/team/team_model.dart';

class TeamCard extends StatefulWidget {
  final Size size;
  final String title;
  final List<Member> members;

  const TeamCard(
      {Key? key,
      required this.size,
      required this.title,
      required this.members})
      : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xff152839),
        child: ExpansionTile(
          initiallyExpanded: true,
          onExpansionChanged: (bool value) {
            setState(() {
              isExpanded = value;
            });
          },
          trailing: SizedBox(),
          title: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 20,
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 22,
                ),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: "PublicSans",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: widget.size.width > 1100
                        ? 40
                        : widget.size.width > 800
                            ? 30
                            : 18,
                  ),
                ),
                const Spacer(),
                Icon(
                  isExpanded
                      ? FontAwesomeIcons.circleMinus
                      : FontAwesomeIcons.circlePlus,
                  color: Colors.white,
                  size: 40,
                ),
                if (widget.size.width > 600)
                  const SizedBox(
                    width: 22,
                  ),
              ],
            ),
          ),
          children: [
            if (widget.members.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Member member = widget.members[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 45.0,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            member.image,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              member.name,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              member.title,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.members.length,
              )
            else
              const Text("No members found"),
          ],
        ),
      ),
    );
  }
}
