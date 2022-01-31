import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gosclient/widgets/Utils/gos_scaffold.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool dark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Community 🤝',
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
