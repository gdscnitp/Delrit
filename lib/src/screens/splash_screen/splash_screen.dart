import 'dart:async';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:flutter/material.dart';
import 'package:ride_sharing/src/screens/welcome_screen/welcome_screen.dart';
import 'package:ride_sharing/src/widgets/SlideRightRoute.dart';
import 'package:ride_sharing/src/widgets/text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 1),
      // () => Navigator.pushReplacementNamed(context, '/splace'),
      () => Navigator.pushReplacement(
<<<<<<< HEAD:lib/src/screens/splash_screen.dart
        context,
        SlideRightRoute(
          widget: const SplashScreen1(),
        ),
      ),
=======
          context, SlideRightRoute(widget: WelcomeScreen())),
>>>>>>> 10106e17894fa8af22083bebf3ef8bc743eb6681:lib/src/screens/splash_screen/splash_screen.dart
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: config.ThemeColors().backgroundDarkColor(1),
      body: Center(
        child: Container(
          child:
              Helper.text('Ride Share', 30, 0, Colors.white, FontWeight.bold),
        ),
      ),
    );
  }
}
