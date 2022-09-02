import 'package:dev_icons/dev_icons.dart';
import 'package:flutter/material.dart';

class SkillCard extends StatelessWidget {
  final String title;
  final String experience;
  final Color color;
  final IconData icon;

  const SkillCard({
    Key? key,
    required this.title,
    required this.experience,
    required this.color,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Card(
        elevation: 5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Icon(
                DevIcons.javaPlain,
                color: color,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Experience : $experience years",
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "ProximaNova",
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
