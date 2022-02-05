import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gosclient/blocs/auth_bloc.dart';
import 'package:gosclient/blocs/edit_profile_bloc.dart';
import 'package:gosclient/blocs/navigation_bloc.dart';
import 'package:gosclient/widgets/Profile/widgets/accounts.dart';
import 'package:gosclient/widgets/Utils/common_widgets.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  ///TODO cover attribution <a href="https://www.freepik.com/vectors/background">Background vector created by freepik - www.freepik.com</a>

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    EditProfileBloc epb = Provider.of<EditProfileBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return GosScaffold(
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
                            children: getEditProfileMenu(size, epb, ab, nb),
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 3 + 100,
                          width: size.width,
                        ),
                        Positioned(
                          top: 0,
                          left: 5,
                          right: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: getCoverPhoto(size),
                          ),
                        ),
                        Positioned(
                          child: getUserCircleAvatar(
                            ab,
                          ),
                          bottom: 10,
                        ),
                      ],
                    ),
                    ...getPrimaryDetails(ab),
                    const Padding(
                      padding: EdgeInsets.all(
                        13.0,
                      ),
                      child: AccountWidget(),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(23),
                      child: Text(
                        "Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 700 ? 25 : 40,
                          fontFamily: "ProximaNova",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        13.0,
                      ),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getIconifiedDetail(
                                ab.email.isEmpty ? "Not Provided" : ab.email,
                                FontAwesomeIcons.envelope,
                                Colors.red,
                                size.width - 107,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              getIconifiedDetail(
                                "Government College of Engineering and Leather Technology",
                                FontAwesomeIcons.university,
                                Colors.blue,
                                size.width - 107,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                          children: getEditProfileMenu(size, epb, ab, nb),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getCoverPhoto(size),
                                    Container(
                                      height: 100,
                                      margin: const EdgeInsets.fromLTRB(
                                          210, 10, 0, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: getPrimaryDetails(ab),
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
                                  child: getUserCircleAvatar(ab),
                                  bottom: 30,
                                  left: 30,
                                ),
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              getIconifiedDetail(
                                                ab.email.isEmpty
                                                    ? "Not Provided"
                                                    : ab.email,
                                                FontAwesomeIcons.envelope,
                                                Colors.red,
                                                200,
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              getIconifiedDetail(
                                                  "Government College of Engineering and Leather Technology",
                                                  FontAwesomeIcons.university,
                                                  Colors.blue,
                                                  200),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
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
                                        DevIcons.javaPlain,
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
                                        DevIcons.pythonPlain,
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
                                        DevIcons.cplusplusPlain,
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
                                        DevIcons.flutterPlain,
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
                                        DevIcons.javascriptPlain,
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

  List<Widget> getEditProfileMenu(
    Size size,
    EditProfileBloc epb,
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
        epb,
        "Personal",
        FontAwesomeIcons.userAlt,
        0,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
        "Education",
        FontAwesomeIcons.userGraduate,
        1,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
        "Experience",
        FontAwesomeIcons.briefcase,
        2,
        isHorizontal,
      ),
      getCustomSizedBoxForMenu(isHorizontal),
      getSideMenuButton(
        epb,
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
    EditProfileBloc pb,
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

  Widget getCoverPhoto(Size size) {
    return Card(
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
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(10),
          width: size.width < 1000 ? size.width : size.width - 231,
          height: size.height / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [],
          ),
        ),
      ),
    );
  }

  Widget getUserCircleAvatar(AuthenticationBloc ab) {
    return CircleAvatar(
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
    );
  }

  List<Widget> getPrimaryDetails(AuthenticationBloc ab) {
    return [
      Text(
        ab.name,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: "Varela",
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ];
  }

  Row getIconifiedDetail(
      String detail, IconData icon, Color iconColor, double width) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 18,
        ),
        const SizedBox(
          width: 15,
        ),
        SizedBox(
          width: width,
          child: Text(
            detail,
            style: const TextStyle(
              fontFamily: "Varela",
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}