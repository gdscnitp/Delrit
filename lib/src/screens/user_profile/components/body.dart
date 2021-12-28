import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'custom_model_sheet.dart';
import 'profile_widget.dart';
import 'itemrow_widget.dart';
import 'package:ride_sharing/view/user_profile_viewmodel.dart';
import 'stars_column_widget.dart';

void _showModalSheet(BuildContext context, UserProfileViewModel model) {
  showModalBottomSheet<dynamic>(
      context: context,
      isScrollControlled: true,
      builder: (builder) {
        return Container(
          height: App(context).appHeight(75),
          child: CustomModelSheet(
            model: model,
          ),
        );
      });
}

Widget Body(BuildContext context, UserProfileViewModel model) {
  return Column(
    //physics: const BouncingScrollPhysics(),
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(height: getProportionateScreenHeight(15)),
      ProfileWidget(
        imagePath: 'assets/images/user_img.png',
        onClicked: () {
          _showModalSheet(context, model);

          ///Fetch the data
        },
      ),
      SizedBox(height: getProportionateScreenHeight(20)),
      Text(
        model.nameController.text,
        style: Theme.of(context).textTheme.headline1,
      ),
      SizedBox(height: getProportionateScreenHeight(20)),
      itemRow(
          context: context,
          parameter: 'Email : ',
          value: model.emailController.text),
      SizedBox(height: getProportionateScreenHeight(20)),
      itemRow(
          context: context,
          parameter: 'Phone : ',
          value: model.phoneController.text),
      SizedBox(height: getProportionateScreenHeight(20)),
      itemRow(
          context: context,
          parameter: 'Gender : ',
          value: model.genderController.text),
      SizedBox(height: getProportionateScreenHeight(20)),
      itemRow(
          context: context,
          parameter: 'Age : ',
          value: model.ageController.text),
      SizedBox(height: getProportionateScreenHeight(24)),
      starsColumnWidget(starscount: 5, type: 'Your ride stars'),
      SizedBox(height: getProportionateScreenHeight(24)),
      starsColumnWidget(starscount: 4, type: 'Your drive stars'),
    ],
  );
}
