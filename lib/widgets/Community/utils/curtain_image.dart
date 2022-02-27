import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO make image widget responsive
class CurtainImage extends StatelessWidget {
  final String imagePath;
  final String heading;

  const CurtainImage({
    Key? key,
    required this.imagePath,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height / 4,
          width: size.width / 6,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 8,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  imagePath,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Center(
              child: Text(
                heading,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Varela",
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 5.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Positioned(
          top: 0,
          child: Icon(
            FontAwesomeIcons.thumbtack,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
