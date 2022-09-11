import 'package:flutter/material.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return OcyScaffold(
      body: SizedBox(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage.assetNetwork(
                placeholder: "assets/images/ocy_logo.png",
                fadeInCurve: Curves.easeOutQuint,
                image: "https://i.imgur.com/mxc0F3W.gif",
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 50,),
            const Text(
              "Coming Soon!",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: "PublicSans",
                fontSize: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
