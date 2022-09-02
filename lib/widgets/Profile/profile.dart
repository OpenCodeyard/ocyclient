import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oskclient/blocs/auth_bloc.dart';
import 'package:oskclient/blocs/navigation_bloc.dart';
import 'package:oskclient/blocs/profile_bloc.dart';
import 'package:oskclient/widgets/Profile/sub_pages/profile_user.dart';
import 'package:oskclient/widgets/Profile/widgets/skill_card.dart';
import 'package:oskclient/widgets/Utils/common_widgets.dart';
import 'package:oskclient/widgets/Utils/osk_scaffold.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ///TODO cover attribution <a href="https://www.freepik.com/vectors/background">Background vector created by freepik - www.freepik.com</a>

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ProfileBloc pb = Provider.of<ProfileBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return OskScaffold(
      body: SizedBox(
        height: size.height - 70,
        child: size.width < 1000
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: getProfileMenu(size, pb, ab, nb),
                          ),
                        ),
                      ),
                    ),
                    const UserTab(),
                  ],
                ),
              )
            : Row(
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      height: size.height,
                      width: 230,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        child: Column(
                          children: getProfileMenu(size, pb, ab, nb),
                        ),
                      ),
                    ),
                  ),
                  getVerticalDivider(),
                  const UserTab(),
                  getVerticalDivider(),
                  getSkillsCard(ab, size),
                ],
              ),
      ),
    );
  }

  Widget getVerticalDivider() {
    return const VerticalDivider(
      width: 1,
      color: Colors.black12,
    );
  }

  List<Widget> getProfileMenu(
    Size size,
    ProfileBloc pb,
    AuthenticationBloc ab,
    NavigationBloc nb,
  ) {
    bool isHorizontal = false;
    if (size.width < 1000) {
      isHorizontal = true;
    }
    return [
      getCustomSizedBoxForMenu(isHorizontal),
      if (!isHorizontal) ...[
        Image.asset(
          "assets/images/animated_gos.gif",
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 30,
        ),
      ],
      getSideMenuButton(
        pb,
        "User",
        FontAwesomeIcons.userAlt,
        0,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        pb,
        "My Events",
        FontAwesomeIcons.solidCalendarCheck,
        1,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        pb,
        "My Projects",
        FontAwesomeIcons.codeBranch,
        2,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        pb,
        "Log Out",
        FontAwesomeIcons.signOutAlt,
        3,
        isHorizontal,
        authBloc: ab,
        navBloc: nb,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
    ];
  }

  Widget getSideMenuButton(
    ProfileBloc pb,
    String title,
    IconData icon,
    int index,
    bool isHorizontal, {
    AuthenticationBloc? authBloc,
    NavigationBloc? navBloc,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (index == 3) {
            authBloc?.signOut(context, navBloc!);
          } else {
            pb.setCurrentSelectedItem(index);
          }
        },
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: pb.currentSelectedMenuItem == index
                ? const Color(0x73c6dbec)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          child: SizedBox(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: pb.currentSelectedMenuItem == index
                          ? Colors.black
                          : Colors.grey,
                      fontWeight: pb.currentSelectedMenuItem == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 14,
                      fontFamily: "Varela"),
                ),
                if (isHorizontal)
                  const SizedBox(
                    width: 20,
                  )
                else
                  const Spacer(),
                getIconForButton(icon),
                if (isHorizontal)
                  const SizedBox(
                    width: 10,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getCustomSizedBoxForMenu(bool isHorizontal) {
    return isHorizontal
        ? const SizedBox(
            width: 30,
          )
        : const SizedBox(
            height: 30,
          );
  }

  Widget getSkillsCard(AuthenticationBloc ab, Size size) {
    return Card(
      margin: EdgeInsets.zero,
      child: SizedBox(
        height: size.height,
        width: size.width - 232 - ((size.width - 231) * 0.8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Skills",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: "ProximaNova",
                ),
              ),
              if (ab.userModel.skills.isEmpty) ...[
                SizedBox(
                  height: size.height / 2 - 130,
                ),
                const Text(
                  "You haven't added any skills",
                  style: TextStyle(
                    fontFamily: "ProximaNova",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/add_skills.png",
                          width: 80,
                          height: 80,
                        ),
                        const Icon(
                          FontAwesomeIcons.plus,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ] else
                ...List.generate(
                  ab.userModel.skills.length,
                  (index) {
                    return SkillCard(
                      title: ab.userModel.skills.keys.toList()[index],
                      experience: ab.userModel.skills.values.toList()[index],
                      color: Colors.red,
                      icon: DevIcons.javaPlain,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
