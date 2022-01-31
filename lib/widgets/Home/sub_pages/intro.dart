import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff3B3B3B),
          height: MediaQuery.of(context).size.height * 0.9 - 70,
          child: size.width < 1150
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoDescription(size),
                    gos(size),
                  ],
                )
              : Row(
                  children: [
                    gos(size),
                    logoDescription(size),
                  ],
                ),
        ),
        if (size.width > 1150)
          Positioned(
            left: size.width / 2.1,
            child: Transform.rotate(
              angle: math.pi / 30,
              child: Container(
                color: Colors.white,
                height: size.height,
                width: 5,
              ),
            ),
          )
      ],
    );
  }

  Widget gos(Size size) {
    return SizedBox(
      width: size.width < 700 ? size.width : size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/animated_gos.gif",
            height: size.width < 700 ? 120 : 150,
            width: size.width < 700 ? 120 : 150,
          ),
          Text(
            "Join the Community 👇",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width < 700 ? 14 : 20,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  LineIcons.github,
                  color: Colors.white,
                ),
                iconSize: 35,
                tooltip: "GitHub",
                onPressed: () {
                  launch("https://github.com/GCELTIANS2020");
                },
              ),
              IconButton(
                icon: const Icon(
                  LineIcons.discord,
                  color: Colors.white,
                ),
                tooltip: "Discord",
                iconSize: 35,
                onPressed: () {
                  launch(
                      "https://discord.com/channels/929987337742602272/929988126225616926/929993469898924063");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget logoDescription(Size size) {
    return SizedBox(
      width: size.width < 1150 ? size.width : size.width / 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/icon_community.png",
                width: size.width < 500
                    ? 40
                    : size.width < 700
                        ? 60
                        : 80,
                height: size.width < 500
                    ? 40
                    : size.width < 700
                        ? 60
                        : 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                width: 30,
              ),
              RichText(
                text: TextSpan(
                  text: "GCELT",
                  style: TextStyle(
                    fontSize: size.width < 500
                        ? 23
                        : size.width < 700
                            ? 35
                            : 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: " Open Source",
                      style: TextStyle(
                        fontSize: size.width < 500
                            ? 23
                            : size.width < 700
                                ? 35
                                : size.width < 1200
                                    ? 45
                                    : 50,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: "ProximaNova",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 50),
            child: Text(
              "We believe every contribution is special and so are you.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width < 700 ? 14 : 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
