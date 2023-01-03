import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ocyclient/widgets/ComingSoon/coming_soon.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';

class MilestonesPage extends StatefulWidget {
  const MilestonesPage({Key? key}) : super(key: key);

  @override
  State<MilestonesPage> createState() => _MilestonesPageState();
}

class _MilestonesPageState extends State<MilestonesPage> {
  

  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Milestones 🏆',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    return const ComingSoon();
  }
}
