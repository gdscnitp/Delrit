import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/getit.dart';
import 'package:ride_sharing/route_generator.dart';
import 'package:flutter/material.dart';

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Flutter UI',
      initialRoute: '/test',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: const Color(0xFF252525),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF2C2C2C),
        accentColor: config.Colors().mainDarkColor(1),
        hintColor: config.Colors().secondDarkColor(1),
        focusColor: config.Colors().accentDarkColor(1),
        textTheme: TextTheme(
          button: const TextStyle(color: Color(0xFF252525)),
          headline1: TextStyle(
              fontSize: 20.0, color: config.Colors().secondDarkColor(1)),
          headline2: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          headline4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainDarkColor(1)),
          headline5: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondDarkColor(1)),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondDarkColor(1)),
          subtitle2: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainDarkColor(1)),
          bodyText1: TextStyle(
              fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondDarkColor(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().secondDarkColor(0.7)),
        ),
      ),
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: config.Colors().mainColor(1),
        brightness: Brightness.light,
        accentColor: config.Colors().mainColor(1),
        focusColor: config.Colors().accentColor(1),
        hintColor: config.Colors().secondColor(1),
        textTheme: TextTheme(
          button: const TextStyle(color: Colors.white),
          headline1:
              TextStyle(fontSize: 20.0, color: config.Colors().secondColor(1)),
          headline2: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          headline4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().mainColor(1)),
          headline5: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().secondColor(1)),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.Colors().secondColor(1)),
          subtitle2: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainColor(1)),
          bodyText1:
              TextStyle(fontSize: 12.0, color: config.Colors().secondColor(1)),
          bodyText2: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          caption: TextStyle(
              fontSize: 12.0, color: config.Colors().secondColor(0.6)),
        ),
      ),
    );
  }
}
