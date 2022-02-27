import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_sharing/constant/appconstant.dart';
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

  void requestRide() async {
    print("ffff");
    print("yo");
    print(FirebaseAuth.instance.currentUser?.uid ?? "ddddddddddddddddddddd");
    print(riderInfo?.id);
    print(currentDriveId);
    print(rider?.docId);

    var data = (await db
            .collection("trips")
            .where("driver.driveId", isEqualTo: currentDriveId)
            .get())
        .docs;
    print(data);
    String tripId;
    if (data.isEmpty) {
      tripId = (await db.collection("trips").add(
        {
          "driver": {
            "driveId": currentDriveId,
            "driverUid": FirebaseAuth.instance.currentUser!.uid,
            "driverStatus": "confirmed"
          },
          "riders": [
            {
              "rideId": rider!.docId,
              "riderUid": riderInfo?.id,
              "riderStatus": "pending",
            }
          ]
        },
      ))
          .id;
      print(tripId);
      print("added in db");
      prefs.setRideId(tripId);
    } else {
      tripId = data[0].id;
      var currentRiders = data[0].data()["riders"];
      var existingRider =
          currentRiders.where((r) => r["riderUid"] == riderInfo?.id).toList();

      if (existingRider.isEmpty) {
        await db.collection("trips").doc(data[0].id).update({
          "riders": FieldValue.arrayUnion([
            {
              "rideId": rider!.docId,
              "riderUid": riderInfo?.id,
              "riderStatus": "pending",
            }
          ])
        });
        print(data[0].id);
        print("already in db");
        prefs.setRideId(data[0].id);
      }
    }

    Map<String, dynamic> body = {
      "tripId": tripId,
      "riderUid": riderInfo?.id,
      "driverUid": FirebaseAuth.instance.currentUser!.uid,
    };

    final ApiResponse response =
        await apiService.sendRequestNotificationToRider(body);

    AppConstant.showSuccessToast("Request sent successfully");
    navigationService.pop();
  }
}
