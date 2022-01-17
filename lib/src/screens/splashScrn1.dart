import 'package:flutter/material.dart';
import 'dart:async';

import 'package:ride_sharing/src/screens/splashScrn2.dart';
import 'package:ride_sharing/src/widgets/SlideRightRoute.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({Key? key}) : super(key: key);

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
          context, SlideRightRoute(widget: SplashScreen2())),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: height / 4,
          ),
          Image.asset(
            'assets/images/splash_1.png',
            width: width,
          ),
          SizedBox(
            height: height / 10,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
            child: Container(
              child: const Text(
                'Finding companions for your rides is now easy and fast with just one post',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
