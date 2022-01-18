import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';
import 'package:ride_sharing/src/models/user.dart';
import 'package:ride_sharing/src/screens/user_profile/user_profile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final String? userId = FirebaseAuth.instance.currentUser?.uid;
  UserProfileModel? userProfile;

  void getUserData() async {
    if (userId == null) return;
    var data = (await db.collection("users").doc(userId).get()).data();
    setState(() {
      userProfile = userProfileFromJson(data);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Widget _createHeader(BuildContext context) {
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 8.0),
      child: Column(
        children: [
          userProfile?.profile == null
              ? Image.asset(
                  "assets/images/user_img.png",
                  height: getProportionateScreenHeight(100),
                )
              : CircleAvatar(
                  radius: getProportionateScreenWidth(50),
                  backgroundColor: Theme.of(context).primaryColor,
                  // backgroundImage: NetworkImage(userProfile!.profile),
                  foregroundImage: NetworkImage(userProfile!.profile),
                ),
          const SizedBox(height: 8.0),
          Text(
            userProfile?.name ?? "",
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {IconData? icon, required String text, GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          _createDrawerItem(
            icon: Icons.contacts,
            text: 'My Profile',
            onTap: () {
              Navigator.of(context).pushNamed('/user-profile');
            },
          ),
          _createDrawerItem(
              icon: Icons.location_on,
              text: 'Your planned rides',
              onTap: () {}),
          _createDrawerItem(
              icon: Icons.face, text: 'Your past rides', onTap: () {}),
          const Divider(),
          _createDrawerItem(
              icon: Icons.help_center, text: 'Your vehicle info', onTap: () {}),
          _createDrawerItem(
              icon: Icons.payments, text: 'Payments', onTap: () {}),
          _createDrawerItem(
            icon: Icons.logout,
            text: 'Log out',
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(
                  80,
                ),
              ),
              child: Text(
                'App Version 1.0.0',
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
