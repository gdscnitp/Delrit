import 'dart:async';
import 'package:ride_sharing/config/app_config.dart' as config;

import 'package:flutter/material.dart';
import 'package:ride_sharing/src/screens/splaceScrn1.dart';
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
      // () => Navigator.pushReplacementNamed(context, '/splace1'),
      () => Navigator.pushReplacement(
          context, SlideRightRoute(widget: SplaceScreen1())),
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
