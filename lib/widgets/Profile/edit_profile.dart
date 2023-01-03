import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/edit_profile_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/widgets/Profile/sub_pages/edit_personal.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  ///TODO cover attribution <a href="https://www.freepik.com/vectors/background">Background vector created by freepik - www.freepik.com</a>

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    EditProfileBloc epb = Provider.of<EditProfileBloc>(context);
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
                          physics: const BouncingScrollPhysics(),
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
                    const PersonalTab(),
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
                          children: getEditProfileMenu(size, epb, ab, nb),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 1,
                    color: Colors.black12,
                  ),
                  const PersonalTab(),
                  const VerticalDivider(
                    width: 1,
                    color: Colors.black12,
                  ),
                  if (size.width >= 1500)
                    const SizedBox(),
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
          "assets/images/ocy_logo.png",
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
        FontAwesomeIcons.userLarge,
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
