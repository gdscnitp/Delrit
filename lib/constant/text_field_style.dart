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

InputDecoration kTextFormFieldStyle(
    {Icon? prefixIcon, Widget? suffixIcon, String? label, String? hint}) {
  return InputDecoration(
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    labelText: label,
    filled: true,
    fillColor: Colors.grey[300],
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 2,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        color: Colors.black54,
        width: 3,
      ),
    ),
    contentPadding: const EdgeInsets.all(15),
    // hintText: hint,
    labelStyle: const TextStyle(
      color: Colors.black54,
      backgroundColor: Colors.white,
      fontSize: 20,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );
}
