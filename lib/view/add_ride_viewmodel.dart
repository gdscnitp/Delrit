import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ride_sharing/provider/base_model.dart';

class AddRideViewModel extends BaseModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final db = FirebaseFirestore.instance;
  // final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _timeController = TextEditingController();
  // final TextEditingController _seatsController = TextEditingController();
  // final TextEditingController _priceController = TextEditingController();

  void clear() {
    nameController.clear();
    sourceController.clear();
    destinationController.clear();
    // _dateController.clear();
    // _timeController.clear();
    // _seatsController.clear();
    // _priceController.clear();
  }

  void addRideToDb(BuildContext context) async {
    var sourceCord = await locationFromAddress(sourceController.text);
    var destinationCord = await locationFromAddress(destinationController.text);
    db.collection("availableRider").add({
      "name": nameController.text,
      "source": GeoPoint(sourceCord[0].latitude, sourceCord[0].longitude),
      "destination":
          GeoPoint(destinationCord[0].latitude, destinationCord[0].longitude),
    }).then((value) => print("added"));
  }
}
