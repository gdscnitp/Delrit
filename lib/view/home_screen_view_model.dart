import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/trips.dart';

class HomeScreenViewModel extends BaseModel {
  //-----------VARIABLES----------//
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late TripsModel trip;
  final Map<String, int> users = {};
  String? currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;

  init() async {
    ///Todo: Fetch Doc from shared Preferences
    String docId = 'Qd7cMaAId31pj0C06s4A';
    var data = (await db.collection('trips').get()).docs;
    currentUser = auth.currentUser?.uid;

    trip = tripsModelFromJson(
        data.firstWhere((element) => element.id == docId).data());
  }

  void rateUsers({required String uid, required int starCount}) async {
    ///As there is no way you can add duplicate elements within an array
    ///We are storing map with extra details who has rated
    db.collection("users").doc(uid).update({
      "rating": FieldValue.arrayUnion([
        {currentUser: starCount}
      ]),
    }).then((value) {
      print("User saved to db");
    });
  }
}
