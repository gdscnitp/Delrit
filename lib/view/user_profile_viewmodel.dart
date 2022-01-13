import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/src/models/user.dart';

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
  String imgUrl =
      "https://firebasestorage.googleapis.com/v0/b/ride-share-a1e6e.appspot.com/o/profile_photos%2Fuser_img.png?alt=media&token=1ac398e6-0e34-417c-9cc6-652cae3b6e5b";
  late File pickedImage;

  var uid;

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    genderController.clear();
    ageController.clear();
    notifyListeners();
  }

  void init() async {
    uid = auth.currentUser?.uid;
    if (uid != null) {
      var data = await db.collection('users').doc(uid).get();

      UserProfileModel user = userProfileFromJson(data.data());
      print(user.name);
      print(user.id);
      print(user.email);
      nameController.text = user.name ?? '';
      phoneController.text = user.phone ?? '';
      emailController.text = user.email ?? '';
      genderController.text = user.gender ?? '';
      ageController.text = user.age ?? '';
      addressController.text = user.address ?? '';
      imgUrl = user.profile;
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

  Future pickImage(context) async {
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      pickedImage = File(value!.path);
      Reference reference = FirebaseStorage.instance
          .ref()
          .child('profile_photos')
          .child(uid + '.jpg');
      UploadTask task = reference.putFile(pickedImage);
      task.whenComplete(() {
        reference.getDownloadURL().then((value) {
          imgUrl = value;
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .update({"profile": imgUrl});
        });
      });
    });
  }
}
