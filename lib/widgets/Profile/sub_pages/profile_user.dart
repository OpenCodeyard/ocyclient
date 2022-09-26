import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/widgets/Profile/widgets/accounts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Utils/snackbar.dart';

class UserTab extends StatefulWidget {
  const UserTab({Key? key}) : super(key: key);

  @override
  UserTabState createState() => UserTabState();
}

class UserTabState extends State<UserTab> {
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
                    bottom: 10,
                    child: getUserCircleAvatar(ab),
                  ),
                ],
              ),
              ...getPrimaryDetails(
                ab,
                nb,
                showEditIconBesideName: true,
              ),
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
                    fontFamily: "PublicSans",
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
        : SizedBox(
            height: size.height,
            width: (size.width - 231),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: getPrimaryDetails(ab, nb),
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
                        bottom: 30,
                        left: 30,
                        child: getUserCircleAvatar(ab),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: (size.width - 231),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AccountWidget(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                child: const Text(
                                  "Bio",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                    fontFamily: "PublicSans",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 160,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: Markdown(
                                      onTapLink:
                                          (String text, String? url, String title) {
                                        if (url != null) {
                                          launchUrlString(
                                            url,
                                            mode:
                                                LaunchMode.externalApplication
                                          );
                                        } else {
                                          showToast("Invalid URL");
                                        }
                                      },
                                      physics: const BouncingScrollPhysics(),
                                      imageBuilder: (Uri u, String? b, String? c){
                                        return Image.network(u.toString());
                                      },
                                      data: ab.userModel.bio ??
                                          "# Bio not provided",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                "https://i.imgur.com/9NDKz2U.jpg",
              ),
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
      radius: 75.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 70,
        backgroundImage: ab.userModel.profilePicUrl.isEmpty
            ? null
            : NetworkImage(
                ab.userModel.profilePicUrl,
              ),
      ),
    );
  }

  List<Widget> getPrimaryDetails(AuthenticationBloc ab, NavigationBloc nb,
      {bool showEditIconBesideName = false}) {
    IconData? genderIcon = getIconFromGender(ab.userModel.gender);
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            ab.userModel.name,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "PublicSans",
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          if (genderIcon != null && !showEditIconBesideName)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                genderIcon,
                size: 25,
              ),
            ),
          if (showEditIconBesideName)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: IconButton(
                icon: const Icon(
                  FontAwesomeIcons.userPen,
                ),
                onPressed: () {
                  nb.toRoute("/editProfile");
                },
              ),
            ),
        ],
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
              fontFamily: "PublicSans",
            ),
            children: [
              TextSpan(
                text: ab.userModel.uid,
                style: const TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: "PublicSans",
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
              fontFamily: "PublicSans",
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
