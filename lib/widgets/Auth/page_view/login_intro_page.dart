import 'package:flutter/material.dart';

class LoginIntroPage extends StatelessWidget {
  final String title, subtitle;
  final String imagePath;

  const LoginIntroPage({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              imagePath,
            ),
            opacity: 0.7,
            fit: BoxFit.cover,
          ),
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width < 1050 ? 80 : 100,
                fontFamily: "ProximaNova",
                fontWeight: FontWeight.w800,
                foreground: Paint()
                  ..strokeWidth = 3
                  ..style = PaintingStyle.stroke
                  ..color = Colors.white,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontFamily: "ProximaNova",
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
