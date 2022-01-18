import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/prefs_services.dart';
import 'package:ride_sharing/src/models/trips.dart';
import 'dart:math';

class HomeScreenViewModel extends BaseModel {
  //-----------VARIABLES----------//
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late TripsModel trip;
  final Map<String, int> users = {};
  String? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  Prefs prefs = Prefs();
  String driverStatus = "";
  String docId = "";
  bool pressedOnce = false;
  String rideStatusText = "Started Ride";
  final ApiService apiService = ApiService();

  init() async {
    docId = await prefs.getMyTripId();
    print("------------------------------docId------------------------------");
    print(docId);
    driverStatus = await getRideStatus(docId);
    print(
        "------------------------------driverStatus------------------------------");
    print(driverStatus);

    // var data = (await db.collection('trips').get()).docs;
    // currentUser = auth.currentUser?.uid;

    // trip = tripsModelFromJson(
    //     data.firstWhere((element) => element.id == docId).data());
  }

  void rateUsers({required String uid, required int starCount}) async {
    ///As there is no way you can add duplicate elements within an array
    ///We are storing map with extra details who has rated
    db.collection("users").doc(uid).update({
      "rating": FieldValue.arrayUnion([
        {'time': Timestamp.now().millisecondsSinceEpoch, 'count': starCount}
      ]),
    }).then((value) {
      print("User saved to db");
    });
  }

  Future<String> getRideStatus(docId) async {
    var data = await db.collection("trips").doc(docId).get();
    var data2 = data.data();
    String status = "";
    if (data2!["rideOtp"] == "" &&
        data2["driver"]["driverStatus"] == "confirmed") {
      status = "Your next ride";
    }
    return status;
  }

  sendRideOtp(String otpcode) async {
    var body = {
      //TODO:get receiver's & senders id
      "receivers": [],
      "senderUid": "",
      "message": otpcode,
    };

    final ApiResponse response = await apiService.sendRideOtp(body);
  }

  generateAndSaveOtp() async {
    String otp = Random().nextInt(999999).toString();
    print(otp);
    await db
        .collection("trips")
        .doc(docId)
        .update({"rideOtp": otp}).then((value) {
      print("Otp saved $otp");
      pressedOnce = true;
      rideStatusText = "";
      sendRideOtp(otp);
    });

    // await db.collection("trips").doc(docId).update({"driver"["driverStatus"]: "started"}).then((value) {
    //   print("Otp saved $otp");
    //   pressedOnce = true;
    //   rideStatusText = "";
    // });
  }
}
