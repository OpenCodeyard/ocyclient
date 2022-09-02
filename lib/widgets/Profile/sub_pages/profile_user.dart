import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oskclient/blocs/auth_bloc.dart';
import 'package:oskclient/blocs/navigation_bloc.dart';
import 'package:oskclient/widgets/Profile/widgets/accounts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../../Utils/snackbar.dart';

class UserTab extends StatefulWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  _UserTabState createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return size.width < 1000
        ? Column(
            children: [
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
                          ab.userModel.email.isEmpty
                              ? "Not Provided"
                              : ab.userModel.email,
                          FontAwesomeIcons.envelope,
                          Colors.red,
                          size.width - 107,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        getIconifiedDetail(
                          "Government College of Engineering and Leather Technology",
                          FontAwesomeIcons.buildingColumns,
                          Colors.blue,
                          size.width - 107,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        : Card(
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
                            getCoverPhoto(size),
                            Container(
                              height: 100,
                              margin: const EdgeInsets.fromLTRB(210, 10, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    onPressed: () {
                                      nb.toRoute("/editProfile");
                                    },
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      getIconifiedDetail(
                                        ab.userModel.email.isEmpty
                                            ? "Not Provided"
                                            : ab.userModel.email,
                                        FontAwesomeIcons.envelope,
                                        Colors.red,
                                        200,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      getIconifiedDetail(
                                          "Government College of Engineering and Leather Technology",
                                          FontAwesomeIcons.buildingColumns,
                                          Colors.blue,
                                          200),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                              width: 260,
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
                                      getIconifiedDetail(
                                        (ab.userModel.locality?.isEmpty ?? true)
                                            ? "Not Provided"
                                            : ab.userModel.locality ?? "",
                                        FontAwesomeIcons.locationDot,
                                        Colors.red,
                                        170,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      getIconifiedDetail(
                                          (ab.userModel.dob?.isEmpty ?? true)
                                              ? "Not Provided"
                                              : ab.userModel.dob ?? "",
                                          FontAwesomeIcons.calendarAlt,
                                          Colors.blue,
                                          170),
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
        backgroundImage: ab.userModel.profilePicUrl.isEmpty
            ? null
            : NetworkImage(
                ab.userModel.profilePicUrl,
              ),
      ),
    );
  }

  List<Widget> getPrimaryDetails(AuthenticationBloc ab) {
    IconData? genderIcon = getIconFromGender(ab.userModel.gender);
    return [
      RichText(
        text: TextSpan(
          text: ab.userModel.name,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Varela",
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          children: [
            if (genderIcon != null)
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    genderIcon,
                    size: 25,
                  ),
                ),
              ),
          ],
        ),
      ),
      const SizedBox(
        height: 5,
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
                text: ab.userModel.uid,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: "Varela",
                ),
              ),
            ],
          ),
        ),
        onPressed: () {
          Clipboard.setData(
            ClipboardData(
              text: ab.userModel.uid,
            ),
          );

          showToast(
            "Uid copied to clipboard",
          );
        },
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

  IconData? getIconFromGender(String? gender) {
    if (gender == null) {
      return null;
    } else if (gender == "Male") {
      return FontAwesomeIcons.person;
    } else if (gender == "Female") {
      return FontAwesomeIcons.personDress;
    } else {
      return FontAwesomeIcons.transgender;
    }
  }
}
