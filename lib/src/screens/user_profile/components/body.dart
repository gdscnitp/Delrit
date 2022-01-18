import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/constant/appconstant.dart';
import 'custom_model_sheet.dart';
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
      Stack(
        children: [
          ClipOval(
            child: SizedBox.fromSize(
              size: const Size.fromRadius(80), // Image radius
              child: Image.network(
                model.imgUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () async {
                await model.pickImage(context);
                AppConstant.showSuccessToast(
                    'Profile pic successfully changed');
                Navigator.pop(context);

                ///Fetch the data
              },
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
      SizedBox(height: getProportionateScreenHeight(24)),
      SizedBox(
        width: getProportionateScreenWidth(300),
        child: ElevatedButton(
          child: const Text("Edit Profile"),
          onPressed: () {
            _showModalSheet(context, model);
          },
        ),
      ),
    ],
  );
}
