import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oskclient/blocs/auth_bloc.dart';
import 'package:oskclient/blocs/navigation_bloc.dart';
import 'package:provider/provider.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);

    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "Accounts",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: size.width < 700 ? 25 : 40,
              fontFamily: "ProximaNova",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: [
              getAccountCard(
                  ab, nb, "assets/images/google_logo.png", "Google", context),
              const SizedBox(
                width: 15,
              ),
              getAccountCard(
                  ab, nb, "assets/images/github_logo.png", "Github", context)
            ],
          ),
        ),
      ],
    );
  }

  Widget getAccountCard(
    AuthenticationBloc ab,
    NavigationBloc nb,
    String imagePath,
    String name,
    BuildContext context,
  ) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 30,
              width: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            MouseRegion(
              cursor: !ab.userModel.loginProvidersConnected.contains(name)
                  ? SystemMouseCursors.click
                  : SystemMouseCursors.basic,
              child: GestureDetector(
                onTap: () {
                  if (!ab.userModel.loginProvidersConnected.contains(name)) {
                    if (name == "Google") {
                      ab.authWithGoogle(nb, true);
                    } else {
                      ab.authWithGithub(context, nb, true);
                    }
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ab.userModel.loginProvidersConnected.contains(name)
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.green,
                            size: 15,
                          )
                        : const Icon(
                            FontAwesomeIcons.link,
                            color: Colors.indigoAccent,
                            size: 15,
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: "Varela",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
