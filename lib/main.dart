import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/community_bloc.dart';
import 'package:ocyclient/blocs/edit_profile_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/blocs/profile_bloc.dart';
import 'package:ocyclient/blocs/projects_bloc.dart';
import 'package:ocyclient/blocs/theme_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/widgets/AboutUs/about_us.dart';
import 'package:ocyclient/widgets/Auth/login_signup.dart';
import 'package:ocyclient/widgets/Community/community.dart';
import 'package:ocyclient/widgets/Home/home.dart';
import 'package:ocyclient/widgets/Milestones/milestones.dart';
import 'package:ocyclient/widgets/Profile/edit_profile.dart';
import 'package:ocyclient/widgets/Profile/profile.dart';
import 'package:ocyclient/widgets/Teams/teams.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

Future<void> configureApp() async {
  setUrlStrategy(PathUrlStrategy());
  await dotenv.load(fileName: "env");
  if (kIsWeb || Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }
  SharedPreferences sp = await SharedPreferences.getInstance();

  bool isLoggedIn = sp.getBool(Config.prefIsLoggedIn) ?? false;

  final String defaultRouteName =
      WidgetsBinding.instance.window.defaultRouteName;

  bool allowAuthenticated =
      Config.authenticatedPreventAccessRoutes.contains(defaultRouteName);
  bool allowUnauthenticated =
      Config.unauthenticatedPreventAccessRoutes.contains(defaultRouteName);
  if (isLoggedIn && allowAuthenticated) {
    SystemNavigator.routeInformationUpdated(location: '/home', replace: true);
  }
  if (!isLoggedIn && allowUnauthenticated) {
    SystemNavigator.routeInformationUpdated(location: '/home', replace: true);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureApp();
  runApp(const OCYApp());
}

class OCYApp extends StatelessWidget {
  const OCYApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
        ),
        ChangeNotifierProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
        ChangeNotifierProvider<AuthenticationBloc>(
          create: (context) => AuthenticationBloc(),
        ),
        ChangeNotifierProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
        ChangeNotifierProvider<EditProfileBloc>(
          create: (context) => EditProfileBloc(),
        ),
        ChangeNotifierProvider<ProjectsBloc>(
          create: (context) => ProjectsBloc(),
        ),
        ChangeNotifierProvider<CommunityBloc>(
          create: (context) => CommunityBloc(),
        ),
      ],
      child: GetMaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            centerTitle: false,
            elevation: 2,
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            titleTextStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontFamily: "PublicSans",
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xff0f254e),
          ),
          primaryColor: const Color(0xff0f254e),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "PublicSans",
                fontSize: 16,
              ),
            ).copyWith(
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color(0xff0f254e);
                  }
                  return Colors.black;
                },
              ),
            ),
          ),
        ),
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            centerTitle: false,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            elevation: 2,
            titleTextStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: "PublicSans",
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.accent,
          ),
          colorScheme: const ColorScheme.light(
            primary: Color(0xff0f254e),
          ),
          primaryColor: const Color(0xff0f254e),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "PublicSans",
                fontSize: 16,
              ),
            ).copyWith(
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                (states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color(0xff0f254e);
                  }
                  return Colors.white;
                },
              ),
            ),
          ),
        ),
        themeMode: ThemeMode.light,
        initialRoute: "/home",
        debugShowCheckedModeBanner: false,
        getPages: [
          GetPage(
            name: '/home',
            page: () => const HomePage(),
          ),
          GetPage(
            name: '/',
            page: () => const HomePage(),
          ),
          GetPage(
            name: '/community',
            page: () => const CommunityPage(),
          ),
          GetPage(
            name: '/about_us',
            page: () => const AboutUsPage(),
          ),
          GetPage(
            name: '/milestones',
            page: () => const MilestonesPage(),
          ),
          GetPage(
            name: '/teams',
            page: () => const TeamsPage(),
          ),
          GetPage(
            name: '/auth',
            page: () => const LoginSignUp(),
          ),
          GetPage(
            name: '/profile',
            page: () => const ProfilePage(),
          ),
          GetPage(
            name: '/editProfile',
            page: () => const EditProfilePage(),
          ),
          GetPage(
            name: '/licenses',
            page: () => LicensePage(
              applicationIcon: Image.asset("assets/images/ocy_logo.png"),
              applicationName: "Open Codeyard",
              applicationVersion: Config.appVersion,
            ),
          ),
        ],
      ),
    );
  }
}
