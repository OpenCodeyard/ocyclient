import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:ocyclient/widgets/Utils/scroll_animation.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool dark = Get.isDarkMode;

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
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height - 80,
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
                                color: index == 0
                                    ? const Color(0xff4a1a71)
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
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Our Story",
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
                      ],
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
                      height: 35,
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
                      height: 35,
                    ),
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
}
