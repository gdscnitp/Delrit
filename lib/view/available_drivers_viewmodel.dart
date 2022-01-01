import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/drivers.dart';

class AvailableDriversViewModel extends BaseModel {
  //-----------VARIABLES----------//
  final FirebaseFirestore db = FirebaseFirestore.instance;
  String? currentRideId;
  List<DriverModel> availableDrivers = [];

  void init(String rideId) async {
    ///Get the list of all the available drivers and display
    currentRideId = rideId;

    var data = (await db.collection('availableDrivers').get()).docs;

    availableDrivers = data.map((e) {
      return driverModelFromJson(e.data());
    }).toList();
    notifyListeners();
  }
}
