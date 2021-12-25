import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

Widget resuableButton(
    {required String text,
    required VoidCallback onPress,
    required Color? buttoncolor}) {
  return ElevatedButton(
    onPressed: onPress,
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 20,
      ),
    ),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(40),
        vertical: getProportionateScreenHeight(10),
      ),
      primary: buttoncolor ?? buttoncolor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
