import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/userprofile_model.dart';

class UserProfileViewModel extends BaseModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    genderController.clear();
    ageController.clear();
    notifyListeners();
  }

  void init() async {
    String? uid = auth.currentUser?.uid;
    if (uid != null) {
      var data = await db.collection('users').doc(uid).get();

      UserProfileModel user =
          userProfileModelFromJson(json.encode(data.data()));
      print(user.name);
      print(user.id);
      print(user.email);
      nameController.text = user.name ?? '';
      phoneController.text = user.phone ?? '';
      emailController.text = user.email ?? '';
      genderController.text = user.gender ?? '';
      ageController.text = user.age ?? '';
      addressController.text = user.address ?? '';
      notifyListeners();
    }
  }

  void save(BuildContext context) {
    print(nameController.text);
    print(phoneController.text);
    print(emailController.text);
    print(genderController.text);
    print(ageController.text);
    print(addressController.text);

    String? uid = auth.currentUser?.uid;

    if (uid != null) {
      db.collection("users").doc(uid).update({
        "name": nameController.text,
        "phone": phoneController.text,
        "email": emailController.text,
        "address": addressController.text,
        "age": ageController.text,
        "gender": genderController.text
      }).then((value) {
        print("User saved to db");
        Navigator.of(context).pop();
        //Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      });
    }
  }
}
