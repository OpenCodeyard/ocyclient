import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocyclient/blocs/community_bloc.dart';
import 'package:ocyclient/widgets/ComingSoon/coming_soon.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setApplicationSwitcherDescription(
      ApplicationSwitcherDescription(
        label: 'Community 🤝',
        primaryColor: Theme.of(context).primaryColor.value,
      ),
    );

    Size size = MediaQuery.of(context).size;
    CommunityBloc cb = Provider.of<CommunityBloc>(context);
    return const ComingSoon();
  }

}
