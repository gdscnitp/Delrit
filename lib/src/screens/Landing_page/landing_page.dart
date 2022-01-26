// import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ride_sharing/config/app_config.dart' as config;
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: Landing_Page(),
//   ));
// }

class Landing_Page extends StatelessWidget {
  const Landing_Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;

    return BaseView<LoginViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/image 1.png',
                    height: height / 1.35,
                    width: 500,
                    fit: BoxFit.values[0],
                  ),
                  Positioned(
                      bottom: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(60.0, 0, 60.0, 0),
                        child: Container(
                          width: 273,
                          height: 60.0,
                          child: const Text(
                            'A new way to share\nyour journey',
                            style: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                      ))
                ],
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/phone-verification');
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    'Continue with Phone Number',
                    style: TextStyle(fontFamily: 'Roboto'),
                  ),
                  color: config.ThemeColors().mainColor(1),
                  textColor: Colors.white,
                ),
              ),
              const Text(
                'Or',
                style: TextStyle(
                  fontSize: 22.0,
                  color: Color.fromRGBO(122, 73, 73, 0.72),
                ),
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: SignInButton(
                  Buttons.Google,
                  onPressed: () async {
                    User? user = await model.signInWithGoogle();
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'By continuing, you agree to our terms and conditions and privacy policy',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(122, 73, 73, 0.72)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
