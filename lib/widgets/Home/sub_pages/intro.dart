import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff3b3b3b),
          height: MediaQuery.of(context).size.height * 0.9 - 70,
          child: size.width < 1150
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    logoDescription(size),
                    ocy(size),
                  ],
                )
              : Row(
                  children: [
                    ocy(size),
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
          const SizedBox(
            height: 30,
          ),
          Text(
            "Join the Community",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: size.width < 700 ? 14 : 20,
              fontWeight: FontWeight.w500,
              fontFamily: "PublicSans",
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
                  launchUrlString("https://github.com/OpenCodeyard");
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
                  launchUrlString(
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
                  text: "Open ",
                  style: TextStyle(
                    fontSize: size.width < 500
                        ? 23
                        : size.width < 1200
                            ? 33
                            : 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "PublicSans",
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "Codeyard",
                      style: TextStyle(
                        fontSize: size.width < 500
                            ? 23
                            : size.width < 1200
                                ? 33
                                : 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                fontFamily: "PublicSans",
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
