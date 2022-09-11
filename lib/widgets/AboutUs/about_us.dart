import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  bool dark = Get.isDarkMode;

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
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(size.width < 600 ? 15 : 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        text:
                            "We help open source enthusiasts${size.width > 400 ? "\n" : " "}level up. ",
                        style: TextStyle(
                          fontSize: size.width > 900
                              ? 50
                              : size.width > 600
                                  ? 35
                                  : 24,
                          fontWeight: FontWeight.w700,
                          fontFamily: "PublicSans",
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "Together.",
                            style: TextStyle(
                              fontSize: size.width > 900
                                  ? 50
                                  : size.width > 600
                                      ? 35
                                      : 24,
                              fontWeight: FontWeight.w700,
                              fontFamily: "PublicSans",
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Icon(FontAwesomeIcons.rocketchat),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
