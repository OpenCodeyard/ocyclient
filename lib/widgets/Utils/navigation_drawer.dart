import 'package:flutter/material.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  AppDrawerState createState() => AppDrawerState();
}

class AppDrawerState extends State<AppDrawer> {
  String getRoute(String title) {
    switch (title) {
      case 'Events Calendar':
        return '/eventCalendar';
      case 'Best Destinations':
        return '/destination';
      case 'Special Offers':
        return '/specialOffer';
      case 'Request Artist':
        return '/Artists';
      case 'Contact Us':
        return '/contactus';
      case 'News Alert':
        return '/newsLetter';
      default:
        return '/home';
    }
  }

  final List<bool> _amIHovering = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.5;

    double height = MediaQuery.of(context).size.height;
    String? name = ModalRoute.of(context)?.settings.name;

    NavigationBloc nb = Provider.of<NavigationBloc>(context);
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);

    return SizedBox(
      width: width,
      height: height,
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            Container(
              height: 161 + MediaQuery.of(context).padding.top,
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  // bottomRight: Radius.circular(20),
                ),
                color: const Color(0xff071a2b),
                border: Border.all(color: Colors.transparent),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (ab.isLoggedIn) {
                            nb.toRoute("/profile");
                          } else {
                            nb.toRoute("/auth");
                          }
                        },
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.blueGrey,
                              width: 3,
                            ),
                          ),
                          child: ab.isLoggedIn
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child:
                                      Image.network(ab.userModel.profilePicUrl),
                                )
                              : const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    child: Text(
                      "Hello 👋, ${ab.isLoggedIn ? getFirstName(ab.userModel.name) : "Guest"}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  ...List.generate(
                    Config.routeNames.length,
                    (index) {
                      bool selected = isSelected(name, index);
                      return drawerItem(
                        index,
                        selected,
                        null,
                      );
                    },
                  ),
                  if (ab.isLoggedIn)
                    drawerItem(
                      5,
                      false,
                      () {
                        ab.signOut(context, nb);
                      },
                    ),
                ],
              ),
            ),
            Text(
              "v${Config.appVersion}",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 19,
                fontFamily: "PublicSans",
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  String getFirstName(String name) {
    if (name.split(" ").length > 1) {
      return name.split(" ")[0];
    } else {
      return name.substring(0, 8);
    }
  }

  bool isSelected(String? name, int index) {
    return name != null && name == Config.routeNames.values.toList()[index];
  }

  Widget drawerItem(int index, bool selected, void Function()? onTap) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          Navigator.of(context).pushNamed(
            Config.routeNames.values.toList()[index],
          );
        } else {
          onTap();
        }
      },
      child: MouseRegion(
        onEnter: (details) {
          setState(() {
            _amIHovering[index] = true;
          });
        },
        onExit: (details) => setState(() {
          _amIHovering[index] = false;
        }),
        cursor: SystemMouseCursors.click,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          elevation: selected || _amIHovering[index] ? 5 : 0,
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                border: selected
                    ? const Border(
                        left: BorderSide(
                          color: Color(0xff071a2b),
                          width: 5,
                        ),
                      )
                    : _amIHovering[index]
                        ? Border(
                            left: BorderSide(
                              color: index == 5 ? Colors.red : Colors.indigo,
                              width: 5,
                            ),
                          )
                        : null,
              ),
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    selected || _amIHovering[index]
                        ? Config.selectedAppDrawerIcons[index]
                        : Config.appDrawerIcons[index],
                    size: selected || _amIHovering[index] ? 18 : 25,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    index == 5
                        ? "Log Out"
                        : Config.routeNames.keys.toList()[index],
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: "PublicSans",
                      fontWeight: selected || _amIHovering[index]
                          ? FontWeight.w700
                          : FontWeight.normal,
                      color: selected ? const Color(0xff071a2b) : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
