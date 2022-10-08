import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/locale_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/models/localization/language.dart';
import 'package:ocyclient/utils/app_localizations.dart';
import 'package:provider/provider.dart';

import 'common_widgets.dart';
import 'navigation_drawer.dart';

class OcyScaffold extends StatefulWidget {
  final Widget body;
  final bool enableSelection;

  const OcyScaffold({
    Key? key,
    required this.body,
    this.enableSelection = true,
  }) : super(key: key);

  @override
  State<OcyScaffold> createState() => _OcyScaffoldState();
}

class _OcyScaffoldState extends State<OcyScaffold> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    LocaleBLoc lb = Provider.of<LocaleBLoc>(context);

    return widget.enableSelection
        ? SelectionArea(
            child: getCustomScaffold(size, nb, ab, lb),
          )
        : getCustomScaffold(size, nb, ab, lb);
  }

  Widget getCustomScaffold(
    Size size,
    NavigationBloc nb,
    AuthenticationBloc ab,
    LocaleBLoc lb,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: size.width > 900 ? null : const AppDrawer(),
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        titleSpacing: size.width > 900 ? 40 : 0,
        centerTitle: size.width > 900 ? false : true,
        title: RichText(
          text: TextSpan(
            text: "{",
            style: TextStyle(
              fontSize: size.width < 1100 && size.width > 900 ? 14 : 20,
              fontWeight: FontWeight.bold,
              fontFamily: "PublicSans",
              color: Colors.black,
            ),
            children: <TextSpan>[
              TextSpan(
                text: " Open ",
                style: TextStyle(
                  fontSize: size.width < 1100 && size.width > 900 ? 14 : 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade700,
                ),
              ),
              TextSpan(
                text: "Codeyard ",
                style: TextStyle(
                  fontSize: size.width < 1100 && size.width > 900 ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "} ;",
                style: TextStyle(
                  fontSize: size.width < 1100 && size.width > 900 ? 14 : 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        actions: getAppBarActions(nb, size, ab, lb),
      ),
      body: widget.body,
    );
  }

  Widget getAppBarButton(String label, NavigationBloc nb, int index) {
    String? name = ModalRoute.of(context)?.settings.name;

    String passedRoute = Config.routeNames.values.toList()[index];
    bool selected = (name != null && name == passedRoute);

    return Container(
      padding: const EdgeInsets.all(4.0),
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width < 1100 ? 5 : 10,
          vertical: 4),
      decoration: selected
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 3,
                  color: Color(0xff071a2b),
                ),
              ),
            )
          : null,
      child: TextButton(
        onPressed: () {
          nb.toRoute(passedRoute);
        },
        child: Text(
          label,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width < 1100 ? 12 : 15,
            color: selected ? const Color(0xff071a2b) : Colors.black,
            fontFamily: "PublicSans",
            fontWeight: selected ? FontWeight.w700 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  List<Widget> getAppBarActions(
    NavigationBloc nb,
    Size size,
    AuthenticationBloc ab,
    LocaleBLoc lb,
  ) {
    String? name = ModalRoute.of(context)?.settings.name;

    return size.width > 900
        ? [
            ...List.generate(
              Config.routeNames.length,
              (index) {
                return getAppBarButton(
                  AppLocalization.of(context)
                      .getTranslatedValue(
                        Config.routeNames.keys.toList()[index],
                      )
                      .toString(),
                  nb,
                  index,
                );
              },
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton<Language>(
                dropdownColor: Colors.white,
                value: lb.getCurrentSelectedLanguage(),
                items: Config.languageList.map((Language value) {
                  return DropdownMenuItem<Language>(
                    value: value,
                    child: Container(
                      width: 200,
                      child: Text(
                        value.name,
                      ),
                    ),
                  );
                }).toList(),
                selectedItemBuilder: (context) {
                  return Config.languageList.map<Widget>((Language value) {
                    // This is the widget that will be shown when you select an item.
                    // Here custom text style, alignment and layout size can be applied
                    // to selected item string.
                    return DropdownMenuItem<Language>(
                      value: value,
                      child: Text(
                        value.name.substring(0, 2),
                      ),
                    );
                  }).toList();
                },
                onChanged: (Language? l) {
                  if (l != null) {
                    lb.changeLanguage(l, context);
                  }
                },
              ),
            ),
            ...[
              ab.isLoggedIn
                  ? GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showPopupMenu(details.globalPosition, ab, nb);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: ab.isLoggedIn
                              ? Image.network(ab.userModel.profilePicUrl)
                              : null,
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.all(4.0),
                      margin: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width < 1100
                              ? 5
                              : 10),
                      decoration: name != null && name == "/auth"
                          ? BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 2,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            )
                          : null,
                      child: TextButton.icon(
                        icon: const Icon(
                          Icons.login,
                          color: Colors.deepPurple,
                        ),
                        onPressed: () {
                          nb.toRoute("/auth");
                        },
                        label: const Text(
                          "Log In",
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 15,
              ),
            ]
          ]
        : [];
  }

  void _showPopupMenu(
      Offset offset, AuthenticationBloc ab, NavigationBloc nb) async {
    double left = offset.dx;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(left - 50, 65, 0, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: const Color(0xff0f254e),
      items: [
        PopupMenuItem(
          height: 40,
          value: 1,
          child: SizedBox(
            height: 40,
            width: 120,
            child: getIconButtonBody(
              "Profile",
              FontAwesomeIcons.user,
            ),
          ),
        ),
        PopupMenuItem(
          height: 40,
          value: 2,
          child: SizedBox(
            height: 40,
            width: 120,
            child: getIconButtonBody(
              "Log Out",
              FontAwesomeIcons.rightFromBracket,
            ),
          ),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      if (value == 1) {
        nb.toRoute("/profile");
      } else if (value == 2) {
        ab.signOut(context, nb);
      }
    });
  }
}
