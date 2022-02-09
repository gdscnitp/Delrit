import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/getit.dart';
import 'package:ride_sharing/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/services/navigation_service.dart';

Future<void> saveTokenToDatabase(String? token) async {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  print("Userid: " + uid.toString());
  if (uid != null) {
    await db.collection('users').doc(uid).update({
      'tokens': FieldValue.arrayUnion([token])
    });
  }
}

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Firebase.initializeApp();
  setupLocator();

  String? token = await FirebaseMessaging.instance.getToken();
  await saveTokenToDatabase(token);
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
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
      navigatorKey: getIt<NavigationService>().navigatorKey,
      title: 'Ride Sharing',
      initialRoute: '/splash',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.indigo).copyWith(
        textTheme: TextTheme(
          button: const TextStyle(color: Colors.white),

          /// Headline 1 style ---- Use it --- Do not change ----///
          headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: config.ThemeColors.mainTextColor(1),
            letterSpacing: 1,
            //overflow: TextOverflow.ellipsis,
          ),

          /// Headline 2 style ---- Use it --- Do not change ----///
          headline2: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors.mainTextColor(1)),
          headline3: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors.mainTextSecondaryColor(1)),
          headline4: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: config.ThemeColors().secondColor(1)),
          headline5: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
              color: config.ThemeColors().mainColor(1)),
          subtitle1: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: config.ThemeColors().secondColor(1)),
          subtitle2: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors().mainColor(1)),
          bodyText1: TextStyle(
            fontSize: 13,
            color: config.ThemeColors.mainTextColor(1),
          ),
          bodyText2: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors.mainTextSecondaryColor(1)),
          caption: TextStyle(
            fontSize: 10,
            color: config.ThemeColors().secondColor(0.6),
          ),
        ),
      ),

      // The material dark theme.
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.indigo).copyWith(
        textTheme: TextTheme(
          button: const TextStyle(color: Colors.white),

          /// Headline 1 style ---- Use it --- Do not change ----///
          headline1: const TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            //overflow: TextOverflow.ellipsis,
          ),

          /// Headline 2 style ---- Use it --- Do not change ----///
          headline2: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          headline3: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors.mainTextSecondaryColor(1)),
          headline4: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: config.ThemeColors().secondColor(1)),
          headline5: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.w300,
            color: Colors.white,
          ),
          subtitle1: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
              color: config.ThemeColors().secondColor(1)),
          subtitle2: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyText1: const TextStyle(
            fontSize: 15.0,
            color: Colors.white,
          ),
          bodyText2: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: config.ThemeColors.mainTextSecondaryColor(1)),
          caption: TextStyle(
            fontSize: 12.0,
            color: config.ThemeColors().secondColor(0.6),
          ),
        ),
      ),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.system,
<<<<<<< HEAD
      // theme: ThemeData(
      //   // fontFamily: 'Poppins',
      //   colorScheme: const ColorScheme.light(
      //     primary: Color(0xFF478DF4),
      //     secondary: Color(0xFFF4AE47),
      //     surface: Color(0xFFC4C4C4),
      //     background: Color(0xFFFFFFFF),
      //     error: Color(0xFFB00020),
      //     onPrimary: Colors.white,
      //     onSecondary: Colors.white,
      //     onSurface: Colors.black,
      //     onBackground: Colors.black,
      //     onError: Colors.white,
      //     brightness: Brightness.light,
      //   ),
      //   textTheme: TextTheme(
      //     button: const TextStyle(color: Colors.white),
      //
      //     /// Headline 1 style ---- Use it --- Do not change ----///
      //     headline1: TextStyle(
      //       fontSize: 21.0,
      //       fontWeight: FontWeight.w700,
      //       color: config.ThemeColors.mainTextColor(1),
      //       //overflow: TextOverflow.ellipsis,
      //     ),
      //
      //     /// Headline 2 style ---- Use it --- Do not change ----///
      //     headline2: TextStyle(
      //         fontSize: 18.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.ThemeColors.mainTextColor(1)),
      //     headline3: TextStyle(
      //         fontSize: 18.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.ThemeColors.mainTextSecondaryColor(1)),
      //     headline4: TextStyle(
      //         fontSize: 22.0,
      //         fontWeight: FontWeight.w700,
      //         color: config.ThemeColors().secondColor(1)),
      //     headline5: TextStyle(
      //         fontSize: 22.0,
      //         fontWeight: FontWeight.w300,
      //         color: config.ThemeColors().mainColor(1)),
      //     subtitle1: TextStyle(
      //         fontSize: 15.0,
      //         fontWeight: FontWeight.w500,
      //         color: config.ThemeColors().secondColor(1)),
      //     subtitle2: TextStyle(
      //         fontSize: 16.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.ThemeColors().mainColor(1)),
      //     bodyText1: TextStyle(
      //         fontSize: 15.0, color: config.ThemeColors.mainTextColor(1)),
      //     bodyText2: TextStyle(
      //         fontSize: 15.0,
      //         fontWeight: FontWeight.w600,
      //         color: config.ThemeColors.mainTextSecondaryColor(1)),
      //     caption: TextStyle(
      //       fontSize: 12.0,
      //       color: config.ThemeColors().secondColor(0.6),
      //     ),
      //   ),
      // ),
      //  home: Scaffold(
         
        
      //   body: ChatScreen(peer:UserProfileModel(name: 'Ms.Thangabali 🙋‍♀️', tokens: [], id: "2", email:'', phone: '123456778', address: 'abcd', gender: 'gender', age: 'age', profile: "profile"),),
        
      //   ),
=======
>>>>>>> b1f6be0e51abebc7dfd0c6f997f1d1e1346edb9c
    );
  }
}
