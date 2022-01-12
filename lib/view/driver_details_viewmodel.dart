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
    print(
        "Rider: ${FirebaseAuth.instance.currentUser?.uid ?? "ddddddddddddddddddddd"}");
    print("Driver: ${driverInfo?.id}");
    print("Rideid: ${currentRideId}");
    print("DriveId: ${driver?.docId}");

    var data = (await db
            .collection("trips")
            .where("driver.driveId", isEqualTo: driver!.docId)
            .get())
        .docs;
    print(data);
    String tripId;
    if (data.isEmpty) {
      tripId = (await db.collection("trips").add({
        "driver": {
          "driveId": driver!.docId,
          "driverStatus": "pending",
          "driverUid": driverInfo?.id,
        },
        "riders": [
          {
            "riderUid": FirebaseAuth.instance.currentUser?.uid,
            "riderStatus": "confirmed",
            "rideId": currentRideId,
          }
        ]
      }))
          .id;
      print(tripId);
      print("added in db");
      prefs.setRideId(tripId);
    } else {
      tripId = data[0].id;
      await db.collection("trips").doc(data[0].id).update({
        "riders": FieldValue.arrayUnion([
          {
            "riderUid": FirebaseAuth.instance.currentUser?.uid,
            "riderStatus": "pending",
            "rideId": currentRideId,
          }
        ])
      });
      print(data[0].id);
      print("already in db");
      prefs.setRideId(data[0].id);
    }

    Map<String, dynamic> body = {
      "tripId": tripId,
      "driverUid": driverInfo?.id,
      "riderUid": FirebaseAuth.instance.currentUser!.uid,
    };

    final ApiResponse response =
        await apiService.sendRequestNotificationToDriver(body);
  }

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }
}
