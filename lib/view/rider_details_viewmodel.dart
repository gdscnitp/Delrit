import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/riders.dart';

class RiderDetailsViewModel extends BaseModel {
  bool isRideConfirmed = false;
  final db = FirebaseFirestore.instance;

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }

  void requestRide(RiderModel rider) async {
    print("ffff");
    // await db.collection("pendingRide").add({
    //   "riderId": rider.uid,
    //   "riderDetails": rider.docId,
    //   "driverDetails": "",
    //   "riderStatus": "pending",
    // });
  }
}
