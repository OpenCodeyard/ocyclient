import 'package:flutter/material.dart';
import 'package:gosclient/blocs/community_bloc.dart';
import 'package:gosclient/configs/config.dart';
import 'package:gosclient/enums/curtain.dart';
import 'package:gosclient/widgets/Community/utils/curtain_image.dart';
import 'package:provider/provider.dart';

class DesktopCurtain extends StatefulWidget {
  final CurtainEnum position;

  const DesktopCurtain({
    Key? key,
    required this.position,
  }) : super(key: key);

  @override
  State<DesktopCurtain> createState() => _DesktopCurtainState();
}

class _DesktopCurtainState extends State<DesktopCurtain> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    CommunityBloc cb = Provider.of<CommunityBloc>(context);
    return getCurtain(size, cb);
  }

  Widget getCurtain(Size size, CommunityBloc cb) {
    bool isLeft = widget.position == CurtainEnum.left;
    double angle = isLeft ? -25 : 25;
    Map<String, dynamic> curtainImages =
        isLeft ? Config.curtainImagesLeft : Config.curtainImagesRight;

    return AnimatedPositioned(
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
            children: curtainImages.entries.map(
              (entry) {
                if (entry.key != "SizedBox") {
                  return Transform.rotate(
                    angle: angle,
                    child: SizedBox(
                      height: size.height / 4 + 40,
                      width: size.width / 6,
                      child: CurtainImage(
                        heading: entry.key,
                        imagePath: entry.value,
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: entry.value,
                  );
                }
              },
            ).toList(),
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
      left: !isLeft
          ? null
          : cb.hasCompletedCurtainAnimation
              ? -size.width / 2
              : 0,
      right: isLeft
          ? null
          : cb.hasCompletedCurtainAnimation
              ? -size.width / 2
              : 0,
    );
  }
}
