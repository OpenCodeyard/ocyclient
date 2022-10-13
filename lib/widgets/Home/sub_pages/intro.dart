import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/Utils/common_widgets.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/welcome.jpg",
              ),
              fit: BoxFit.cover,
              opacity: 0.8,
            ),
            color: Color(0xff152839),
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: size.width < 1150
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    logoDescription(size),
                    // ocy(size),
                  ],
                )
              : Row(
                  children: [
                    // ocy(size),
                    logoDescription(size),
                  ],
                ),
        ),
      ],
    );
  }

  Widget ocy(Size size) {
    return SizedBox(
      width: size.width < 700 ? size.width : size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/ocy_logo.png",
              fadeInCurve: Curves.easeOutQuint,
              image: "https://i.imgur.com/mxc0F3W.gif",
              height: 120,
              width: 120,
            ),
          ),
        ],
      ),
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
          // Container(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: size.width < 420 ? 40 : 5,
          //     vertical: 50,
          //   ),
          //   child: Text(
          //     "We believe every contribution is special and so are you.",
          //     textAlign: TextAlign.center,
          //     style: TextStyle(
          //       fontSize: size.width < 700 ? 20 : 30,
          //       fontFamily: "PublicSans",
          //       color: const Color(0xff152839),
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          const Spacer(),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getIconButton(
                  title: "LinkedIn",
                  func: () {
                    launchUrlString(Config.linkedInUrl);
                  },
                  icon: FontAwesomeIcons.linkedinIn,
                ),
                const SizedBox(
                  width: 40,
                ),
                getIconButton(
                  title: "Telegram",
                  func: () {
                    launchUrlString(Config.telegramUrl);
                  },
                  icon: FontAwesomeIcons.github,
                ),
                const SizedBox(
                  width: 40,
                ),
                getIconButton(
                  title: "GitHub",
                  func: () {
                    launchUrlString(Config.ghUrl);
                  },
                  icon: FontAwesomeIcons.github,
                ),
                const SizedBox(
                  width: 40,
                ),
                getIconButton(
                  title: "Discord",
                  func: () {
                    showToast("Coming Soon!");
                  },
                  icon: FontAwesomeIcons.discord,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
