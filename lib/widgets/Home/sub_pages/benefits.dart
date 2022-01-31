import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gosclient/widgets/Utils/measure_size_render_object.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Benefits extends StatefulWidget {
  const Benefits({Key? key}) : super(key: key);

  @override
  _BenefitsState createState() => _BenefitsState();
}

class _BenefitsState extends State<Benefits> {
  final List<bool> _amIHovering = [false, false, false];

  Size cardSize = const Size(0, 0);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height:
          size.height > 800 ? size.height * 0.8 - 70 : size.height * 0.9 - 70,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Why Open Source ?",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "ProximaNova",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: size.width / 1.5,
            child: const Text(
              "We believe software should be free for all."
              "\nUnder our open source program we plan to reduce the economic gaps of society.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "ProximaNova",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                scrollDirection: Axis.horizontal,
                children: [
                  getBenefitsCard(
                    size,
                    "Learn",
                    "Be a part of great projects that enhance your career and skills.",
                    0,
                    Colors.green,
                    LineIcons.graduationCap,
                    null,
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
                    Colors.blue,
                    CupertinoIcons.group,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            LineIcons.github,
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
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  getBenefitsCard(
                    size,
                    "Events",
                    "Join live events that are great fun.",
                    2,
                    Colors.indigo,
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
    MaterialColor iconColor,
    IconData icon,
    Widget? extra,
  ) {
    return MeasureSize(
      onChange: (Size size) {
        cardSize = size;
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
        child: SizedBox(
          width: size.width / 5 < 300 ? 300 : size.width / 5,
          child: Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: AnimatedContainer(
                    width: _amIHovering[index]
                        ? size.width / 5 < 300
                            ? 300 - 8
                            : size.width / 5 - 8
                        : 0,
                    height: _amIHovering[index] ? cardSize.height - 8 : 0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: iconColor.shade100,
                    ),
                    duration: const Duration(
                      milliseconds: 1000,
                    ),
                    curve: Curves.fastOutSlowIn,
                  ),
                  left: 0,
                  bottom: 0,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 60,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      extra ?? const SizedBox(),
                    ],
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
