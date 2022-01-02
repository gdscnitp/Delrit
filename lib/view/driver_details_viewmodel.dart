import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/prefs_services.dart';
import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverDetailsViewModel extends BaseModel {
  bool isRideConfirmed = false;
  String? currentRideId;
  DriverModel? driver;
  UserProfileModel? driverInfo;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Prefs prefs = Prefs();
  final ApiService apiService = ApiService();

  void init(Map<String, dynamic>? args) {
    currentRideId = args?["rideId"];
    driver = args?["driver"];
    driverInfo = args?["driverInfo"];
  }

  void requestRide() async {
    print("yo");
    print(FirebaseAuth.instance.currentUser?.uid ?? "ddddddddddddddddddddd");
    print(driverInfo?.id);
    print(currentRideId);
    print(driver?.docId);

    var data = (await db
            .collection("trips")
            .where("driveId", isEqualTo: driver!.docId)
            .get())
        .docs;
    print(data);
    if (data.isEmpty) {
      String pendingRideId = (await db.collection("trips").add({
        "driverUid": driver!.docId,
        "ridersUid": [FirebaseAuth.instance.currentUser?.uid],
        "driveId": driver!.docId,
        "ridesId": [currentRideId],
        "status": "pending"
      }))
          .id;
      print(pendingRideId);
      print("added in db");
      prefs.setRideId(pendingRideId);
    } else {
      await db.collection("trips").doc(data[0].id).update({
        "ridersUid":
            FieldValue.arrayUnion([FirebaseAuth.instance.currentUser?.uid]),
        "ridesId": FieldValue.arrayUnion([currentRideId]),
      });
      print(data[0].id);
      print("already in db");
      prefs.setRideId(data[0].id);
    }

    final ApiResponse response =
        await apiService.sendFirebaseNotification(driverInfo?.id ?? "");
  }

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }
}
