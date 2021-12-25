import 'package:flutter/cupertino.dart';
import 'package:ride_sharing/provider/base_model.dart';

class UserProfileViewModel extends BaseModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  void clear() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    genderController.clear();
    ageController.clear();
    notifyListeners();
  }

  void save() {
    print(nameController.text);
    print(phoneController.text);
    print(emailController.text);
    print(genderController.text);
    print(ageController.text);
    print(addressController.text);
  }
}
