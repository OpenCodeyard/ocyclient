import 'package:flutter/material.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/widgets/Auth/page_view/login_intro_page.dart';
import 'package:ocyclient/widgets/Utils/ocy_scaffold.dart';
import 'package:ocyclient/widgets/Utils/snackbar.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  LoginSignUpState createState() => LoginSignUpState();
}

class LoginSignUpState extends State<LoginSignUp> {
  final PageController _pageController = PageController(keepPage: true);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthenticationBloc ab = Provider.of<AuthenticationBloc>(context);
    NavigationBloc nb = Provider.of<NavigationBloc>(context);

    return OcyScaffold(
      enableSelection: false,
      body: Center(
        child: SizedBox(
          height: size.width < 600 ? size.height : size.height * 0.8,
          width: size.width < 600 ? size.width : size.width * 0.9,
          child: Card(
            elevation: 15,
            shape: size.width < 600
                ? null
                : RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
            child: size.width < 600
                ? loginWidget(size, ab, nb, true)
                : size.width < 1000
                    ? introWidgets(size, true, ab: ab, nb: nb)
                    : Row(
                        children: [
                          introWidgets(size, false),
                          loginWidget(size, ab, nb, false),
                        ],
                      ),
          ),
        ),
      ),
    );
  }

  introWidgets(Size size, bool isMobile,
      {AuthenticationBloc? ab, NavigationBloc? nb}) {
    return SizedBox(
      width: isMobile
          ? size.width < 600
              ? size.width
              : size.width * 0.9
          : size.width * 0.45,
      height: size.width < 600 ? size.height : size.height * 0.8,
      child: Stack(
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: [
              const LoginIntroPage(
                title: "Welcome",
                subtitle: 'to the gateway of infinite possibilities',
                imagePath: "assets/images/welcome.jpg",
              ),
              const LoginIntroPage(
                title: "Events",
                subtitle: 'Gain access to exclusive events and tech fests',
                imagePath: "assets/images/events.jpg",
              ),
              //https://unsplash.com/@jannerboy62
              const LoginIntroPage(
                title: "Projects",
                subtitle:
                    'Manage all your teams and contributions in one place',
                imagePath: "assets/images/teams.jpg",
              ),
              if (isMobile) loginWidget(size, ab!, nb!, true),
            ],
          ),
          Positioned(
            top: 15,
            right: 30,
            child: StepProgressIndicator(
              totalSteps: isMobile ? 4 : 3,
              currentStep: _currentPage + 1,
              size: 4,
              padding: 0.5,
              selectedColor: Colors.amberAccent,
              unselectedColor: Colors.white,
              roundedEdges: const Radius.circular(10),
              onTap: (int index) {
                return () {
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                  );
                };
              },
              direction: Axis.vertical,
            ),
          ),
        ],
      ),
    );
  }

  loginWidget(
      Size size, AuthenticationBloc ab, NavigationBloc nb, bool isMobile) {
    return SizedBox(
      width: isMobile
          ? size.width < 600
              ? size.width
              : size.width * 0.9
          : size.width * 0.45 - 8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/ocy_logo.png",
            height: 150,
            width: 150,
          ),
          RichText(
            text: TextSpan(
              text: "{",
              style: TextStyle(
                fontSize: size.width < 1100 && size.width > 900 ? 22 : 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: " Open ",
                  style: TextStyle(
                    fontSize: size.width < 1100 && size.width > 900 ? 22 : 28,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade700,
                    fontFamily: "PublicSans",
                  ),
                ),
                TextSpan(
                  text: "Codeyard ",
                  style: TextStyle(
                    fontSize: size.width < 1100 && size.width > 900 ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PublicSans",
                    color: Colors.black,
                  ),
                ),

                TextSpan(
                  text: "} ;",
                  style: TextStyle(
                    fontSize: size.width < 1100 && size.width > 900 ? 22 : 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Your journey to open source development starts here",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "PublicSans",
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(15),
              ).copyWith(
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    // if the button is pressed the elevation is 10.0, if not
                    // it is 5.0
                    if (states.contains(MaterialState.pressed)) {
                      return 5.0;
                    }
                    return 10.0;
                  },
                ),
              ),
              onPressed: () {
                if (ab.inProgress) {
                  showToast("Please wait. Login in progress");
                  return;
                }
                ab.authWithGoogle(nb,false);
              },
              icon: !isMobile && ab.isGoogleSignInOngoing
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/google_logo.png",
                          width: 30,
                          height: 30,
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff87ceeb),
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      "assets/images/google_logo.png",
                      width: 30,
                      height: 30,
                    ),
              label: const Text(
                "Continue with Google",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(15),
              ).copyWith(
                elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                    // if the button is pressed the elevation is 10.0, if not
                    // it is 5.0
                    if (states.contains(MaterialState.pressed)) {
                      return 5.0;
                    }
                    return 10.0;
                  },
                ),
              ),
              onPressed: () {
                if (ab.inProgress) {
                  showToast("Please wait. Login in progress");
                  return;
                }
                ab.authWithGithub(context, nb,false);
              },
              icon: !isMobile && ab.isGithubSignInOngoing
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          "assets/images/github_logo.png",
                          width: 30,
                          height: 30,
                        ),
                        const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff87ceeb),
                          ),
                        ),
                      ],
                    )
                  : Image.asset(
                      "assets/images/github_logo.png",
                      width: 30,
                      height: 30,
                    ),
              label: const Text(
                "Continue with Github",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
