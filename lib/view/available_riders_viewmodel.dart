import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/screens/available_riders/components/call_widget.dart';
import 'package:ride_sharing/src/screens/available_riders/components/ride_confirmed.dart';

class AvailableRidersViewModel extends BaseModel {
  bool isRideConfirmed = false;

  void rideStatus(bool newStatus) {
    isRideConfirmed = newStatus;
    notifyListeners();
  }
}
