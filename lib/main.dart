import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:ocyclient/blocs/auth_bloc.dart';
import 'package:ocyclient/blocs/community_bloc.dart';
import 'package:ocyclient/blocs/edit_profile_bloc.dart';
import 'package:ocyclient/blocs/locale_bloc.dart';
import 'package:ocyclient/blocs/navigation_bloc.dart';
import 'package:ocyclient/blocs/profile_bloc.dart';
import 'package:ocyclient/blocs/projects_bloc.dart';
import 'package:ocyclient/blocs/teams_bloc.dart';
import 'package:ocyclient/configs/config.dart';
import 'package:ocyclient/utils/app_localizations.dart';
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureApp();
  runApp(OCYApp());
}

void enableEdgeToEdge({bool enable = true}) {
  ///Necessary for edge to edge
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(systemNavigationBarColor: Colors.white),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

Future<void> configureApp() async {
  setUrlStrategy(PathUrlStrategy());
  await dotenv.load(fileName: "env");
  if (kIsWeb || Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
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

  enableEdgeToEdge();
}

class OCYApp extends StatelessWidget {
  OCYApp({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationBloc>(
          create: (context) => NavigationBloc(navigatorKey),
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
        ChangeNotifierProvider<TeamsBloc>(
          create: (context) => TeamsBloc(),
        ),
        ChangeNotifierProvider<LocaleBLoc>(
          create: (context) => LocaleBLoc(navigatorKey),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleBLoc(navigatorKey),
        builder: (context, _) => GetMaterialApp(
          navigatorKey: navigatorKey,
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
          themeMode: ThemeMode.light,
          initialRoute: "/home",
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('bn', 'IN'), //Bengali
          ],
          locale: Provider.of<LocaleBLoc>(context).currentLocale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (locale.languageCode == deviceLocale!.languageCode &&
                  locale.countryCode == deviceLocale.countryCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalization.delegate,
          ],
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
      ),
    );
  }
}
