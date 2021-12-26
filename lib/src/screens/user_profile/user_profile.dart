import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/user_profile_viewmodel.dart';
import 'components/body.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);
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
        body: Body(context, model),
      );
    });
  }
}
