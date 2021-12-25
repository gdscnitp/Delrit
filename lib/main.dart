import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/getit.dart';
import 'package:ride_sharing/route_generator.dart';
import 'package:flutter/material.dart';

Future<void> saveTokenToDatabase(String? token) async {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  print("Userid: " + uid.toString());
  if (uid != null) {
    try {
      await db.collection('users').doc(uid).update({
        'tokens': FieldValue.arrayUnion([token])
      });
    } catch (e) {
      print(e);
    }
  }
}

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  setupLocator();

  String? token = await FirebaseMessaging.instance.getToken();
  print("Token: " + token.toString());
  await saveTokenToDatabase(token);
  // FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ride Sharing',
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      // darkTheme: ThemeData(
      //   // fontFamily: 'Poppins',
      //   colorScheme: const ColorScheme.dark(
      //     primary: Color(0xFF478DF4),
      //     secondary: Color(0xFFF4AE47),
      //     surface: Color(0xFFC4C4C4),
      //     background: Color(0xFF2C2C2C),
      //     error: Color(0xFFB00020),
      //     onPrimary: Colors.black,
      //     onSecondary: Colors.black,
      //     onSurface: Colors.black,
      //     onBackground: Colors.white,
      //     onError: Colors.white,
      //     brightness: Brightness.dark,
      //   ),
      //   textTheme: TextTheme(
      //     button: const TextStyle(color: Colors.white),
      //     headline1: TextStyle(
      //         fontSize: 20.0, color: config.Colors().mainDarkColor(1)),
      //     headline2: TextStyle(
      //         fontSize: 18.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.Colors().secondDarkColor(1)),
      //     headline3: TextStyle(
      //         fontSize: 20.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.Colors().mainDarkColor(1)),
      //     headline4: TextStyle(
      //         fontSize: 22.0,
      //         fontWeight: FontWeight.w700,
      //         color: config.Colors().secondDarkColor(1)),
      //     headline5: TextStyle(
      //         fontSize: 22.0,
      //         fontWeight: FontWeight.w300,
      //         color: config.Colors().mainDarkColor(1)),
      //     subtitle1: TextStyle(
      //         fontSize: 15.0,
      //         fontWeight: FontWeight.w500,
      //         color: config.Colors().secondDarkColor(1)),
      //     subtitle2: TextStyle(
      //         fontSize: 16.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.Colors().mainDarkColor(1)),
      //     bodyText1: TextStyle(
      //         fontSize: 12.0, color: config.Colors().secondDarkColor(1)),
      //     bodyText2: TextStyle(
      //         fontSize: 14.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.Colors().secondDarkColor(1)),
      //     caption: TextStyle(
      //       fontSize: 12.0,
      //       color: config.Colors().secondDarkColor(0.6),
      //     ),
      //   ),
      // ),
      theme: ThemeData(
        // fontFamily: 'Poppins',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF478DF4),
          secondary: Color(0xFFF4AE47),
          surface: Color(0xFFC4C4C4),
          background: Color(0xFFFFFFFF),
          error: Color(0xFFB00020),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          button: const TextStyle(color: Colors.white),
          headline1:
              TextStyle(fontSize: 20.0, color: config.Colors().mainColor(1)),
          headline2: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().secondColor(1)),
          headline3: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: config.Colors().mainColor(1)),
          headline4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.Colors().secondColor(1)),
          headline5: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w300,
              color: config.Colors().mainColor(1)),
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
            fontSize: 12.0,
            color: config.Colors().secondColor(0.6),
          ),
        ),
      ),
    );
  }
}
