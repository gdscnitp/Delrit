import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_services.dart';

class LoginViewModel extends BaseModel {
  final ApiService _apiService = ApiService();

  final _auth = FirebaseAuth.instance;
  final userDb = FirebaseFirestore.instance;

  TextEditingController phoneNum = TextEditingController();
  TextEditingController otpC = TextEditingController();

  var user;
  var userUid;

  Future signInWithNumber(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      //for android only
      phoneNumber: '+91' + phoneNum.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential result = await _auth.signInWithCredential(credential);
        User? user = result.user;

        print("===================================================");

        try {
          userUid = user!.uid;
          String? token = await FirebaseMessaging.instance.getToken();

          userDb.collection('users').doc(userUid).set({
            "id": userUid,
            "name": user.displayName,
            "email": user.email,
            "tokens": FieldValue.arrayUnion([token]),
          });
          AppConstant.showSuccessToast("Login Successful");

          Navigator.of(context).pushNamed('/');
        } catch (e) {
          AppConstant.showFailToast(e.toString());
        }
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },

      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Enter OTP'),
                content: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.grey,
                      ),
                      controller: otpC,
                    )
                  ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        final code = otpC.text;
                        AuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verificationId, smsCode: code);
                        UserCredential result =
                            await _auth.signInWithCredential(credential);
                        User? user = result.user;
                        if (user != null) {
                          String? token =
                              await FirebaseMessaging.instance.getToken();

                          userDb.collection('users').doc(user.uid).set({
                            "id": user.uid,
                            "name": user.displayName,
                            "email": user.email,
                            "tokens": FieldValue.arrayUnion([token]),
                          });
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/complete-profile',
                              (Route<dynamic> route) => false);
                          print('successfully  signed in');
                        } else {
                          Fluttertoast.showToast(msg: 'error signing in');
                        }
                      },
                      child: const Text('Verify'))
                ],
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    //value has data of authenticated user
    final UserCredential userCred =
        await _auth.signInWithCredential(credential);
    final User? user = userCred.user;

    if (user != null) {
      DocumentSnapshot userCheck =
          await userDb.collection("users").doc(user.uid).get();
      if (userCheck.exists) {
        print("user existssssssssssssssssss");
        navigationService.navigateTo("/access-permission",
            withreplacement: true);
      } else {
        String? token = await FirebaseMessaging.instance.getToken();
        userDb.collection('users').doc(user.uid).set({
          "id": user.uid,
          "name": user.displayName,
          "email": user.email,
          "tokens": FieldValue.arrayUnion([token])
        });
        navigationService.navigateTo(
          "/complete-profile",
          withreplacement: true,
        );
      }
      AppConstant.showSuccessToast('Successfully signed in');
    } else {
      AppConstant.showFailToast('Error signing in');
    }

    return user;
  }

  Future signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    var user = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    print(user);
  }
}

mixin MainScreenPage {}
