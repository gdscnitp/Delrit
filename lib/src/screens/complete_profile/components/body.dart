import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';

class Body extends StatelessWidget {
  final CompleteProfileViewModel model;
  Body({Key? key, required this.model}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: App(context).appWidth(10.0),
        vertical: App(context).appHeight(5),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Complete Your Profile',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: App(context).appWidth(6.0),
                      ),
                ),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                inputFormField(
                    label: 'Name',
                    controller: model.nameController,
                    Ktype: TextInputType.name,
                    error_msg: "mention your name please*"),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                inputFormField(
                    label: 'Email',
                    controller: model.emailController,
                    Ktype: TextInputType.emailAddress,
                    error_msg: "mention your email please*"),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                inputFormField(
                    label: 'Phone',
                    controller: model.phoneController,
                    Ktype: TextInputType.phone,
                    error_msg: "mention your phone no. please*"),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                DropdownButtonFormField<String>(
                  value: model.gender,
                  decoration: InputDecoration(
                    labelText: "Gender",
                    filled: true,
                    fillColor: Colors.grey[300],
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey.shade400,
                        width: 2,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.black54,
                        width: 3,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(15),
                    // hintText: hint,
                    labelStyle: const TextStyle(
                      color: Colors.black54,
                      backgroundColor: Colors.white,
                      fontSize: 20,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                  items: <String>['Male', 'Female', 'Select gender']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      child: Text(value),
                      value: value,
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null && val != 'Select gender') {
                      model.setGender(val);
                    }
                  },
                ),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                inputFormField(
                    label: 'Age',
                    controller: model.ageController,
                    Ktype: TextInputType.number,
                    error_msg: "mention your age please*"),
                SizedBox(
                  height: App(context).appHeight(4),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      model.save(context);
                    } else {
                      return;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: App(context).appWidth(20.0),
                      vertical: App(context).appHeight(1.5),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save & Continue',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
