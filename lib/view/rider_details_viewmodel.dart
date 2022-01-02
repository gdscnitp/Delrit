import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/prefs_services.dart';
import 'package:ride_sharing/src/models/riders.dart';
import 'package:ride_sharing/src/models/user.dart';

class RiderDetailsViewModel extends BaseModel {
  bool isRideConfirmed = false;
  String? currentDriveId;
  RiderModel? rider;
  UserProfileModel? riderInfo;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  Prefs prefs = Prefs();
  final ApiService apiService = ApiService();

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }

  void init(Map<String, dynamic>? args) {
    currentDriveId = args?["driveId"];
    rider = args?["rider"];
    riderInfo = args?["riderInfo"];
  }

  void requestRide(RiderModel rider) async {
    print("ffff");
    print("yo");
    print(FirebaseAuth.instance.currentUser?.uid ?? "ddddddddddddddddddddd");
    print(riderInfo?.id);
    print(currentDriveId);
    print(rider.docId);

    var data = (await db
            .collection("trips")
            .where("driveId", isEqualTo: currentDriveId)
            .get())
        .docs;
    print(data);
    if (data.isEmpty) {
      String pendingRideId = (await db.collection("trips").add({
        "driverUid": FirebaseAuth.instance.currentUser?.uid,
        "ridersUid": [riderInfo?.id],
        "driveId": currentDriveId,
        "ridesId": [rider.docId],
        "status": "pending"
      }))
          .id;
      print(pendingRideId);
      print("added in db");
      prefs.setRideId(pendingRideId);
    } else {
      await db.collection("trips").doc(data[0].id).update({
        "ridersUid": FieldValue.arrayUnion([riderInfo!.id]),
        "ridesId": FieldValue.arrayUnion([rider.docId]),
      });
      print(data[0].id);
      print("already in db");
      prefs.setRideId(data[0].id);
    }

    final ApiResponse response =
        await apiService.sendFirebaseNotification(riderInfo?.id ?? "");
  }
}
