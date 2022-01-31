import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_devicon/flutter_devicon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gosclient/blocs/auth_bloc.dart';
import 'package:gosclient/blocs/navigation_bloc.dart';
import 'package:gosclient/blocs/profile_bloc.dart';
import 'package:gosclient/widgets/Profile/widgets/accounts.dart';
import 'package:gosclient/widgets/Utils/common_widgets.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';
import 'package:gosclient/widgets/Utils/snackbar.dart';
import 'package:line_icons/line_icons.dart';
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

    return GosScaffold(
      body: SizedBox(
        height: size.height - 70,
        child: Row(
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
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/images/animated_gos.gif",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      getSideMenuButton(
                        pb,
                        "User",
                        FontAwesomeIcons.userAlt,
                        0,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      getSideMenuButton(
                        pb,
                        "My Events",
                        FontAwesomeIcons.solidCalendarCheck,
                        1,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      getSideMenuButton(
                        pb,
                        "My Projects",
                        FontAwesomeIcons.codeBranch,
                        2,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      getSideMenuButton(
                        pb,
                        "Log Out",
                        FontAwesomeIcons.signOutAlt,
                        3,
                        authBloc: ab,
                        navBloc: nb,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: Colors.black12,
            ),
            Card(
              margin: EdgeInsets.zero,
              child: SizedBox(
                height: size.height,
                width: (size.width - 231) * 0.8,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                // color: const Color(0xffe9f3fd),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xffe6f6f4),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              "https://image.freepik.com/free-vector/gradient-hexagonal-background_23-2148947773.jpg"),
                                          fit: BoxFit.cover),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    width: size.width - 231,
                                    height: size.height / 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                margin:
                                    const EdgeInsets.fromLTRB(210, 10, 0, 0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ab.name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Varela",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        TextButton.icon(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                            ),
                                          ),
                                          label: const Icon(
                                            FontAwesomeIcons.copy,
                                            size: 15,
                                          ),
                                          icon: RichText(
                                            text: TextSpan(
                                                text: "uid : ",
                                                style: const TextStyle(
                                                  fontFamily: "Varela",
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: ab.uid,
                                                    style: const TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontFamily: "Varela",
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                          onPressed: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text: ab.uid,
                                              ),
                                            );

                                            showToast(
                                              "Uid copied to clipboard",
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        elevation: 15,
                                        padding: const EdgeInsets.all(16),
                                      ),
                                      onPressed: () {},
                                      icon: const Icon(
                                        LineIcons.userEdit,
                                        size: 15,
                                      ),
                                      label: const Text("Edit Profile"),
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Positioned(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 85.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 80,
                                backgroundImage: ab.profilePicUrl.isEmpty
                                    ? null
                                    : NetworkImage(
                                        ab.profilePicUrl,
                                      ),
                              ),
                            ),
                            bottom: 30,
                            left: 30,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AccountWidget(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Details",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    fontFamily: "ProximaNova",
                                  ),
                                ),
                              ),
                              Container(
                                width: 295,
                                margin: const EdgeInsets.all(10),
                                child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.envelope,
                                              color: Colors.red,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              ab.email.isEmpty
                                                  ? "Not Provided"
                                                  : ab.email,
                                              style: const TextStyle(
                                                fontFamily: "Varela",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              FontAwesomeIcons.university,
                                              color: Colors.blue,
                                              size: 18,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                ab.email.isEmpty
                                                    ? "Government College of Engineering and Leather Technology"
                                                    : ab.email,
                                                style: const TextStyle(
                                                  fontFamily: "Varela",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: Colors.black12,
            ),
            Card(
              margin: EdgeInsets.zero,
              child: SizedBox(
                height: size.height,
                width: size.width - 232 - ((size.width - 231) * 0.8),
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      const SizedBox(
                        height: 30,
                      ),
                      Card(
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FlutterDEVICON.java_plain,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Java",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FlutterDEVICON.python_plain,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Python",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FlutterDEVICON.cplusplus_plain,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "C++",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FlutterDEVICON.flutter_plain,
                                  color: Colors.blue,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "Dart",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Card(
                        color: Colors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            children: const [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  FlutterDEVICON.javascript_plain,
                                  color: Colors.yellow,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                "JS",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getSideMenuButton(
    ProfileBloc pb,
    String title,
    IconData icon,
    int index, {
    AuthenticationBloc? authBloc,
    NavigationBloc? navBloc,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          pb.setCurrentSelectedItem(index);
          if (index == 3) {
            authBloc?.signOut(context, navBloc!);
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
              const Spacer(),
              getIconForButton(icon),
            ],
          ),
        ),
      ),
    );
  }
}
