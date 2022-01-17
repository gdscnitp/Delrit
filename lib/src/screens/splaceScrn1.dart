import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/src/screens/splashScrn2.dart';
import 'package:ride_sharing/src/widgets/SlideRightRoute.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: SplaceScreen1(),
//   ));
// }

class SplaceScreen1 extends StatefulWidget {
  const SplaceScreen1({Key? key}) : super(key: key);

  @override
  State<SplaceScreen1> createState() => _SplaceScreen1State();
}

class _SplaceScreen1State extends State<SplaceScreen1> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      // () => Navigator.of(context).pushReplacementNamed('/splace2'),
      () => Navigator.pushReplacement(
          context, SlideRightRoute(widget: SplaceScreen2())),
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
              child: Text(
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
