import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeamCard extends StatefulWidget {

  final Size size;
  final String title;
  const TeamCard({Key? key,required this.size, required this.title}) : super(key: key);

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: const Color(0xff152839),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 20,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 12,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontFamily: "PublicSans",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: widget.size.width > 1100
                      ? 40
                      : widget.size.width > 800
                      ? 30
                      : 20,
                ),
              ),
              const Spacer(),
              const Icon(
                FontAwesomeIcons.circlePlus,
                color: Colors.white,
                size: 40,
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
