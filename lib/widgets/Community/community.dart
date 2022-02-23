import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  double top1 = 500;
  double top2 = 800;

  double actualHeight = 0;

  bool hasCompletedCurtainAnimation = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Community 🤝',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    Size size = MediaQuery.of(context).size;

    return GosScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedPositioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/curtain.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                height: size.height,
                width: size.width / 2,
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // RichText(
                    //   text: const TextSpan(
                    //     text: "Be a part of an ever growing community",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontFamily: "Varela",
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 25,
                    //     ),
                    //     children: [
                    //       WidgetSpan(
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(
                    //             horizontal: 10.0,
                    //           ),
                    //           child: Icon(
                    //             FontAwesomeIcons.users,
                    //             color: Colors.white,
                    //             size: 25,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Transform.rotate(
                      angle: -25,
                      child: SizedBox(
                        height: size.height / 4 + 40,
                        width: size.width / 6,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height / 4,
                              width: size.width / 6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 8,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      "assets/images/curtain_event.png",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Events",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Varela",
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 5.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              child: Icon(
                                FontAwesomeIcons.thumbtack,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Transform.rotate(
                      angle: -25,
                      child: SizedBox(
                        height: size.height / 4 + 40,
                        width: size.width / 6,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height / 4,
                              width: size.width / 6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 8,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      "assets/images/curtain_project.png",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.darken,
                                    ),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Projects",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Varela",
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 5.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              child: Icon(
                                FontAwesomeIcons.thumbtack,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            duration: const Duration(
              milliseconds: 1500,
            ),
            curve: Curves.bounceOut,
            height: size.height,
            width: size.width / 2,
            top: 0,
            left: hasCompletedCurtainAnimation ? -size.width / 2 : 0,
          ),
          AnimatedPositioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/curtain.jpg",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                height: size.height,
                width: size.width / 2,
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // RichText(
                    //   text: const TextSpan(
                    //     text: "Be a part of an ever growing community",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontFamily: "Varela",
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 25,
                    //     ),
                    //     children: [
                    //       WidgetSpan(
                    //         child: Padding(
                    //           padding: EdgeInsets.symmetric(
                    //             horizontal: 10.0,
                    //           ),
                    //           child: Icon(
                    //             FontAwesomeIcons.users,
                    //             color: Colors.white,
                    //             size: 25,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Transform.rotate(
                      angle: 25,
                      child: SizedBox(
                        height: size.height / 4 + 40,
                        width: size.width / 6,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height / 4,
                              width: size.width / 6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 8,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      "assets/images/curtain_learn.png",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Learn",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Varela",
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 5.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              child: Icon(
                                FontAwesomeIcons.thumbtack,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Transform.rotate(
                      angle: 25,
                      child: SizedBox(
                        height: size.height / 4 + 40,
                        width: size.width / 6,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: size.height / 4,
                              width: size.width / 6,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 8,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: const AssetImage(
                                      "assets/images/curtain_grow.png",
                                    ),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.darken),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Grow",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Varela",
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2, 2),
                                          blurRadius: 5.0,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Positioned(
                              top: 0,
                              child: Icon(
                                FontAwesomeIcons.thumbtack,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            duration: const Duration(
              milliseconds: 1500,
            ),
            curve: Curves.bounceOut,
            height: size.height,
            width: size.width / 2,
            top: 0,
            right: hasCompletedCurtainAnimation ? -size.width / 2 : 0,
          ),
          Positioned(
            top : size.height / 2 - 200,
            height: 300,
            width: 300,
            child: Visibility(
              visible: !hasCompletedCurtainAnimation,
              child: Image.asset(
                "assets/images/animated_gos.gif",
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            height: 50,
            width: 180,
            child: Visibility(
              visible: !hasCompletedCurtainAnimation,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 20,
                  shadowColor: Colors.white.withOpacity(0.5),
                  padding: const EdgeInsets.all(20),
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    hasCompletedCurtainAnimation = true;
                  });
                },
                child: const Text(
                  "Dive In!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: "ProximaNova",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
