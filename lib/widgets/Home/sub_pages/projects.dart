import 'package:face_pile/face_pile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ocyclient/blocs/projects_bloc.dart';
import 'package:ocyclient/models/project/project_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Projects extends StatefulWidget {
  const Projects({Key? key}) : super(key: key);

  @override
  ProjectsState createState() => ProjectsState();
}

class ProjectsState extends State<Projects> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProjectsBloc>(context, listen: false).getProjects();
    });
    super.initState();
  }

  DateFormat formatter = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProjectsBloc pb = Provider.of<ProjectsBloc>(context);

    return SizedBox(
      width: size.width,
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
              fontFamily: "PublicSans",
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          pb.isProjectsLoading
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 400,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      ProjectModel project = pb.projects[index];
                      int contributorsLength = project.contributors.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        width: 350,
                        height: 350,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                  vertical: 7,
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          project.name,
                                          style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "PublicSans",
                                            color: Colors.black,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            launchUrlString(project.repoUrl);
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.github,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.readme,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 250,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            project.description,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PublicSans",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.calendar,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: 250,
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            "Active since\n${formatter.format(project.creationDate)}",
                                            maxLines: 2,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              height: 1.5,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "PublicSans",
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 23),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        project.starCount.toString(),
                                        style: const TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const ImageIcon(
                                        AssetImage(
                                          "assets/images/fork_icon.png",
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        project.forkCount.toString(),
                                        style: const TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        project.activeIssuesCount.toString(),
                                        style: const TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 25,
                                      ),
                                      const Icon(
                                        Icons.remove_red_eye,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        project.watchCount.toString(),
                                        style: const TextStyle(
                                          fontFamily: "PublicSans",
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Divider(),
                              //TODO refactoring
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 23),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Top contributors",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "PublicSans",
                                          color: Colors.black,
                                        ),
                                      ),
                                      Stack(
                                        children: [
                                          if (contributorsLength > 3)
                                            Container(
                                              width: 38 * 4,
                                            ),
                                          if (contributorsLength > 3)
                                            Positioned(
                                              width: 50,
                                              left: 3 * 32 - 1,
                                              child: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    const Color(0xff071a2b),
                                                child: Text(
                                                  "+${contributorsLength - 3}",
                                                  style: const TextStyle(
                                                    fontFamily: "PublicSans",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          FacePile(
                                            radius: 25,
                                            space: 30,
                                            images: List.generate(
                                              contributorsLength > 3
                                                  ? 3
                                                  : contributorsLength,
                                              (i) {
                                                return NetworkImage(
                                                  project.contributors[i]
                                                      .split("^")[0],
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
