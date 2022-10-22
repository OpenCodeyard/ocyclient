import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/blocs/profile_bloc.dart';
import 'package:ocyclient/widgets/Profile/sub_pages/profile_user.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  ///TODO cover attribution <a href="https://www.freepik.com/vectors/background">Background vector created by freepik - www.freepik.com</a>

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    ProfileBloc pb = Provider.of<ProfileBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return OcyScaffold(
      body: SizedBox(
        height: size.height - 70,
        child: size.width < 1000
            ? SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
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
                        physics: const BouncingScrollPhysics(),
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
                  // getVerticalDivider(),
                  // Column(
                  //   children: [
                  //
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           margin: const EdgeInsets.all(10),
                  //           child: const Text(
                  //             "Details",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 40,
                  //               fontFamily: "PublicSans",
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 295,
                  //           margin: const EdgeInsets.all(10),
                  //           child: Card(
                  //             elevation: 10,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //             child: Container(
                  //               padding: const EdgeInsets.all(20),
                  //               child: Column(
                  //                 crossAxisAlignment:
                  //                 CrossAxisAlignment.center,
                  //                 children: [
                  //                   getIconifiedDetail(
                  //                     ab.userModel.email.isEmpty
                  //                         ? "Not Provided"
                  //                         : ab.userModel.email,
                  //                     FontAwesomeIcons.envelope,
                  //                     Colors.red,
                  //                     200,
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   getIconifiedDetail(
                  //                       "Government College of Engineering and Leather Technology",
                  //                       FontAwesomeIcons.buildingColumns,
                  //                       Colors.blue,
                  //                       200),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           margin: const EdgeInsets.all(10),
                  //           child: const Text(
                  //             "Details",
                  //             style: TextStyle(
                  //               fontWeight: FontWeight.bold,
                  //               fontSize: 40,
                  //               fontFamily: "PublicSans",
                  //             ),
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 260,
                  //           margin: const EdgeInsets.all(10),
                  //           child: Card(
                  //             elevation: 10,
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //             child: Container(
                  //               padding: const EdgeInsets.all(20),
                  //               child: Column(
                  //                 crossAxisAlignment:
                  //                 CrossAxisAlignment.center,
                  //                 children: [
                  //                   getIconifiedDetail(
                  //                     (ab.userModel.locality?.isEmpty ?? true)
                  //                         ? "Not Provided"
                  //                         : ab.userModel.locality ?? "",
                  //                     FontAwesomeIcons.locationDot,
                  //                     Colors.red,
                  //                     170,
                  //                   ),
                  //                   const SizedBox(
                  //                     height: 15,
                  //                   ),
                  //                   getIconifiedDetail(
                  //                       (ab.userModel.dob?.isEmpty ?? true)
                  //                           ? "Not Provided"
                  //                           : ab.userModel.dob ?? "",
                  //                       FontAwesomeIcons.calendarDays,
                  //                       Colors.blue,
                  //                       170),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
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
          "assets/images/ocy_logo.png",
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
        FontAwesomeIcons.userLarge,
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
        FontAwesomeIcons.rightFromBracket,
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
                      fontFamily: "PublicSans"),
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
}
