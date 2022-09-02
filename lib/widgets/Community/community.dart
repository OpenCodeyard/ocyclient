import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oskclient/blocs/community_bloc.dart';
import 'package:oskclient/configs/config.dart';
import 'package:oskclient/enums/curtain.dart';
import 'package:oskclient/widgets/Community/sub_pages/desktop_curtain.dart';
import 'package:oskclient/widgets/Utils/osk_scaffold.dart';
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
    return OskScaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const DesktopCurtain(position: CurtainEnum.left),
          const DesktopCurtain(position: CurtainEnum.right),
          getCommunityLogo(size, cb),
          getDiveInButton(cb),
        ],
      ),
    );
  }

  Widget getCommunityLogo(Size size, CommunityBloc cb) {
    return Positioned(
      top: size.height / 2 - 200,
      height: 300,
      width: 300,
      child: Visibility(
        visible: !cb.hasCompletedCurtainAnimation,
        child: Image.asset(
          Config.communityLogoPath,
        ),
      ),
    );
  }

  Widget getDiveInButton(CommunityBloc cb) {
    return Positioned(
      bottom: 30,
      height: 50,
      width: 180,
      child: Visibility(
        visible: !cb.hasCompletedCurtainAnimation,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 20,
            backgroundColor: Colors.white,
            shadowColor: Colors.white.withOpacity(0.5),
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          onPressed: () {
            setState(() {
              cb.setCurtainAnimationStatus();
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
    );
  }
}
