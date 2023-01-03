import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:ocyclient/widgets/Utils/scroll_animation.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  int currentIndex = 0;

  ScrollController sc = ScrollController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'About Us ℹ️',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    Size size = MediaQuery.of(context).size;

    return OcyScaffold(
      body: SingleChildScrollView(
        controller: sc,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 15, top: 15),
                      child: Text(
                        "We are ${currentIndex == Config.weAre.length - 1 ? "the " : "a "}community of",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "PublicSans",
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: getHeadingFontSize(size),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CarouselSlider(
                      items: List.generate(
                        Config.weAre.length,
                        (index) => Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              Config.weAre[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "PublicSans",
                                fontWeight: FontWeight.w700,
                                color: index == Config.weAre.length - 1
                                    ? const Color(0xff071a2b)
                                    : Config.weAreColors[index % 5],
                                fontSize: getHeadingFontSize(size),
                              ),
                            ),
                          ),
                        ),
                      ),
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: false,
                        scrollDirection: Axis.vertical,
                        initialPage: 0,
                        viewportFraction: 1,
                        height: 100,
                        onPageChanged: (i, p) {
                          setState(() {
                            currentIndex = i;
                          });
                        },
                        autoPlayCurve: Curves.ease,
                        scrollPhysics: const NeverScrollableScrollPhysics(),
                        autoPlayInterval: const Duration(milliseconds: 1500),
                      ),
                    ),
                    const Spacer(),
                    AnimatedOpacity(
                      opacity: sc.hasClients && (sc.offset < size.height / 2.5)
                          ? 1
                          : 0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            sc.animateTo(
                              size.height,
                              duration: const Duration(
                                milliseconds: 1000,
                              ),
                              curve: Curves.fastOutSlowIn,
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 50,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.5,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                top: 10,
                                child: ScrollAnimationWidget(
                                  child: CircleAvatar(
                                    radius: 5,
                                    backgroundColor: currentIndex == 0
                                        ? const Color(0xff4a1a71)
                                        : Config.weAreColors[currentIndex % 5],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                width: size.width,
                color: const Color(0xff071a2b),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Our Mission",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: size.width > 900
                            ? 50
                            : size.width > 600
                                ? 35
                                : 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: "PublicSans",
                        color: const Color(0xffe8f9ff),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width < 600
                            ? size.width * 0.15
                            : size.width * 0.2,
                        top: 35.0,
                        right: size.width < 600
                            ? size.width * 0.15
                            : size.width * 0.2,
                      ),
                      child: SizedBox(
                        child: Text(
                          "We are a community of open source enthusiasts who aim to "
                          "make software free and accessible to all."
                          " As individuals, we encourage each other to grow and innovate."
                          " As an organization, we thrive to build the community we call home.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "PublicSans",
                            fontSize: size.width < 600 ? 17 : 20,
                            color: const Color(0xffe8f9ff),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      "What else should you know?",
                      style: TextStyle(
                        fontSize: size.width > 900
                            ? 30
                            : size.width > 600
                                ? 25
                                : 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: "PublicSans",
                        color: const Color(0xffe8f9ff),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      child: ResponsiveGridList(
                        desiredItemWidth: 250,
                        scroll: false,
                        rowMainAxisAlignment: MainAxisAlignment.start,
                        minSpacing: 40,
                        children: [
                          singleWhatElse(
                            size,
                            "Remote First",
                            FontAwesomeIcons.globe,
                            "We use GitHub for maintaining projects and communicate"
                                " using online community channels. Thus, members can"
                                " set up shop from anywhere in the world and contribute.",
                          ),
                          singleWhatElse(
                            size,
                            "Mentorship",
                            FontAwesomeIcons.handshakeAngle,
                            "We believe in the potential of our community members. "
                                "So we made a program to provide them with "
                                "mentorship that will help them level up.",
                          ),
                          singleWhatElse(
                            size,
                            "Connect",
                            FontAwesomeIcons.peopleGroup,
                            "Through regular social and technical meetups, expand your network."
                                " Maybe you will find your next best "
                                "friend or idol or mentor or business partner 😉",
                          ),
                          singleWhatElse(
                            size,
                            "Swags",
                            FontAwesomeIcons.gift,
                            "We believe in rewarding you for your contributions."
                                " Earn awesome swags throughout the year.",
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getHeadingFontSize(Size size) {
    return size.width < 420
        ? 26
        : size.width < 600
            ? 36
            : size.width < 700
                ? 50
                : size.width < 1000
                    ? 60
                    : 70;
  }

  Widget singleWhatElse(
    Size size,
    String heading,
    IconData icon,
    String description, {
    double? height,
  }) {
    return SizedBox(
      width: 250,
      // height: height ?? 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
          const SizedBox(height: 20),
          Text(
            heading,
            style: TextStyle(
              fontSize: size.width > 900 ? 22 : 18,
              fontFamily: "PublicSans",
              color: const Color(0xffe8f9ff),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.start,
            style: TextStyle(
              height: 1.3,
              fontSize: size.width > 900 ? 19 : 16,
              fontFamily: "PublicSans",
              color: const Color(0xffe8f9ff).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
