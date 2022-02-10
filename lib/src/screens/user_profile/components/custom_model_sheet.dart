import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/widgets/place_search_text_field.dart';
import 'package:ride_sharing/view/user_profile_viewmodel.dart';

class CustomModelSheet extends StatelessWidget {
  final UserProfileViewModel model;
  CustomModelSheet({Key? key, required this.model}) : super(key: key);
  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: App(context).appWidth(10.0),
        vertical: App(context).appHeight(5),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          child: Column(
            children: [
              Text(
                'Edit Your Profile',
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: App(context).appWidth(6.0),
                    ),
              ),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Name', controller: model.nameController,Ktype:TextInputType.name,error_msg: "mention your name please*"),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Email', controller: model.emailController,Ktype:TextInputType.emailAddress,error_msg: "mention your email please*"),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Phone', controller: model.phoneController,Ktype:TextInputType.phone,error_msg: "mention your phone no. please*"),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(
                  label: 'Gender', controller: model.genderController,Ktype:TextInputType.text,error_msg: "mention your gender please*"),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              inputFormField(label: 'Age', controller: model.ageController,Ktype:TextInputType.number, error_msg: "mention your age please*"),
              SizedBox(
                height: App(context).appHeight(4),
              ),
              ElevatedButton(
                onPressed: () => model.save(context),
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
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
