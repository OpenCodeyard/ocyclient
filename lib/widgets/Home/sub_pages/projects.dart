import 'package:flutter/material.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height:
          size.height > 800 ? size.height * 0.4 - 70 : size.height * 0.4 - 70,
      child: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          const Text(
            "Projects",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontFamily: "ProximaNova",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: size.width / 1.5,
            child: const Text(
              "Projects coming soon."
              "\nStay tuned.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: "ProximaNova",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

}
