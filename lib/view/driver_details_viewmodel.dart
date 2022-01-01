import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/drivers.dart';
import 'package:ride_sharing/src/models/user.dart';

class DriverDetailsViewModel extends BaseModel {
  bool isRideConfirmed = false;
  String? currentRideId;
  DriverModel? driver;
  UserProfileModel? driverInfo;

  void init(Map<String, dynamic>? args) {
    currentRideId = args?["rideId"];
    driver = args?["driver"];
    driverInfo = args?["driverInfo"];
  }

  void requestRide() {
    print("yo");
    print(FirebaseAuth.instance.currentUser?.uid ?? "ddddddddddddddddddddd");
    print(driverInfo?.id);
    print(currentRideId);
    print(driver?.sourceName);
  }

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }
}
