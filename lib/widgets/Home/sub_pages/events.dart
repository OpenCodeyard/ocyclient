import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width < 900 ? 30 : 15),
      color: Colors.white,
      width: size.width,
      // height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.1,
          ),
          size.width < 900
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    eventZone(size),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: "EVENTS"
                          .split("")
                          .map((string) => Text(
                                string,
                                style: TextStyle(
                                  fontFamily: "PublicSans",
                                  fontWeight: FontWeight.bold,
                                  fontSize: size.width > 1100 ? 70 : 60,
                                  letterSpacing: 4,
                                  foreground: Paint()
                                    ..strokeWidth = 1
                                    ..style = PaintingStyle.stroke
                                    ..color = const Color(
                                      0xff071a2b,
                                    ),
                                ),
                              ))
                          .toList(),
                    ),
                    eventZone(size),
                    eventZone(size),
                  ],
                ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget eventZone(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        SizedBox(
          width: size.width < 900
              ? size.width
              : size.width > 1050
                  ? 380
                  : size.width * 0.3,
          child: Text(
            "We conduct as well as participate in frequent events spanning over"
            " a wide range of topics from technology, "
            "games, awareness campaigns, etc.",
            style: TextStyle(
              fontSize: size.width < 1000 ? 16 : 18,
              fontFamily: "PublicSans",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Text(
            "All events",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
          label: const Icon(
            LineIcons.arrowRight,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}
