import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'package:ride_sharing/provider/base_model.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class PhoneVerification extends BaseModel {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String verificationId = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userDb = FirebaseFirestore.instance;

  var userUid;

  signInWithPhone(BuildContext context) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91' + phoneController.text,
      verificationCompleted: (verificationCompleted) async {
        print("-----verification completed--------");
        UserCredential result =
            await _auth.signInWithCredential(verificationCompleted);
        User? user = result.user;

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
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/complete-profile', (Route<dynamic> route) => false);
          }
          AppConstant.showSuccessToast('Successfully signed in');
        } else {
          AppConstant.showFailToast('Error signing in');
        }
      },
      verificationFailed: (verificationFailed) {
        print("-----------Login Failed-------");
      },
      codeSent: (verificationId, resendingToken) {
        this.verificationId = verificationId;
        currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
        print("------code sent-----");
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
        print("-----code retrieval--------");
      },
    );
  }

  getOtpFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: const InputDecoration(
            hintText: "Enter OTP",
          ),
          controller: otpController,
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);
            signInWithPhoneAuthCredential(phoneAuthCredential, context);
          },
          child: const Text('Verify'),
        ),
      ],
    );
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    try {
      final _authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      User? user = _authCredential.user;
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/complete-profile', (Route<dynamic> route) => false);
        }
        AppConstant.showSuccessToast('Successfully signed in');
      } else {
        AppConstant.showFailToast('Error signing in');
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
