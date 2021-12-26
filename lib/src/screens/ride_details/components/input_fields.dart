import 'package:flutter/material.dart';
import 'package:ride_sharing/config/app_config.dart';

Widget inputFormField(TextStyle textStyle, String hintText) {
  return SizedBox(
    child: Padding(
      padding: EdgeInsets.symmetric(
          //horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(5)),
      child: TextFormField(
        readOnly: true,
        decoration: kTextFormFieldStyle(
          hint: hintText,
          hintStyle: textStyle,
        ),
      ),
    ),
  );
}

InputDecoration kTextFormFieldStyle(
    {String? hint, required TextStyle hintStyle}) {
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 2,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.blue,
        width: 3,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    hintText: hint,
    hintMaxLines: 2,
    hintStyle: hintStyle,
  );
}
