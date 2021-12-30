import 'package:flutter/material.dart';

AppBar appBar(String text, BuildContext context) {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    centerTitle: true,
    title: Text(
      text,
      style: Theme.of(context).textTheme.headline2,
    ),
    foregroundColor: Colors.black,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  );
}
