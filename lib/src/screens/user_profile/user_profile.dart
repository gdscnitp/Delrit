import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/user_profile_viewmodel.dart';
import 'components/custom_model_sheet.dart';
import 'components/itemrow_widget.dart';
import 'components/profile_widget.dart';
import 'components/stars_column_widget.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    final double sizedHeight = getProportionateScreenHeight(24);
    return BaseView<UserProfileViewModel>(builder: (context, model, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Theme.of(context).primaryColorDark,
            ),
          ),
          elevation: 0,
          title: Text(
            'My Profile',
            style: Theme.of(context).textTheme.headline2,
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          //physics: const BouncingScrollPhysics(),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(15)),
            ProfileWidget(
              imagePath: 'assets/images/user_img.png',
              onClicked: () {
                _showModalSheet(context, model);
              },
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              'UserName',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            itemRow(
                context: context,
                parameter: 'Email : ',
                value: 'newuser@gmail.com'),
            SizedBox(height: getProportionateScreenHeight(20)),
            itemRow(
                context: context,
                parameter: 'Phone : ',
                value: '+91 90080050607'),
            SizedBox(height: getProportionateScreenHeight(20)),
            itemRow(context: context, parameter: 'Gender : ', value: 'Female'),
            SizedBox(height: getProportionateScreenHeight(20)),
            itemRow(context: context, parameter: 'Age : ', value: '35 years'),
            SizedBox(height: getProportionateScreenHeight(24)),
            starsColumnWidget(starscount: 5, type: 'Your ride stars'),
            SizedBox(height: getProportionateScreenHeight(24)),
            starsColumnWidget(starscount: 4, type: 'Your drive stars'),
          ],
        ),
      );
    });
  }
}
