import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
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

  Widget _createHeader() {
    return DrawerHeader(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 8.0),
      child: Image.asset(
        'assets/images/user_img.png',
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
}
