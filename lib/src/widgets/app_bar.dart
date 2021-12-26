import 'package:flutter/material.dart';

AppBar appBar(String text, BuildContext context) {
  return AppBar(
    elevation: 0,
    title: Center(
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline2,
      ),
    ),
    foregroundColor: Colors.black,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}
