import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/riders.dart';

class AvailableRidersViewModel extends BaseModel {
  //-----------VARIABLES----------//
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<RiderModel> availableRiders = [];
  String? currentDriveId;

  void init(String? driveId) async {
    ///Get the list of all the available riders and display

    // (await db.collection('availableRiders').get()).docs.map((e) async {
    //   RiderModel _currentRider = RiderModel.fromJson(e.data());
    //
    //   String time = _currentRider.time.toString();
    //   String sourceAddr = await getAddress(_currentRider.destination);
    //   String destAddr = await getAddress(_currentRider.source);
    //
    //   availableRiders.add(
    //     ResultRiderDetails(
    //       uid: _currentRider.uid,
    //       destination: '',
    //       time: time,
    //       source: '',
    //     ),
    //   );
    // });
    //
    // notifyListeners();

    currentDriveId = driveId;

    var data = (await db.collection('availableRiders').get()).docs;

    availableRiders = data.map((e) {
      return riderModelFromJson(e.data(), e.id);
    }).toList();
    notifyListeners();
  }
}
