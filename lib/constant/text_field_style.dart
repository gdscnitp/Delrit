import 'package:flutter/material.dart';

InputDecoration kTextFieldStyle(
    {Icon? prefixIcon, Widget? suffixIcon, String? label, String? hint}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    labelText: label,
    filled: true,
    fillColor: Colors.white,
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
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.blue.shade300,
        width: 2,
      ),
    ),
    contentPadding: const EdgeInsets.all(15),
    hintText: hint,
  );
}
