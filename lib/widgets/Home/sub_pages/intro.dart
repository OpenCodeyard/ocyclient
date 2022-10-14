import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          height: size.width > 700 ? size.height : size.height / 1.8,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage(
                "assets/images/welcome.jpg",
              ),
              fit: size.width < 700 ? BoxFit.fill : BoxFit.cover,
              opacity: 0.8,
            ),
            color: const Color(0xff152839),
          ),
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              logoDescription(size),
            ],
          ),
        ),
      ],
    );
  }

  Widget logoDescription(Size size) {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "OPEN CODEYARD",
                style: TextStyle(
                    fontSize: size.width < 500
                        ? 40
                        : size.width < 1200
                            ? 50
                            : 100,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PublicSans",
                    color: Colors.white),
              )
            ],
          ),
          const Spacer(),
          ResponsiveGridList(
            desiredItemWidth: size.width < 700 ? 50 : 140,
            scroll: false,
            rowMainAxisAlignment: MainAxisAlignment.center,
            minSpacing: 20,
            children: [
              getIconButton(
                title: size.width < 700 ? "" : "LinkedIn",
                func: () {
                  launchUrlString(Config.linkedInUrl);
                },
                icon: FontAwesomeIcons.linkedinIn,
              ),
              getIconButton(
                title: size.width < 700 ? "" : "Telegram",
                func: () {
                  launchUrlString(Config.telegramUrl);
                },
                icon: FontAwesomeIcons.telegram,
              ),
              getIconButton(
                title: size.width < 700 ? "" : "GitHub",
                func: () {
                  launchUrlString(Config.ghUrl);
                },
                icon: FontAwesomeIcons.github,
              ),
              getIconButton(
                title: size.width < 700 ? "" : "Discord",
                func: () {
                  showToast("Coming Soon!");
                },
                icon: FontAwesomeIcons.discord,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
