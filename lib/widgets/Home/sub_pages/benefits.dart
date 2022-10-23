import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/Utils/measure_size_render_object.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Benefits extends StatefulWidget {
  const Benefits({Key? key}) : super(key: key);

  @override
  BenefitsState createState() => BenefitsState();
}

class BenefitsState extends State<Benefits> {
  final List<bool> _amIHovering = [false, false, false];

  double cardHeight = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.width > 950
          ? size.height * 0.8 - 50
          : size.width > 800
              ? size.height * 0.8 - 20
              : size.height * 0.9 - 100,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Text(
            "Why Open Source ?",
            style: TextStyle(
              fontSize: size.width > 800
                  ? 40
                  : size.width > 400
                      ? 35
                      : 25,
              fontWeight: FontWeight.w700,
              fontFamily: "PublicSans",
              color: const Color(0xff071a2b),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: size.width > 400 ? size.width / 1.5 : size.width,
            child: Text(
              "We believe software should be free for all."
              "\nUnder our open source program we plan to reduce the economic gaps of society.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: size.width > 800 ? 16 : 14,
                fontFamily: "PublicSans",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Flexible(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  getBenefitsCard(
                    size,
                    "Learn",
                    "Be a part of great projects that enhance your career and skills.",
                    0,
                    const Color(0xff071a2b),
                    LineIcons.graduationCap,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            LineIcons.github,
                            color: _amIHovering[0]
                                ? const Color(0xffe8f9ff)
                                : Colors.black,
                          ),
                          iconSize: 35,
                          tooltip: "GitHub",
                          onPressed: () {
                            launchUrlString("https://github.com/OpenCodeyard");
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  getBenefitsCard(
                    size,
                    "Community",
                    "Projects powered by a community that will "
                        "always have a people first approach.",
                    1,
                    const Color(0xff1e2e68),
                    LineIcons.peopleCarry,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            LineIcons.linkedinIn,
                            color: _amIHovering[1]
                                ? const Color(0xffe8f9ff)
                                : Colors.black,
                          ),
                          iconSize: 35,
                          tooltip: "LinkedIn",
                          onPressed: () {
                            launchUrlString(Config.linkedInUrl);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            LineIcons.discord,
                            color: _amIHovering[1]
                                ? const Color(0xffe8f9ff)
                                : Colors.black,
                          ),
                          tooltip: "Discord",
                          iconSize: 35,
                          onPressed: () {
                            showToast("Coming Soon");
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            LineIcons.telegram,
                            color: _amIHovering[1]
                                ? const Color(0xffe8f9ff)
                                : Colors.black,
                          ),
                          tooltip: "Telegram",
                          iconSize: 35,
                          onPressed: () {
                            launchUrlString(Config.telegramUrl);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  getBenefitsCard(
                    size,
                    "Events",
                    "Join live events that are great fun.",
                    2,
                    const Color(0xff242435),
                    LineIcons.calendarWithWeekFocus,
                    null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBenefitsCard(
    Size size,
    String title,
    String subtitle,
    int index,
    Color iconColor,
    IconData icon,
    Widget? extra,
  ) {
    return MeasureSize(
      onChange: (Size size) {
        cardHeight = size.height;
      },
      key: Key(index.toString()),
      child: MouseRegion(
        onEnter: (details) {
          setState(() {
            _amIHovering[index] = true;
          });
        },
        onExit: (details) => setState(() {
          _amIHovering[index] = false;
        }),
        child: SizedBox(
          width: size.width / 5 < 300 ? 300 : size.width / 5,
          child: Card(
            elevation: _amIHovering[index] ? 35 : 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    width: _amIHovering[index]
                        ? size.width / 5 < 300
                            ? 300 - 8
                            : size.width / 5 - 8
                        : 0,
                    height: _amIHovering[index] ? cardHeight - 8 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: iconColor,
                    ),
                    duration: const Duration(
                      milliseconds: 1000,
                    ),
                    curve: Curves.easeOutQuint,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 60,
                        color: _amIHovering[index]
                            ? const Color(0xffe8f9ff)
                            : Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "PublicSans",
                          color: _amIHovering[index]
                              ? const Color(0xffe8f9ff)
                              : Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: _amIHovering[index]
                              ? const Color(0xffe8f9ff)
                              : Colors.black,
                          fontFamily: "PublicSans",
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      extra ?? const SizedBox(),
                    ],
                  ),
                ),
                Positioned(
                  right: -(size.width / 5 < 300 ? 300 : size.width / 5) / 10,
                  bottom: -(size.width / 5 < 300 ? 300 : size.width / 5) / 10,
                  child: AnimatedContainer(
                    width: _amIHovering[index]
                        ? (size.width / 5 < 300 ? 300 : size.width / 5) / 4
                        : 0,
                    height: _amIHovering[index]
                        ? (size.width / 5 < 300 ? 300 : size.width / 5) / 4
                        : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: const Color(0xffe8f9ff),
                        width: 4,
                      ),
                      color: Colors.transparent,
                    ),
                    duration: const Duration(
                      milliseconds: 1400,
                    ),
                    curve: Curves.easeOutQuint,
                  ),
                ),
                Positioned(
                  left: -(size.width / 5 < 300 ? 300 : size.width / 5) / 10,
                  top: -(size.width / 5 < 300 ? 300 : size.width / 5) / 10,
                  child: AnimatedContainer(
                    width: _amIHovering[index]
                        ? (size.width / 5 < 300 ? 300 : size.width / 5) / 4
                        : 0,
                    height: _amIHovering[index]
                        ? (size.width / 5 < 300 ? 300 : size.width / 5) / 4
                        : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: const Color(0xffe8f9ff),
                        width: 4,
                      ),
                      color: Colors.transparent,
                    ),
                    duration: const Duration(
                      milliseconds: 1400,
                    ),
                    curve: Curves.easeOutQuint,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
