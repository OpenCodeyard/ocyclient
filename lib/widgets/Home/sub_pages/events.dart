import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class UpcomingEvents extends StatelessWidget {
  const UpcomingEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width < 900 ? 30 : 15),
      color: const Color(0xffeaeaea),
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
                    featuredEvent(size),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // SizedBox(
                    //   width: size.width < 1200
                    //       ? size.width * 0.1
                    //       : size.width * 0.2,
                    // ),
                    eventZone(size),
                    // const Spacer(),
                    featuredEvent(size),
                    // SizedBox(
                    //   width: size.width < 1200
                    //       ? size.width * 0.05
                    //       : size.width * 0.1,
                    // ),
                  ],
                ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget featuredEvent(Size size) {
    return Container(
      height: size.width < 540 ? size.height / 6 : size.height / 4.2,
      width: size.width < 540
          ? size.width * 0.9
          : size.width < 900
              ? 480
              : size.width > 1000
                  ? 480
                  : size.width / 2.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xffceb4f6), width: 4),
        color: const Color(0xffeaeaea),
      ),
      child: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: SizedBox(
            height: size.width < 540 ? size.height / 7.2 : size.height / 4.8,
            width: size.width < 540
                ? size.width * 0.8
                : size.width < 900
                    ? 450
                    : size.width > 1000
                        ? 450
                        : size.width / 2.6,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  backgroundImage: const AssetImage("assets/images/ocy_logo.png"),
                  radius: size.width < 540 ? 30 : 60,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hacktober Fest",
                      style: TextStyle(
                        fontSize: size.width < 540 ? 15 : 20,
                        fontFamily: "PublicSans",
                      ),
                    ),
                    Text(
                      "October 2022",
                      style: TextStyle(
                        fontSize: size.width < 540 ? 12 : 16,
                        fontFamily: "PublicSans",
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      ),
                      onPressed: () {},
                      child: Text(
                        "View",
                        style: TextStyle(
                          fontSize: size.width < 540 ? 12 : 15,
                          color: Colors.blue,
                          fontFamily: "PublicSans",
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget eventZone(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Event Zone",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            fontFamily: "PublicSans",
            color: Colors.black,
          ),
        ),
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
            "We conduct frequent events spanning over"
            " a wide range of topics from technology, "
            "games, awareness campaigns, etc.",
            style: TextStyle(
              fontSize: size.width < 1000 ? 16 : 18,
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
