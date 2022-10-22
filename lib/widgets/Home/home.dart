import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocyclient/widgets/Home/sub_pages/benefits.dart';
import 'package:ocyclient/widgets/Home/sub_pages/events.dart';
import 'package:ocyclient/widgets/Home/sub_pages/footer.dart';
import 'package:ocyclient/widgets/Home/sub_pages/intro.dart';
import 'package:ocyclient/widgets/Home/sub_pages/projects.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Home 🏠',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    //Add attribution
    //<a target="_blank" href="https://icons8.com/icon/51geCPj1J4bd/community">Community</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>

    return OcyScaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Intro(),
            // if (kDebugMode) UpcomingEvents(),
            Benefits(),
            Projects(),
            Footer(),
          ],
        ),
      ),
    );
  }
}
