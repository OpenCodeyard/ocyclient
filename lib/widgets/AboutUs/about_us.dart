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
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: size.width < 600 ? size.width / 1.2 : size.width / 2,
                child: Text(
                    "We are a community of open source enthusiasts who aim to "
                    "make software free and accessible to all."
                    " As individuals, we encourage each other to grow and innovate."
                    " As an organization, we thrive to build the community we call home.",
                    style: TextStyle(
                      fontFamily: "PublicSans",
                      fontSize: size.width < 600 ? 17 : 20,
                      color: Colors.deepPurple,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
