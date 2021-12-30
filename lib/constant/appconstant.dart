import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppConstant {
  static void showSuccessToast(String msg, {int? duration, int? gravity}) {
    // Toast.show(msg, context, duration: 5, backgroundColor: Colors.green);
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static void showFailToast(String msg, {int? duration, int? gravity}) {
    // Toast.show(msg, context, duration: 5, backgroundColor: Colors.red);
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
