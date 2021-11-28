import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

        try {
          userUid = user!.uid;

          userDb.collection('users').doc(userUid).set(
              {"id": userUid, "name": user.displayName, "email": user.email});

          Navigator.of(context).pushNamed('/');
        } catch (e) {
          Fluttertoast.showToast(msg: 'user is not signed in');
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
                          Navigator.of(context).pushNamed('/');
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

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    //value has data of authenticated user
    return await _auth.signInWithCredential(credential).then((value) {
      user = value.user!;

      userUid = _auth.currentUser!.uid;

      userDb
          .collection('users')
          .doc(userUid)
          .set({"id": userUid, "name": user.displayName, "email": user.email});
    });
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
