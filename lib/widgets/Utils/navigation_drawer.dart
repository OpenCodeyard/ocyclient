import 'package:flutter/material.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
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
        child: Column(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple,
                    Colors.deepPurple.shade300,
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    bottom: 12.0,
                    left: 16.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (ab.isLoggedIn) {
                                  nb.toRoute("/profile");
                                } else {
                                  nb.toRoute("/auth");
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage: ab.isLoggedIn
                                    ? NetworkImage(ab.userModel.profilePicUrl)
                                    : null,
                                child: ab.isLoggedIn
                                    ? null
                                    : const Icon(
                                        Icons.person,
                                        color: Colors.blueGrey,
                                      ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome ${ab.isLoggedIn ? getFirstName(ab.userModel.name) : "Guest!"}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
                      return ListTile(
                        leading: Icon(Config.appDrawerIcons[index]),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15,
                          ),
                        ),
                        title: Text(
                          Config.routeNames.keys.toList()[index],
                          style: const TextStyle(
                            fontSize: 19,
                            fontFamily: "PublicSans",
                          ),
                        ),
                        onTap: () => Navigator.of(context).pushNamed(
                            Config.routeNames.values.toList()[index]),
                        selectedColor: Theme.of(context).primaryColor,
                        hoverColor: Colors.blueGrey.shade200,
                        selected: name != null &&
                            name == Config.routeNames.values.toList()[index],
                      );
                    },
                  ),
                  if (ab.isLoggedIn)
                    ListTile(
                      leading: const Icon(Icons.logout_outlined),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      title: const Text("Log Out"),
                      selectedColor: Theme.of(context).primaryColor,
                      hoverColor: Colors.blueGrey.shade200,
                      selected: false,
                      onTap: () {
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
}
