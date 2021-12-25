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

  final TextStyle kTextStyle = const TextStyle(
    fontSize: 19,
  );

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
    return BaseView<UserProfileViewModel>(builder: (context, model, child) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back_outlined,
            color: Theme.of(context).primaryColorDark,
          ),
          elevation: 0,
          title: Center(
            child: Text(
              'My Profile',
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        body: Column(
          //physics: const BouncingScrollPhysics(),
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            ProfileWidget(
              imagePath: 'assets/images/user_img.png',
              onClicked: () {
                _showModalSheet(context, model);
              },
            ),
            const SizedBox(height: 24),
            Text(
              'UserName',
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 24),
            itemRow(parameter: 'Email : ', value: 'newuser@gmail.com'),
            const SizedBox(height: 24),
            itemRow(parameter: 'Phone : ', value: '+91 90080050607'),
            const SizedBox(height: 24),
            itemRow(parameter: 'Gender : ', value: 'Female'),
            const SizedBox(height: 24),
            itemRow(parameter: 'Age : ', value: '35 years'),
            const SizedBox(height: 24),
            starsColumnWidget(starscount: 5, type: 'Your ride stars'),
            const SizedBox(height: 24),
            starsColumnWidget(starscount: 4, type: 'Your drive stars'),
          ],
        ),
      );
    });
  }
}
