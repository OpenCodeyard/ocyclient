import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';

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

    double height = MediaQuery.of(context).size.height;

    return GosScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 70,
              child: Image.asset("assets/images/animated_gos.gif"),
            ),
          ],
        ),
      ),
    );
  }
}
