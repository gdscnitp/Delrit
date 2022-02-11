import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'package:ride_sharing/enum/view_state.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginViewModel extends BaseModel {
  final ApiService _apiService = ApiService();

  final _auth = FirebaseAuth.instance;
  final userDb = FirebaseFirestore.instance;

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  String verificationId = '';
  bool isLoading = false;
  bool isLoadingForOtp = false;

  init() async {
    SmsAutoFill().listenForCode;
  }

  void setLoader(bool newval) {
    isLoadingForOtp = newval;
    notifyListeners();
  }

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
        isLoadingForOtp = false;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout) {
        print("-----code retrieval--------");
      },
    );
  }

  getOtpFormWidget(context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Enter OTP",
              ),
              controller: otpController,
              keyboardType: TextInputType.number,
            ),
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
      ),
    );
  }

  OtpFillWidget(context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(30),
        vertical: getProportionateScreenHeight(200),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Form(
          child: Column(
        children: [
          Text(
            "OTP Verification",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          Text.rich(
            TextSpan(text: 'We have sent code at \n', children: [
              TextSpan(
                  text: '+91${phoneController.text}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.black87)),
              const TextSpan(text: '\n please verify'),
            ]),
            textAlign: TextAlign.center,
          ),
          buildTimer(),
          SizedBox(height: SizeConfig.screenHeight! * 0.1),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinFieldAutoFill(
              controller: otpController,
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: FixedColorBuilder(Colors.black.withOpacity(0.3)),
              ),
              currentCode: otpController.text,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) {
                if (code!.length == 6) {
                  FocusScope.of(context).unfocus();

                  otpController.text = code;
                  isLoading = true;

                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);
                  signInWithPhoneAuthCredential(phoneAuthCredential, context);
                  //FocusScope.of(context).requestFocus(FocusNode());
                  notifyListeners();
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          !isLoading
              ? ElevatedButton(
                  onPressed: () async {
                    PhoneAuthCredential phoneAuthCredential =
                        PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: otpController.text);
                    signInWithPhoneAuthCredential(phoneAuthCredential, context);
                  },
                  child: const Text('Verify'),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      )),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 45.0, end: 0.0),
          duration: const Duration(seconds: 45),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.blue),
          ),
          onEnd: () {},
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

  // Future signInWithFacebook() async {
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //   final OAuthCredential facebookAuthCredential =
  //       FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //   var user = await FirebaseAuth.instance
  //       .signInWithCredential(facebookAuthCredential);
  //   print(user);
  // }
}

mixin MainScreenPage {}
