// import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}
