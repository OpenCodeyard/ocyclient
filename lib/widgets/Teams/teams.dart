import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocyclient/blocs/teams_bloc.dart';
import 'package:ocyclient/models/team/team_model.dart';
import 'package:ocyclient/widgets/Teams/team_card.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:provider/provider.dart';

class TeamsPage extends StatefulWidget {
  const TeamsPage({Key? key}) : super(key: key);

  @override
  State<TeamsPage> createState() => _TeamsPageState();
}

class _TeamsPageState extends State<TeamsPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Teams 🏘️',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    Size size = MediaQuery.of(context).size;

    TeamsBloc tb = Provider.of<TeamsBloc>(context);

    return OcyScaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.width < 650 ? size.height / 2 : size.height,
                width: size.width,
                padding: EdgeInsets.only(left: size.width * 0.1),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.imgur.com/SHXoCoG.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Color(0xff071a2b),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    SizedBox(
                      width: size.width / (size.width > 550 ? 2 : 1),
                      child: Text(
                        "Teams are\nour pillars".toUpperCase(),
                        style: TextStyle(
                          fontFamily: "PublicSans",
                          fontWeight: FontWeight.w700,
                          fontSize: size.width > 1100
                              ? 100
                              : size.width > 800
                                  ? 60
                                  : 40,
                          foreground: Paint()
                            ..strokeWidth = 2
                            ..style = PaintingStyle.stroke
                            ..color = Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: size.width / (size.width > 450 ? 2.4 : 1.2),
                      child: Text(
                        "If you believe in diversity, we believe you'll fit right in."
                        " Be a part of something refreshing and revolutionary. "
                        "Check out available roles below ",
                        style: TextStyle(
                          fontFamily: "PublicSans",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: size.width > 1100
                              ? 25
                              : size.width > 650
                                  ? 20
                                  : 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xff071a2b),
                ),
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width > 800 ? 100 : 15,
                        ),
                        child: size.width > 800
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    children: "TEAMS"
                                        .split("")
                                        .map((string) => Text(
                                              string,
                                              style: TextStyle(
                                                fontFamily: "PublicSans",
                                                fontWeight: FontWeight.bold,
                                                fontSize: size.width > 1100
                                                    ? 140
                                                    : 80,
                                                letterSpacing: 5,
                                                foreground: Paint()
                                                  ..strokeWidth = 1
                                                  ..style = PaintingStyle.stroke
                                                  ..color =
                                                      const Color(0xff8aafcc),
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Expanded(
                                    child: getTeams(size, tb),
                                  ),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    "TEAMS",
                                    style: TextStyle(
                                      fontFamily: "PublicSans",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 60,
                                      letterSpacing: 5,
                                      foreground: Paint()
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.stroke
                                        ..color = const Color(0xff8aafcc),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  getTeams(size, tb),
                                ],
                              ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getTeams(Size size, TeamsBloc tb) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: tb.teams.length,
      itemBuilder: (context, index) {
        Team t = tb.teams[index];
        return TeamCard(
          size: size,
          title: t.name,
          members: t.members,
        );
      },
    );
  }
}
