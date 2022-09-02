import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oskclient/widgets/Utils/osk_scaffold.dart';

class MilestonesPage extends StatefulWidget {
  const MilestonesPage({Key? key}) : super(key: key);

  @override
  State<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> {
  bool dark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Milestones 🏆',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    double height = MediaQuery.of(context).size.height;

    return OskScaffold(
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
