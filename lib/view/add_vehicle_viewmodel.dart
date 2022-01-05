import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'package:ride_sharing/provider/base_model.dart';

class AddVehicleViewModel extends BaseModel {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final vehicleType = TextEditingController();
  final vehCompany = TextEditingController();
  final vehModel = TextEditingController();
  final vehNumber = TextEditingController();
  final licenseNumber = TextEditingController();

  final List<String> vehicles = [
    'Choose vehicle',
    'scooty',
    'motorcycle',
    'car'
  ];
  String selectedVeh = 'Choose vehicle';

  selectedVehicle(String value) {
    selectedVeh = value;
    notifyListeners();
  }

  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  void init(context) {
    if (uid == null || uid.toString().isEmpty) {
      AppConstant.showFailToast('Login First');
      Navigator.pop(context);
    } else {
      print('-----' + uid! + '-------');
    }
  }

  saveDataToDb(context) async {
    if (selectedVeh == 'Choose vehicle' ||
        vehCompany.text.isEmpty ||
        vehModel.text.isEmpty ||
        vehNumber.text.isEmpty ||
        licenseNumber.text.isEmpty) {
      AppConstant.showFailToast('All Fields mandatory');
      return null;
    }

    db.collection('users').doc(uid).update({
      "Vehicles": FieldValue.arrayUnion([
        {
          "Vehicle Type": selectedVeh,
          "Vehicle Company": vehCompany.text,
          "Vehicle Model": vehModel.text,
          "Vehicle Number": vehNumber.text,
          "License Number": licenseNumber.text,
        }
      ])
    });
    AppConstant.showSuccessToast('Vehicle successfully added');
    Navigator.pop(context);
  }
}
